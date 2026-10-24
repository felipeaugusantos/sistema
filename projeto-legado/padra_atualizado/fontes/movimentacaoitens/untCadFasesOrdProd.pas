unit untCadFasesOrdProd;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.Mask, Vcl.DBCtrls,
  DBEditFocus, Data.DB, untFuncoesSimples, untConsultas, untTypesSistema, Uni,
  untCadFasesOrdProdOrdem;

type
  TfrmCadFasesOrdProd = class(TfrmPaiCad)
    btnSequencia: TBitBtnLocked;
    Label1: TLabel;
    dbeCodigo: TDBEditFocus;
    Label2: TLabel;
    dbeDescri: TDBEditFocus;
    dbeSequencia: TDBEditFocus;
    lblSequencia: TLabel;
    dtsTabela: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnSequenciaClick(Sender: TObject);
  private
    function fRetProxSequencial: Integer;
  public
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean; override;
    procedure pInicializaIndices; override;
  end;

var
  frmCadFasesOrdProd: TfrmCadFasesOrdProd;

implementation

{$R *.dfm}

procedure TfrmCadFasesOrdProd.btnGravarClick(Sender: TObject);
begin
  If qryTabela.State = dsInsert Then
  Begin
    qryTabela.FieldByName('FAS_SEQUEN').AsInteger := fRetProxSequencial;
    qryTabela.FieldByName('FAS_CODEMP').AsString := VS_StrCodEmp;
  End;

  inherited;
end;

function TfrmCadFasesOrdProd.fRetProxSequencial: Integer;
  Var
    qryCadFas: TUniQuery;
Begin
  qryCadFas := fCriaQuery(Self);
  With qryCadFas, SQL Do
  Begin
    Add('SELECT IFNULL(MAX(FAS_SEQUEN), 0) + 1 AS SEQFAS FROM FASGER WHERE FAS_CODEMP = :CODEMP');
    ParamByName('CODEMP').AsString := VS_StrCodEmp;
    Open;
    Result := FieldByName('SEQFAS').AsInteger;
    Close;
  End;

  FreeAndNil(qryCadFas);
End;

procedure TfrmCadFasesOrdProd.btnPesquisaClick(Sender: TObject);
var
  arrFases : TConsultasArray;
  chrKey   : Char;
begin
  inherited;
  chrKey := '/';
  if fPesqFasesOrdProd(Self, Nil, Nil, qryTabela, chrKey, arrFases) then
  Begin
    pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadFasesOrdProd.btnSequenciaClick(Sender: TObject);
begin
  inherited;
  pCriarForm(TfrmCadFasesOrdProdOrdem);
end;

procedure TfrmCadFasesOrdProd.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela := 'FASGER';
  strNomeCampo  := 'FAS_CODIGO';

  qryTabela := fCriaQuery(Self);
  dtsTabela.DataSet := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;
end;

function TfrmCadFasesOrdProd.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender,blnBuscaPorChave)) Then
  Begin

  End;

  If (Not Result) and blnMudarFoco  Then
    pSetFocus(Sender);
end;

procedure TfrmCadFasesOrdProd.pInicializaIndices;
begin
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;
end;

end.
