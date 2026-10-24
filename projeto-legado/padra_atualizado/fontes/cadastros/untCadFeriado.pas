unit untCadFeriado;

interface

uses
  Windows, Classes, Controls, Forms, AppEvnts, Menus, ComCtrls, StdCtrls,
  Buttons, ExtCtrls, UntCadFer, DB, Mask, DBCtrls, DBEditFocus, untPaiCad,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadFeriado = class(TfrmPaiCad)
    pnlFundo: TPanel;
    Label2: TLabel;
    Label4: TLabel;
    dbeDtaFer: TDBEditFocus;
    dbeDescri: TDBEditFocus;
    dtsCadFer: TDataSource;
    btnHeranca: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure dbeDtaFerExit(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dtsCadFerDataChange(Sender: TObject; Field: TField);
    procedure btnHerancaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
     objCadFer: TCadFer;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
  public
    { Public declarations }
  end;


implementation

uses SysUtils, untFuncoesSimples, untConsultas, untHerancaFeriado;

{$R *.dfm}

procedure TfrmCadFeriado.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;

  If Action <> caNone Then
  Begin
    If Assigned(objCadFer.qryTabela) Then
      FreeAndNil(objCadFer.qryTabela);

    FreeAndNil(objCadFer);
  End;
end;

procedure TfrmCadFeriado.FormCreate(Sender: TObject);
begin
  objCadFer := TCadFer.Create(Self);

  inherited;
  strNomeTabela := 'CADFER';
  strNomeCampo  := 'FER_DTAFER';
  qryTabela     := objCadFer.qryTabela;
  //arrCampos     := objCadFer.arrDefCam;
  dtsCadFer.DataSet := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeDtaFer;
end;

function TfrmCadFeriado.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    Try

      {**********************}
      {* VALIDA A DATA      *}
      {*******************LU*}
      If (Sender = dbeDtaFer) Then
      Begin
        If fEmptyStr(fTiraCaracEspeciais(dbeDtaFer.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'É necessário que a Data seja preenchida!', ['&Ok']);
          Result := False;
        End
        Else If Not fValidaDataStr(dbeDtaFer.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data não é válida!',['&OK']);
          Result := False;
        End
        Else
          objCadFer.strDtaFer := dbeDtaFer.Text;
      End

      {***************************}
      {* VALIDA A DESCRICAO      *}
      {************************LU*}
      Else If (Sender = dbeDescri) Then
      Begin
        If fEmptyStr(dbeDescri.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'A descrição precisa ser preenchida!', ['&Ok']);
          Result := False;
        End
        Else
          objCadFer.strDescri := dbeDescri.Text;
      End;

    Except
      On E: Exception Do
      Begin
				pMensagensErro(E.Message,'[TfrmCadFeriado.fValidaCampos]');
        Result := False;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmCadFeriado.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('FER_DTAFER');
  stlCampos.Add('FER_DESCRI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('FER_DTAFER');
  stlCamInd.Add('FER_DESCRI');

  stlDesInd.Add('Data');
  stlDesInd.Add('Descrição');
end;

procedure TfrmCadFeriado.btnIncluirClick(Sender: TObject);
begin
  inherited;

  qryTabela.FieldByName('FER_CODEMP').AsString := VS_strCodEmp;
  pSetFocus(dbeDtaFer);
end;

procedure TfrmCadFeriado.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pSetFocus(dbeDtaFer);
end;

procedure TfrmCadFeriado.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadFeriado.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadFeriado.btnGravarClick(Sender: TObject);
begin
  blnUsaProCodigo := False;

  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadFeriado.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadFeriado.btnHerancaClick(Sender: TObject);
begin
  inherited;

  pCriarForm(TfrmHerancaFeriado, frmHerancaFeriado);
end;

procedure TfrmCadFeriado.dbeDtaFerExit(Sender: TObject);
begin
  inherited;

  If Not fEmptyStr(fTiraCaracEspeciais(dbeDtaFer.Text)) Then
  Begin
    If (qryTabela.State = dsInsert) Then
    Begin
      If objCadFer.fVerificaDataExiste(StrToDate(dbeDtaFer.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Essa Data já está cadastrada!', ['&Ok']);
        pSetFocus(dbeDtaFer);
      End;
    End;
  End
  Else
    fMensagem('ATENÇÃO!', 'A Data deve ser preenchida!', ['&Ok']);

end;

procedure TfrmCadFeriado.dtsCadFerDataChange(Sender: TObject; Field: TField);
begin
  inherited;

  btnHeranca.Enabled := (dtsCadFer.State in [dsBrowse]);
end;

procedure TfrmCadFeriado.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
begin
  {*******************************}
  {* NOVA CONSULTA DE ATIVIDADES *}
  {****************************RV*}
  chrKey := '/';
  If fPesqFeriados(Self, Nil, Nil, qryTabela, chrKey) Then
    pSetFocus(btnAlterar);
end;

end.
