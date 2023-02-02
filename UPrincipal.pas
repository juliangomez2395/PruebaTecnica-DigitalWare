unit UPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ExtCtrls;

type
  TFRM_PRINCIPAL = class(TForm)
    MainMenu1: TMainMenu;
    asdasdad1: TMenuItem;
    SerieFibonacci1: TMenuItem;
    CalculoSalarioSemanal1: TMenuItem;
    Imagen02: TImage;
    ManejoBasesdeDatos1: TMenuItem;
    Clientes1: TMenuItem;
    Productos1: TMenuItem;
    DetalleFactura1: TMenuItem;
    CabezaFactura1: TMenuItem;
    procedure SerieFibonacci1Click(Sender: TObject);
    procedure CalculoSalarioSemanal1Click(Sender: TObject);
    procedure CRUDClientesManejodebasededatos1Click(Sender: TObject);
    procedure CRUDProductos1Click(Sender: TObject);
    procedure Clientes1Click(Sender: TObject);
    procedure Productos1Click(Sender: TObject);
    procedure DetalleFactura1Click(Sender: TObject);
    procedure CabezaFactura1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FRM_PRINCIPAL: TFRM_PRINCIPAL;

implementation

uses USerieFibonacci, UCalculoSalarioSemanal, UCrudClientes,
  UCrudProductos, UDataModul, UCrudDetalleFactura, UCrudCabezaFactura;

{$R *.dfm}

procedure TFRM_PRINCIPAL.SerieFibonacci1Click(Sender: TObject);
begin
   FrmSerieFibonacci := TFrmSerieFibonacci.create(application);

  try
    FrmSerieFibonacci.Show;
  except
    FrmSerieFibonacci.free;
  end;
end;

procedure TFRM_PRINCIPAL.CalculoSalarioSemanal1Click(Sender: TObject);
begin
  FrmCalculoSalarioSemanal := TFrmCalculoSalarioSemanal.create(application);

  try
    FrmCalculoSalarioSemanal.Show;
  except
    FrmCalculoSalarioSemanal.free;
  end;
end;

procedure TFRM_PRINCIPAL.CRUDClientesManejodebasededatos1Click(
  Sender: TObject);
begin
  FrmCrudClientes := TFrmCrudClientes.create(application);

  try

    FrmCrudClientes.Show;
  except
    FrmCrudClientes.free;
  end;
end;

procedure TFRM_PRINCIPAL.CRUDProductos1Click(Sender: TObject);
begin

  FrmCrudProductos := TFrmCrudProductos.create(application);

  try

    FrmCrudProductos.Show;
  except
    FrmCrudProductos.free;
  end;

end;

procedure TFRM_PRINCIPAL.Clientes1Click(Sender: TObject);
begin
  FrmCrudClientes := TFrmCrudClientes.create(application);

  try

    FrmCrudClientes.Show;
  except
    FrmCrudClientes.free;
  end;
end;

procedure TFRM_PRINCIPAL.Productos1Click(Sender: TObject);
begin
   FrmCrudProductos := TFrmCrudProductos.create(application);

  try

    FrmCrudProductos.Show;
  except
    FrmCrudProductos.free;
  end;
end;

procedure TFRM_PRINCIPAL.DetalleFactura1Click(Sender: TObject);
begin
   FrmCrudDetalleFactura := TFrmCrudDetalleFactura.create(application);

  try

    FrmCrudDetalleFactura.Show;
  except
    FrmCrudDetalleFactura.free;
  end;
end;

procedure TFRM_PRINCIPAL.CabezaFactura1Click(Sender: TObject);
begin

  FrmCrudCabezaFactura := TFrmCrudCabezaFactura.create(application);

  try

    FrmCrudCabezaFactura.Show;
  except
    FrmCrudCabezaFactura.free;
  end;

end;

end.
