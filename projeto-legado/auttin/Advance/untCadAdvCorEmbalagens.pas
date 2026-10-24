unit untCadAdvCorEmbalagens;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, Menus, ComCtrls, StdCtrls, Buttons, ExtCtrls, Mask,
  DBCtrls, DBEditFocus, StrUtils, AppEvnts, Uni, DB, 
  BitBtnLockedIncrem, MemDS, DBAccess, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadAdvCorEmbalagens = class(TfrmPaiCad)
    pnlCentral: TPanel;
    pnlCabecalho: TPanel;
    Label1: TLabel;
    dbeCodEmb: TDBEditFocus;
    Label2: TLabel;
    dbeQtdEmb: TDBEditFocus;
    Label3: TLabel;
    dbeUnidad: TDBEditFocus;
    qryAdv_CadEmb: TUniQuery;
    qryAdv_CadEmbEMB_CODEMB: TStringField;
    qryAdv_CadEmbEMB_QTDEMB: TFloatField;
    qryAdv_CadEmbEMB_UNIDAD: TStringField;
    qryAdv_CadEmbEMB_CODEMP: TStringField;
    qryAdv_CadEmbAUTOINCREM: TStringField;
    dtsAdv_cadEmb: TDataSource;
    qryAdv_CadEmbEMB_USAEMB: TStringField;
    chkUsaEmb: TDBCheckBox;
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
  frmCadAdvCorEmbalagens: TfrmCadAdvCorEmbalagens;

implementation

uses untPai,
     untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmCadAdvCorEmbalagens.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela := 'ADVCOR_CADEMB';
  strNomeCampo  := 'EMB_CODEMB';

  qryAdv_CadEmb.FieldByName('AUTOINCREM').Visible := false;

  qryTabela     := qryAdv_CadEmb;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodEmb;
End;
procedure TfrmCadAdvCorEmbalagens.btnIncluirClick(Sender: TObject);
begin
  inherited;
  blnUsaProCodigo := False;

  pSetFocus(dbeCodEmb);
end;

procedure TfrmCadAdvCorEmbalagens.btnPesquisaClick(Sender: TObject);
  var
    Key : Char;
    arrSel: TConsultasArray;
begin
  Key := '/';
  fPesqEmbalagens(Self, 'ADVCOR_CADEMB', Nil, Nil, Nil, qryTabela, Key, arrSel);
end;

procedure TfrmCadAdvCorEmbalagens.btnAlterarClick(Sender: TObject);
begin
  inherited;
  dbeCodEmb.Enabled := False;
  pSetFocus(dbeQtdEmb);
end;

function TfrmCadAdvCorEmbalagens.fValidaCampos(Sender: TWinControl;
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

procedure TfrmCadAdvCorEmbalagens.pInicializaIndices;
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

procedure TfrmCadAdvCorEmbalagens.dbeUnidadKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;
  if fPesqUnidade(Self, dbeUnidad, nil, nil, nil, Key, arrSel) then
     SelectNext(ActiveControl, True, True);
end;

end.

