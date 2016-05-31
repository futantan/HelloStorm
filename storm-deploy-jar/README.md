## 步骤

### 将代码打包

`mvn clean install`

### 将代码部署到 storm 中

`storm jar pathToJar.jar package.className arg1 arg2 arg3`

其中的 `package.className` 为 main 方法的入口，随后是传入的参数
