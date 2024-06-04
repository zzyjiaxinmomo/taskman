// 数据类型定义
export class ModeType {
  id: number
  name: string

  constructor(id: number, name: string) {
    this.id = id;
    this.name = name;
  }
}

// 单个选择项的渲染
@Component
export struct ModeItem {
  private mode: ModeType = new ModeType(0, '')
  @Consume modeId: number

  constructor(mode: ModeType) {
    super()
    this.mode = mode;
  }

  @Builder
  renderModeItem(fontColor: string, bgColor: string, value: string) {
    Flex({ direction: FlexDirection.Column }) {
      Flex() {
        Text(value)
          .fontSize(16)
          .fontColor(fontColor)
      }
      .height('100%')
      .width('100%')
      .backgroundColor(bgColor)
      .borderRadius(12)
      .padding({
        left: 14,
        top: 14,
        bottom: 14
      })

      // 最后一项不显示分隔线
      if (this.mode.id != 5) {
        Flex() {
          Flex() {
          }.height(1).width('100%').backgroundColor('#F3F3F3')
        }
        .padding({
          left: 12,
          right: 12
        })
      }
    }
  }

  build() {
    Flex() {
      // 选中项和其他选项的样式有不同
      if (this.modeId == this.mode.id) {
        this.renderModeItem('#0A59F7', '#E6EEFF', this.mode.name)
      } else {
        this.renderModeItem('rgba(0,0,0,0.9)', '', this.mode.name)
      }
    }.height(48)
  }
}

// 下拉菜单组件
@Component
export struct SelectorList {
  @Consume modesData: ModeType[] // 共享父组件属性
  @Consume modeId: number // 共享父组件属性
  @Consume showSelector: boolean // 共享父组件属性

  build() {
    Flex({ direction: FlexDirection.Column, justifyContent: FlexAlign.Start }) {
      // 循环产生下拉菜单
      ForEach(this.modesData, (item: ModeType) => {
        Flex() {
          ModeItem({ mode: item })
        }
        // 为每一项绑定点击事件
        .onClick(() => {
          if (this.modeId !== item.id) {
            this.modeId = item.id
            console.info('this.modeId===' + this.modeId)
          }
          this.showSelector = false
        })

      }, (item: ModeType) => item.id.toString())
    }
    .height(`calc(48vp * ${this.modesData.length})`)
    .width('100%')
    .backgroundColor('#fff')
    .borderRadius(16)
    .shadow({
      radius: 50,
      color: 'rgba(0,0,30,0.1500)'
    })
    .padding({
      left: 4,
      right: 4,
      top: 4,
      bottom: 4
    })
    .position({
      x: 0,
      y: -100
    })
    .zIndex(1)
  }
}

@Entry
@Component
struct SelectorIndex {
  @Provide showSelector: boolean = false // 是否展开下拉菜单
  @Provide modesData: ModeType[] =
    [
      new ModeType(1, '节能模式'),
      new ModeType(2, '强劲模式'),
      new ModeType(3, '深层模式'),
      new ModeType(4, '清洁模式'),
      new ModeType(5, '敏感模式'),
    ]
  @Provide modeId: number = 0 // 当前选中项id

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
    Flex({ direction: FlexDirection.Column, justifyContent: FlexAlign.Center, alignItems: ItemAlign.Center }) {
      Flex({ direction: FlexDirection.Column, alignItems: ItemAlign.Center }) {
        if (this.showSelector) {
          SelectorList()
        }
        Flex({ justifyContent: FlexAlign.SpaceBetween, alignItems: ItemAlign.Center }) {
          Column() {
            Text('任务类型选择')
              .fontSize(12)
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
        .backgroundColor('#fff')
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
    }
    .height('100%')
    .width('100%')
    .backgroundColor('#f1f3f5')
    .padding({
      left: 12,
      right: 12,
      top: 16,
      bottom: 16
    })
    .onClick(() => {
      this.showSelector = false
    })
  }
}