program PruebaTecnica;

uses
  Forms,
  UPrincipal in 'UPrincipal.pas' {FRM_PRINCIPAL},
  USerieFibonacci in 'USerieFibonacci.pas' {FrmSerieFibonacci},
  UCalculoSalarioSemanal in 'UCalculoSalarioSemanal.pas' {FrmCalculoSalarioSemanal},
  UDataModul in 'UDataModul.pas' {DataModule1: TDataModule},
  UCrudClientes in 'UCrudClientes.pas' {FrmCrudClientes},
  UCrudProductos in 'UCrudProductos.pas' {FrmCrudProductos},
  UCrudCabezaFactura in 'UCrudCabezaFactura.pas' {FrmCrudCabezaFactura},
  UCrudDetalleFactura in 'UCrudDetalleFactura.pas' {FrmCrudDetalleFactura};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFRM_PRINCIPAL, FRM_PRINCIPAL);
  //  Application.CreateForm(TFrmCrudCabezaFactura, FrmCrudCabezaFactura);
//  Application.CreateForm(TForm1, Form1);
  //  Application.CreateForm(TFrmCrudProductos, FrmCrudProductos);
  //Application.CreateForm(TFrmCrudClientes, FrmCrudClientes);
  //Application.CreateForm(TDataModule1, DataModule1);
  //Application.CreateForm(TFrmCalculoSalarioSemanal, FrmCalculoSalarioSemanal);
  //Application.CreateForm(TFrmSerieFibonacci, FrmSerieFibonacci);
  Application.Run;
end.
