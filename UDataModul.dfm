object DataModule1: TDataModule1
  OldCreateOrder = False
  Left = 331
  Top = 239
  Height = 456
  Width = 694
  object ConexionLocal: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=Colombia01+;Persist Security Info=T' +
      'rue;User ID=sa;Initial Catalog=PRUEBA;Data Source=192.168.20.117' +
      ';Use Procedure for Prepare=1;Auto Translate=True;Packet Size=409' +
      '6;Workstation ID=DESKTOP-FT5G8EL;Use Encryption for Data=False;T' +
      'ag with column collation when possible=False'
    IsolationLevel = ilReadCommitted
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 104
    Top = 32
  end
end
