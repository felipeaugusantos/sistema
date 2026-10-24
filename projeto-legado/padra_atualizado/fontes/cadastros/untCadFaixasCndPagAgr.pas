unit untCadFaixasCndPagAgr;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.Mask, MaskEditFocus,
  EditFocus, Vcl.DBCtrls, DBEditFocus, Uni, DB;

type
  TfrmCadFaixasCndPagAgr = class(TfrmPaiCad)
    Panel1: TPanel;
    Label12: TLabel;
    Label1: TLabel;
    lblCndPag: TLabel;
    mskCndPag: TMaskEditFocus;
    edtValIni: TDBEditFocus;
    edtValFin: TDBEditFocus;
    edtCodCnd: TDBEditFocus;
    lblCodEmp: TLabel;
    dbeCodEmp: TDBEditFocus;
    edtNomEmp: TEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure edtCodCndKeyPress(Sender: TObject; var Key: Char);
    procedure btnGravarClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    function dbeCodEmpChamaCadastro(Key: Word): string;
    procedure dbeCodEmpKeyPress(Sender: TObject; var Key: Char);
  private
    qryFaixas: TUniQuery;
    dtsDados: TDataSource;
    qryConEmp: TUniQuery;
    qryConCnd: TUniQuery;
    procedure pCarregaCadCnd;
    function fValidaValor(fltValor: Double; strAutoInc, strCodEmp : String): Boolean;
    procedure pCarregaEmpresa;
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
  end;


implementation

{$R *.dfm}

uses untFuncoesSimples, untTypesSistema, untConsultas, untConstantes, untPesqAux, untFuncIns;

procedure TfrmCadFaixasCndPagAgr.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pSetFocus(edtValIni);
end;

procedure TfrmCadFaixasCndPagAgr.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pCarregaCadCnd();
  pCarregaEmpresa;
end;

procedure TfrmCadFaixasCndPagAgr.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadFaixasCndPagAgr.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

  mskCndPag.Clear;
  pCarregaEmpresa;
end;

procedure TfrmCadFaixasCndPagAgr.btnGravarClick(Sender: TObject);
begin
  qryTabela.FieldByName('FAI_CONPAG').AsString := fTiraCaracEspeciais(mskCndPag.Text);

  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadFaixasCndPagAgr.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadFaixasCndPagAgr.btnIncluirClick(Sender: TObject);
begin
  inherited;
  mskCndPag.Clear;
  pSetFocus(edtValIni);
end;

procedure TfrmCadFaixasCndPagAgr.btnPesquisaClick(Sender: TObject);
Var
  c: Char;
  arrSel: TConsultasArray;
begin
  inherited;
  c := '/';
  fPesqFaixasCndPagtoAgr(Self, qryTabela, c, arrSel);

  pCarregaCadCnd();
  pCarregaEmpresa;
  TFloatField(qryFaixas.FieldbyName('FAI_VALINI')).DisplayFormat := '#,##0.00';
  TFloatField(qryFaixas.FieldbyName('FAI_VALFIN')).DisplayFormat := '#,##0.00';
end;

function TfrmCadFaixasCndPagAgr.dbeCodEmpChamaCadastro(Key: Word): string;
begin
  inherited;
  Result := fChamaCadEmp(Key);
end;

procedure TfrmCadFaixasCndPagAgr.dbeCodEmpKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, dbeCodEmp, edtNomEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(dbeCodEmp) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmCadFaixasCndPagAgr.edtCodCndKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrCnd: TConsultasArray;
begin
  inherited;
  If fPesqCondicoesPgto(Self, edtCodCnd, Nil, Nil, Key, arrCnd) Then
  Begin
    If fValidaCampos(edtCodCnd, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadFaixasCndPagAgr.FormCreate(Sender: TObject);
  Var
    intCont: Integer;
begin
  inherited;

  strNomeTabela := 'FAICND';
  strNomeCampo  := 'AUTOINCREM';
  qryFaixas     := fCriarQuery('SELECT * FROM FAICND', Self);

  qryFaixas.FieldbyName('FAI_VALINI').DisplayLabel := 'Valor inicial';
  qryFaixas.FieldbyName('FAI_VALFIN').DisplayLabel := 'Valor final';
  TFloatField(qryFaixas.FieldbyName('FAI_VALINI')).DisplayFormat := '#,##0.00';
  TFloatField(qryFaixas.FieldbyName('FAI_VALFIN')).DisplayFormat := '#,##0.00';

  qryFaixas.FieldByName('AUTOINCREM').Visible := False;

  dtsDados  := fCriaDataSource(qryFaixas);
  qryTabela := qryFaixas;

  For intCont := 0 To ComponentCount - 1 Do
  Begin
    If (Components[intCont] is TDBEditFocus) Then
    Begin
      (Components[intCont] as TDBEditFocus).DataSource := dtsDados;
    End;
  End;

  qryConCnd := fCriaQuery(Self);

  If (fCfgSis('USACND') <> 'S') Then
  Begin
    edtCodCnd.Visible  := False;
    mskCndPag.Left     := edtCodCnd.Left;
    mskCndPag.ReadOnly := False;
    mskCndPag.TabStop  := True;
    mskCndPag.Width    := mskCndPag.Width + edtCodCnd.Width+1;
  End;

  mskCndPag.EditMask := MASK_CONPAG;
end;

procedure TfrmCadFaixasCndPagAgr.FormShow(Sender: TObject);
begin
  inherited;
  qryConEmp := fCriarQuery('SELECT * FROM CADEMP WHERE FALSE', Self);
  pSetFocus(btnIncluir);
end;

function TfrmCadFaixasCndPagAgr.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender)) Then
  Begin
    If (Sender = edtValIni) Then
    Begin
      If (fEmptyStr(edtValIni.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O valor inicial deve ser preenchido', ['&Ok']);
        Result := False;
      End
      Else If fStrToFloat(edtValIni.Text) < 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe um valor maior ou igual a zero!', ['&Ok']);
        Result := False;
      End
      //Else
      //  Result := fValidaValor(fStrToFloat(edtValIni.Text),
      //                         qryTabela.FieldByName('AUTOINCREM').AsString);
      Else If Not fEmptyStr(qryTabela.FieldByName('FAI_CODEMP').AsString) Then
        Result := fValidaValor(fStrToFloat(edtValIni.Text),
                               qryTabela.FieldByName('AUTOINCREM').AsString,
                               qryTabela.FieldByName('FAI_CODEMP').AsString);

    End

    Else If (Sender = edtValFin) Then
    Begin
      If (fEmptyStr(edtValFin.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O valor final deve ser preenchido', ['&Ok']);
        Result := False;
      End
      Else If fStrToFloat(edtValFin.Text) <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe um valor maior que zero!', ['&Ok']);
        Result := False;
      End
      Else If fStrToFloat(edtValFin.Text) <= fStrToFloat(edtValIni.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O valor final deve ser maior que o valor inicial!', ['&Ok']);
        Result := False;
      End
      //  Result := fValidaValor(fStrToFloat(edtValFin.Text),
      //                         qryTabela.FieldByName('AUTOINCREM').AsString);
      Else If Not fEmptyStr(qryTabela.FieldByName('FAI_CODEMP').AsString) Then
        Result := fValidaValor(fStrToFloat(edtValIni.Text),
                               qryTabela.FieldByName('AUTOINCREM').AsString,
                               qryTabela.FieldByName('FAI_CODEMP').AsString);
    End

    Else If (Sender = edtCodCnd) And (edtCodCnd.Visible) Then
    Begin
      If fEmptyStr(edtCodCnd.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O código da condição de pagamento deve ser informada!', ['&Ok']);
        Result := False;
        mskCndPag.Clear;
      End
      Else
      Begin
        pCarregaCadCnd;
        If (qryConCnd.IsEmpty) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa condição não está cadastrada!', ['&Ok']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = mskCndPag) And (Not mskCndPag.ReadOnly) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskCndPag.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A condição de pagamento deve ser informada!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        If (Not fValidaCndPag(mskCndPag.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa condição de pagameto não é válida!', ['&Ok']);
          Result := False;
        End;
      End;
    End

    {*****************************************}
    {* VALIDA O CÓDIGO DA EMPRESA            *}
    {**************************************MV*}
    Else If (Sender = dbeCodEmp) Then
    Begin
      If fEmptyStr(dbeCodEmp.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código da Empresa deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        If Pos(dbeCodEmp.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          pCarregaEmpresa;
          If qryConEmp.FieldByName('EMP_CODEMP').IsNull Then
          Begin
            fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&O k']);
            Result := False;
          End;
        End;
      End;
    End

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

function TfrmCadFaixasCndPagAgr.fValidaValor(fltValor: Double;
  strAutoInc, strCodEmp: String): Boolean;
var
  strSQL: String;
  qryPesq: TUniQuery;
begin

  Result := False;
  If fEmptyStr(strCodEmp) Then
    Exit;

  strSQL := '';
  strSQL := strSQL + 'SELECT * ';
  strSQL := strSQL + 'FROM     ';
  strSQL := strSQL + '  FAICND ';
  strSQL := strSQL + 'WHERE :VALOR BETWEEN FAI_VALINI AND FAI_VALFIN ';
  strSQL := strSQL + '  AND AUTOINCREM <> :AUTOINC                   ';
  strSQL := strSQL + '  AND FAI_CODEMP = :CODEMP                     ';

  qryPesq := fCriarQuery(strSQL);
  Try
    With qryPesq Do
    Begin
      ParamByName('VALOR').AsFloat := fltValor;
      ParamByName('AUTOINC').AsString := strAutoInc;
      ParamByName('CODEMP').AsString := strCodEmp;
      Open;

      If Not IsEmpty Then
      Begin
        fMensagem('ATENÇÃO!', 'Os valores informados estão em conflito com os valores de uma faixa já cadastrada...' + #13#10 +
                              'Valor inicial: ' + FormatFloat('#,##0.00', FieldByName('FAI_VALINI').AsFloat) +
                              ' Valor final: ' + FormatFloat('#,##0.00', FieldByName('FAI_VALFIN').AsFloat) + #13#10 +
                              'Cond. pag.: ' + FieldByName('FAI_CODCND').AsString + ' - ' +
                              fFormataCondPag(FieldByName('FAI_CONPAG').AsString), ['&Ok']);
        Result := False;
      End
      Else
        Result := True;
    End;
  Finally
    FreeAndNil(qryPesq);
  End;
end;

procedure TfrmCadFaixasCndPagAgr.pCarregaCadCnd;
begin
  If fCfgSis('USACND') = 'S' Then
  Begin
    qryConCnd.SQL.Clear;
    qryConCnd.SQL.Add('SELECT * FROM CADCND WHERE CND_CODIGO = :CODCND');
    qryConCnd.ParamByName('CODCND').AsString := edtCodCnd.Text;
    qryConCnd.Open;
    mskCndPag.Text := qryConCnd.FieldByName('CND_CNDPAG').AsString;
  End
  Else
  Begin
    mskCndPag.Text := qryTabela.FieldByName('FAI_CONPAG').AsString;
  End;
end;

procedure TfrmCadFaixasCndPagAgr.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('FAI_VALINI');
  stlCampos.Add('FAI_VALFIN');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('FAI_VALINI');
  stlCamInd.Add('FAI_VALFIN');

  stlDesInd.Add('Valor inicial');
  stlDesInd.Add('Valor final');
end;

procedure TfrmCadFaixasCndPagAgr.pCarregaEmpresa;
begin
  pPesquisaCadEmp(qryConEmp, qryConEmp, dbeCodEmp.Text);
  With qryConEmp Do
  Begin
    edtNomEmp.Text := FieldByName('EMP_NOMEMP').AsString;
  End;
end;


end.
