unit untCadAnjoSinteticaEmbalagens;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons, ExtCtrls,
  DBCtrls, Mask, DBEditFocus, StrUtils, Uni, DB,
  BitBtnLockedIncrem, MemDS, DBAccess, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadAnjoSinteticaEmbalagens = class(TfrmPaiCad)
    pnlCentral: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    pnlCabecalho: TPanel;
    dbeCodEmb: TDBEditFocus;
    dbeQtdEmb: TDBEditFocus;
    dbeUnidad: TDBEditFocus;
    chkUsaEmb: TDBCheckBox;
    dtsAja_cadEmb: TDataSource;
    qryAja_CadEmb: TUniQuery;
    qryAja_CadEmbEMB_CODEMB: TStringField;
    qryAja_CadEmbEMB_QTDEMB: TFloatField;
    qryAja_CadEmbEMB_UNIDAD: TStringField;
    qryAja_CadEmbEMB_CODEMP: TStringField;
    qryAja_CadEmbAUTOINCREM: TStringField;
    qryAja_CadEmbEMB_USAEMB: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure dbeUnidadKeyPress(Sender: TObject; var Key: Char);
    procedure btnPesquisaClick(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmCadAnjoSinteticaEmbalagens: TfrmCadAnjoSinteticaEmbalagens;

implementation

uses untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

{ TfrmCadAnjoSinteticaEmbalagens }

procedure TfrmCadAnjoSinteticaEmbalagens.btnAlterarClick(Sender: TObject);
begin
  inherited;
  dbeCodEmb.Enabled := False;
  pSetFocus(dbeQtdEmb);
end;

procedure TfrmCadAnjoSinteticaEmbalagens.btnIncluirClick(Sender: TObject);
begin
  inherited;
  blnUsaProCodigo := False;
  
  pSetFocus(dbeCodEmb);
end;

procedure TfrmCadAnjoSinteticaEmbalagens.btnPesquisaClick(Sender: TObject);
  var
    arrSel: TConsultasArray;
    Key   : Char;
begin
  Key := '/';
  If fPesqEmbalagens(Self, 'AJA_CADEMB', Nil, Nil, Nil, qryTabela, Key, arrSel) Then
    pSetFocus(btnAlterar);
end;

procedure TfrmCadAnjoSinteticaEmbalagens.dbeUnidadKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;
    if fPesqUnidade(Self, dbeUnidad, nil, nil, nil, Key, arrSel) then
       SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadAnjoSinteticaEmbalagens.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela := 'AJA_CADEMB';
  strNomeCampo  := 'EMB_CODEMB';
  qryTabela     := qryAja_CadEmb;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodEmb;
end;

function TfrmCadAnjoSinteticaEmbalagens.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (Sender = dbeCodEmb) Then
  Begin

    If (fEmptyStr(dbeCodEmb.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O código deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If (blnBuscaPorChave) Then
    Begin
      fBuscaPorCamposChave;
    End;

  End

  Else If (Sender = dbeQtdEmb) Then
  Begin

    If (fEmptyStr(dbeQtdEmb.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A quantidade deve ser preenchida!', ['&Ok']);
      Result := False;
    End
    Else If (fStrToFloat(dbeQtdEmb.Text) <= 0.0) Then
    Begin
      fMensagem('ATENÇÃO!', 'A quantidade deve ser maior que Zero! ', ['&Ok']);
      Result := False;
    End;

  End

  Else If (Sender = dbeUnidad) Then
  Begin
    If (fEmptyStr(dbeUnidad.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A unidade deve ser preenchida!', ['&O k']);
      Result := False;
    End;
  End;

end;

procedure TfrmCadAnjoSinteticaEmbalagens.pInicializaIndices;
begin
  inherited;

  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('EMB_CODEMB');
  stlCampos.Add('EMB_QTDEMB');
  stlCampos.Add('EMB_UNIDAD');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('EMB_CODEMB');
  stlDesInd.Add('Código');

end;

end.

