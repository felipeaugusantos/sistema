unit untCadFarMontadoras;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons,
  ExtCtrls, Uni, DB, Mask, DBCtrls, DBEditFocus, UniDataSetProvider, UniClientDataSet,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadFarMontadoras = class(TfrmPaiCad)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    dbeDescri: TDBEditFocus;
    dbeCodMon: TDBEditFocus;
    pnlCabecalho: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
  private
    qryCadMon : TUniQuery;
    dtsCadMon : TDataSource;
    procedure pAjustaTabelas;
    procedure pCriaDataSet;
  protected
    procedure pInicializaIndices; override;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadFarMontadoras: TfrmCadFarMontadoras;

implementation

uses untFuncoesSimples, untPai, untConsultas, untTypesSistema;

{$R *.dfm}

{ TfrmCadFarMontadoras }

procedure TfrmCadFarMontadoras.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('FAR_CODMON');
  stlCampos.Add('FAR_DESMON'); //FAR_DESCRI
  stlCampos.Add('FAR_CODEMP');
  stlCampos.Add('AUTOINCREM');


  stlCamInd.Add('FAR_CODMON');
  stlCamInd.Add('FAR_DESMON'); //FAR_DESCRI

  stlDesInd.Add('Codigo');
  stlDesInd.Add('Descrição');
end;

procedure TfrmCadFarMontadoras.FormCreate(Sender: TObject);
begin
  inherited;

  pCriaDataSet;
  pAjustaTabelas;
  qryTabela := qryCadMon;

  strNomeTabela := 'FAR_CADMON';
  strNomeCampo  := 'AUTOINCREM';

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodMon;
end;

procedure TfrmCadFarMontadoras.btnPesquisaClick(Sender: TObject);
  var
    arrSel: TConsultasArray;
    Key: Char;
begin
  pAjustaTabelas;
  Key := '/';
  if fPesqMontadoraTinta(Self, conFar, Nil, Nil, qryTabela, Key, arrSel) then
    pSetFocus(btnAlterar);
end;

procedure TfrmCadFarMontadoras.pAjustaTabelas;
  Var
    intRecNo : Integer;
begin
  intRecNo := qryCadMon.RecNo;
  qryCadMon.Close;
  qryCadMon.Open;
  qryCadMon.FieldByName('FAR_CODMON').DisplayLabel := 'Código';
  qryCadMon.FieldByName('FAR_DESMON').DisplayLabel := 'Montadora'; //FAR_DESCRI
  qryCadMon.FieldByName('FAR_CODEMP').Visible := False;
  qryCadMon.FieldByName('AUTOINCREM').Visible := False;
  qryCadMon.RecNo := intRecNo;
end;


procedure TfrmCadFarMontadoras.pCriaDataSet;
  Var
    intCont : Integer;
begin
  qryCadMon := fCriaQuery(Self);
  qryCadMon.SQL.Text := 'SELECT * FROM FAR_CADMON';
  qryCadMon.Open;

  dtsCadMon := fCriaDataSource(qryCadMon);

  For intCont := 0 To Self.ComponentCount -1 Do
  Begin
    If Components[intCont] is TDBEditFocus Then
      (Components[intCont] as TDBEditFocus).DataSource := dtsCadMon;
  End;

  dbeCodMon.DataField := 'FAR_CODMON';
  dbeDescri.DataField := 'FAR_DESMON'; //FAR_DESCRI

end;

procedure TfrmCadFarMontadoras.btnIncluirClick(Sender: TObject);
begin
  inherited;
  blnUsaProCodigo := False;
  
  If qryCadMon.State = dsInsert Then
    pSetFocus(dbeCodMon);
end;

end.

