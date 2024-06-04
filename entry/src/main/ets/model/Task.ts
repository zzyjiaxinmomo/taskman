export enum TaskType { Work = 1, Study = 2, Play = 3, Others = 4 }

export default class Task {
  constructor(name: string, details: string, type: TaskType, update: string, progress: number) {
    this.name = name
    this.details = details
    this.type = type
    this.update = update
    this.progress = progress
  }

  name: string
  details: string
  type: TaskType
  update: string
  progress: number
}

export const TaskTypeColor: { [key in TaskType]: string } = {
  [TaskType.Work]: '#FF5733',
  [TaskType.Study]: '#66CCFF',
  [TaskType.Play]: '#33CC99',
  [TaskType.Others]: '#CCCCCC'
};

export const TaskTypeName: { [key in TaskType]: string } = {
  [TaskType.Work]: '工作',
  [TaskType.Study]: '学习',
  [TaskType.Play]: '娱乐',
  [TaskType.Others]: '其他',
}