import Task, { TaskType } from '../model/Task'
import { SelectorList, ModeType } from '../common/components/Selector'

@Entry
@Component
@CustomDialog
export default struct AddTask {
  @Provide showSelector: boolean = false // 是否展开下拉菜单
  @Provide modesData: ModeType[] =
    [
      new ModeType(TaskType.Work, '工作'),
      new ModeType(TaskType.Study, '学习'),
      new ModeType(TaskType.Play, '娱乐'),
      new ModeType(TaskType.Others, '其他'),
    ]
  @Provide modeId: number = TaskType.Work // 任务类别
  @State taskName: string = '' //任务名
  @State taskDetails: string = '' // 任务详细说明
  ctrl?: CustomDialogController
  onConfirm?: (name: string, details: string, type: TaskType) => void
  private maxLength = 100

  // 获取选中项的内容
  getSelectedText() {
    const selectedItem = this.modesData.find(item => {
      return item.id == this.modeId
    })
    if (selectedItem) {
      return selectedItem.name
    }
    return ''
  }

  build() {
    Column({ space: 10 }) {
      Text('添加任务')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
      TextInput({ placeholder: '输入任务名', text: this.taskName })
        .onChange((value) => { //输入框变化时，更新任务名
          this.taskName = value
        })
      TextArea({ placeholder: '输入任务描述，最多 100 字', text: this.taskDetails })
        .maxLines(3)
        .onChange((value) => {
          const newlineCount = (value.match(/\n/g) || []).length;
          if (value.length >= this.maxLength || newlineCount >= 3) {
            if (value.lastIndexOf('\n') === value.length - 1) {
              this.taskDetails = value
              this.taskDetails = this.taskDetails.replace(/(\n)+$/, '')
            }
            return
          }
          this.taskDetails = value
        })
      Flex({ direction: FlexDirection.Column, alignItems: ItemAlign.Center }) {
        if (this.showSelector) {
          SelectorList()
        }
        Flex({ justifyContent: FlexAlign.SpaceBetween, alignItems: ItemAlign.Center }) {
          Column() {
            Text('任务类型选择')
              .fontSize(this.getSelectedText() ? $r('app.float.text_font') : 16)
              .fontColor('rgba(0, 0, 0, 0.6)')
            if (this.getSelectedText()) {
              Text(this.getSelectedText())
                .fontSize(16)
                .alignSelf(ItemAlign.Start)
                .margin({
                  top: 2
                })
            }
          }

          Column() {
            Flex() {
              Image($r('app.media.task_type'))
                .objectFit(ImageFit.Contain)
            }
            .height(24)
            .width(24)
          }
        }
        .height(64)
        .width('100%')
        .backgroundColor('#0C182431')
        .borderRadius(16)
        .padding({
          left: 16,
          right: 16
        })
        .onClick(() => {
          this.showSelector = !this.showSelector;
          console.log('showSelector===' + this.showSelector)
        })
      }
      .height(64)
      .margin({
        top: 12,
        bottom: 12
      })

      Row() {
        Button('取消')
          .onClick(() => {
            this.ctrl?.close()
          })
        Blank()
        Button('确定')
          .onClick(() => {
            if (this.onConfirm) {
              this.onConfirm(
                this.taskName,
                this.taskDetails,
                this.modeId)
            }
          })
      }
      .padding(20)
      .width('100%')
      .height('10%')
    }
    .padding(20)
    .width('90%')
    .backgroundColor(Color.White)
    .borderRadius(15)
  }
}

