unit untFatTotalizadorEmpresa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass, UniClientDataSet,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, DBGridCitel,
  untFuncFat, untFuncoesSimples;

type
  TfrmFatTotalizadorEmpresa = class(TfrmPai)
    DBGridCitel1: TDBGridCitel;
    dsEmpresas: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    cdsEmpresas: TUniClientDataSet;
    procedure pCarregaEmpresas;
  public
    { Public declarations }
    cdsDados: TUniClientDataSet;
  end;

var
  frmFatTotalizadorEmpresa: TfrmFatTotalizadorEmpresa;

implementation

{$R *.dfm}

{ TfrmFatTotalizadorEmpresa }

procedure TfrmFatTotalizadorEmpresa.FormCreate(Sender: TObject);
begin
  inherited;

  cdsDados    := fCriaTemporaria(Self);
  cdsEmpresas := TUniClientDataSet.Create(Nil);
  dsEmpresas.DataSet := cdsEmpresas;

  cdsDados.IndexDefs.Add('IDX_EMPDES', 'ITE_EMPITE', []);
  cdsDados.IndexName := 'IDX_EMPDES';
end;

procedure TfrmFatTotalizadorEmpresa.FormDestroy(Sender: TObject);
begin
  inherited;

  If Assigned(cdsDados) Then
    FreeAndNil(cdsDados);

  If Assigned(cdsEmpresas) Then
    FreeAndNil(cdsEmpresas);
end;

procedure TfrmFatTotalizadorEmpresa.FormShow(Sender: TObject);
begin
  inherited;

  pCarregaEmpresas;
end;

procedure TfrmFatTotalizadorEmpresa.pCarregaEmpresas;
begin
  cdsEmpresas.FieldDefs.Add('EMPDES', ftString, 120);
  cdsEmpresas.FieldDefs.Add('VLRITE', ftFloat, 00);
  cdsEmpresas.FieldDefs.Add('VLRCON', ftFloat, 00);
  cdsEmpresas.CreateDataSet;

  TFloatField(cdsEmpresas.FieldByName('VLRITE')).DisplayFormat := '#,##0.00';
  TFloatField(cdsEmpresas.FieldByName('VLRCON')).DisplayFormat := '#,##0.00';

  cdsDados.First;
  While Not cdsDados.Eof Do
  Begin
    cdsEmpresas.Filtered := False;
    cdsEmpresas.Filter   := ' EMPDES = ' + QuotedStr(cdsDados.FieldByName('ITE_EMPITE').AsString);
    cdsEmpresas.Filtered := True;

    If cdsEmpresas.IsEmpty Then
    Begin
      cdsEmpresas.Append;
      cdsEmpresas.FieldByName('EMPDES').AsString := cdsDados.FieldByName('ITE_EMPITE').AsString;
      cdsEmpresas.FieldByName('VLRITE').AsFloat  := cdsDados.FieldByName('ITE_TOTITE').AsFloat;
      cdsEmpresas.FieldByName('VLRCON').AsFloat  := cdsDados.FieldByName('ITE_VLRCON').AsFloat;
      cdsEmpresas.Post;
    End
    Else
    Begin
      cdsEmpresas.Edit;
      cdsEmpresas.FieldByName('VLRITE').AsFloat  := cdsEmpresas.FieldByName('VLRITE').AsFloat + cdsDados.FieldByName('ITE_TOTITE').AsFloat;
      cdsEmpresas.FieldByName('VLRCON').AsFloat  := cdsEmpresas.FieldByName('VLRCON').AsFloat + cdsDados.FieldByName('ITE_VLRCON').AsFloat;
      cdsEmpresas.Post;
    End;

    cdsDados.Next;
  End;

  cdsEmpresas.Filtered := False;

  cdsEmpresas.First;
  While Not cdsEmpresas.Eof Do
  Begin
    cdsEmpresas.Edit;
    cdsEmpresas.FieldByName('EMPDES').AsString := cdsEmpresas.FieldByName('EMPDES').AsString + ' - ' + fCampoTabela('EMP_NOMEMP', 'CADEMP', ['EMP_CODEMP'], [cdsEmpresas.FieldByName('EMPDES').AsString]);
    cdsEmpresas.Post;

    cdsEmpresas.Next;
  End;
end;

end.
