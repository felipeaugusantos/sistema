unit Contabilidade.View.NotasExplicativas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.AppEvnts, Vcl.Menus,
  Vcl.Buttons, Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.Mask,
  Vcl.DBCtrls, DBEditFocus, Data.DB, Contabilidade.View.TfrmPaiCadContabilidade, frxClass, frxExportCSVTestabilidade,
  DBMemoFocus, EditFocus;

type
  TfrmNotasExplicativas = class(TfrmPaiCadContabilidade)
    pnlCentral: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    dbeCodCon: TDBEditFocus;
    dbeDtaFin: TDBEditFocus;
    dtsNotExp: TDataSource;
    dbeNotExp: TDBMemoFocus;
    Label3: TLabel;
    edtNomCon: TEditFocus;
    dbeAutoincrem: TDBEditFocus;
    Label4: TLabel;
    dbeDtaIni: TDBEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure dbeCodConKeyPress(Sender: TObject; var Key: Char);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
  private
    { Private declarations }
    procedure pHabilitaCampos(AEnabled: boolean);
    procedure pCarregaPlanoContabil(const blnBuscaPorChave: Boolean=False); 
    procedure pAfterOpen(DataSet: TDataSet);
    function fPreencheuPlanoDeContasCorretamente: boolean;
  public
    { Public declarations }
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

uses
  untTypesSistema, untConsultas, untFuncoesSimples, Contabilidade.Consultas,
  Contabilidade.Funcoes;

{$R *.dfm}

procedure TfrmNotasExplicativas.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCampos(False);
end;

procedure TfrmNotasExplicativas.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pCarregaPlanoContabil;
end;

procedure TfrmNotasExplicativas.btnExcluirClick(Sender: TObject);
begin
  inherited;
  pCarregaPlanoContabil;
end;

procedure TfrmNotasExplicativas.btnGravarClick(Sender: TObject);
begin
  inherited;
  pCarregaPlanoContabil;
end;

procedure TfrmNotasExplicativas.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pHabilitaCampos(True);
  pSetFocus(dbeDtaIni);
end;

procedure TfrmNotasExplicativas.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
begin
  chrKey := '/';
  If fPesqNotasExplicativas(Self, Nil, qryTabela, chrKey) Then
  begin
    pSetFocus(btnAlterar);
    pCarregaPlanoContabil;
  end;
end;

procedure TfrmNotasExplicativas.dbeCodConKeyPress(Sender: TObject;
  var Key: Char);
  var arrSel : TConsultasArray;
begin
  If fEntraCons(Key) Then
  Begin
    TStringField(qryTabela.FieldByName('EXP_CODCON')).EditMask := '';
    try
      If fPesqPlanoContabil(Self, dbeCodCon, Nil, Nil, Key, arrSel) Then
      Begin
        If fValidaCampos(dbeCodCon, False) Then
          Self.SelectNext(ActiveControl, True, True);
      End;
    finally
      TStringField(qryTabela.FieldByName('EXP_CODCON')).EditMask := fMskCon;
    end;
  End;
end;

procedure TfrmNotasExplicativas.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela := 'NOTEXP';
  strNomeCampo := 'AUTOINCREM';

  qryTabela := fCriarQuery('SELECT * FROM ' + strNomeTabela, Self);
  qryTabela.AfterOpen := pAfterOpen;
  pAfterOpen(qryTabela);

  dtsNotExp.DataSet := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeAutoincrem;
end;

function TfrmNotasExplicativas.fPreencheuPlanoDeContasCorretamente: boolean;
begin
  Result := True;

  If (fEmptyStr(dbeCodCon.Text)) then
    Exit(False);

  if (fEmptyStr(edtNomCon.Text)) then
    Exit(False);
end;

function TfrmNotasExplicativas.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (Sender = dbeDtaIni) Then
  Begin
    Try
      If fEmptyStr(Trim(fTiraCaracEspeciais(dbeDtaIni.Text))) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data Inicial de Apuração deve ser preenchida!', ['&OK']);
        Result := False;
      End;
    Except
      On E: EConvertError Do
      Begin
        fMensagem('ATENÇÃO!', dbeDtaIni.Text + ' não é uma data válida!', ['&O k']);
        Result := False;
      End;
    End;
  End
  else If (Sender = dbeDtaFin) Then
  Begin
    Try
      If fEmptyStr(Trim(fTiraCaracEspeciais(dbeDtaFin.Text))) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data Final de Apuração deve ser preenchida!', ['&OK']);
        Result := False;
      End
      else if not fValidaPeriodo(dbeDtaIni.Text, dbeDtaFin.Text) then
      begin
        fMensagem('ATENÇÃO!', 'A data final deve ser maior ou igual à data inicial!', ['&OK']);
        Result := False;
      end;
    Except
      On E: EConvertError Do
      Begin
        fMensagem('ATENÇÃO!', dbeDtaFin.Text + ' não é uma data válida!', ['&O k']);
        Result := False;
      End;
    End;
  End
  Else If (Sender = dbeCodCon) Then
  Begin
    If (fEmptyStr(dbeCodCon.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O plano de contas deve ser preenchido!', ['&OK']);
      Result := False;
    End
    else
    begin
      pCarregaPlanoContabil(blnBuscaPorChave);
      If (not fPreencheuPlanoDeContasCorretamente) Then
      Begin
        fMensagem('ATENÇÃO!', 'Plano de contas não existe!', ['&OK']);
        Result := False;
      End;
    end;
  End
  Else If (Sender = dbeNotExp) then
  begin
    if fEmptyStr(dbeNotExp.Text) then
    begin
      fMensagem('ATENÇÃO!', 'A nota explicativa deve ser preenchida!', ['&OK']);
      Result := False;
    end;
  end;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmNotasExplicativas.pAfterOpen(DataSet: TDataSet);
begin
  TStringField(qryTabela.FieldByName('EXP_CODCON')).EditMask := fMskCon;
  TDateField(qryTabela.FieldByName('EXP_DTAFIN')).EditMask := '99/99/9999';
  TDateField(qryTabela.FieldByName('EXP_DTAINI')).EditMask := '99/99/9999';
end;

procedure TfrmNotasExplicativas.pCarregaPlanoContabil(const blnBuscaPorChave: Boolean=False);
begin
  edtNomCon.Text := fCampoTabelaPlanco('NCO_DESCRI', ['NCO_CODCON'], [fSemMascaraPlaNco(dbeCodCon.Text)], False);
end;

procedure TfrmNotasExplicativas.pHabilitaCampos(AEnabled: boolean);
begin
  dbeDtaIni.Enabled := AEnabled;
  dbeDtaFin.Enabled := AEnabled;
  dbeCodCon.Enabled := AEnabled;
end;

procedure TfrmNotasExplicativas.pInicializaIndices;
begin
  inherited;

  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('EXP_DTAINI');
  stlCampos.Add('EXP_DTAFIN');
  stlCampos.Add('EXP_CODCON');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('EXP_DTAINI');
  stlCamInd.Add('EXP_DTAFIN');
  stlCamInd.Add('EXP_CODCON');

  stlDesInd.Add('Data Inicial da Apuração');
  stlDesInd.Add('Data Final da Apuração');
  stlDesInd.Add('Código da Conta');
end;

end.
