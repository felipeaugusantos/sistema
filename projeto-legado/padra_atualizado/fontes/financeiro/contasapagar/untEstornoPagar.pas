{************************}
{* ESTORNO DE CTA PAGAR *}
{*27/04/2015**********AF*}
unit untEstornoPagar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass, untTEstornoPagar,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus, Vcl.Grids, DBGridCitel, DBGrids, Data.DB, untConsultas,
  System.Threading, untTypesSistema, untRcxTResumoDeCaixa;

type
  TfrmEstornoPagar = class(TfrmPai)
    pnlTopo: TPanel;
    dbgDados: TDBGridCitel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edtNumDup: TEditFocus;
    edtParcel: TEditFocus;
    edtCodFor: TEditFocus;
    edtCodEmp: TEditFocus;
    edtSerie: TEditFocus;
    edtNomEmp: TEditFocus;
    edtNomFor: TEditFocus;
    dtsDados: TDataSource;
    btnConfirma: TBitBtnLocked;
    btnMarcarTodas: TBitBtnLocked;
    btnDesmarcarTodas: TBitBtnLocked;
    btnConsultar: TBitBtnLocked;
    procedure dbgDadosDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgDadosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure btnMarcarTodasClick(Sender: TObject);
    procedure btnDesmarcarTodasClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnConsultarClick(Sender: TObject);
  private
    { Private declarations }
    objEstorno : TEstornoPagar;
    intConfirma: Integer;

    arrEmpresa,
    arrFornecedor: TConsultasArray;

    blnFechadoCaixa: Boolean;

    procedure pConfirmaEstorno;
    procedure pConfirmaEstornoInterno;
    procedure pLimpaCampos;
    procedure pSelecionaDuplicata;
    procedure pMarcarTodas(blnMarcado: Boolean);
  public
    { Public declarations }
    blnResCai: Boolean;
    strOpeRcx: String;
    dtaDtaCai: TDateTime;
    strChamada: String;

    strCodigoCaixa  : String;
    objResumoDeCaixa: TResumoDeCaixa;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;


implementation

{$R *.dfm}

uses untFuncoesSimples, untConstantes, untTCadPag, untObjectManager, untCadRcxx, untDigOcorrencia;

{ TfrmEstornoPagar }

procedure TfrmEstornoPagar.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  pConfirmaEstorno;
end;

procedure TfrmEstornoPagar.btnConsultarClick(Sender: TObject);
begin
  inherited;
  fValidaCampos(btnConsultar, True);
end;

procedure TfrmEstornoPagar.btnDesmarcarTodasClick(Sender: TObject);
begin
  inherited;
  pMarcarTodas(False);
end;

procedure TfrmEstornoPagar.btnMarcarTodasClick(Sender: TObject);
begin
  inherited;
  pMarcarTodas(True);
end;

procedure TfrmEstornoPagar.dbgDadosDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;

  If Not Assigned(objEstorno) Then Exit;

  If (Not Assigned(objEstorno.PagMar)) Or (objEstorno.PagMar.Count <= 0) Then
    Exit;

  If objEstorno.PagMar.Contains(objEstorno.qryPag.Current<TCadPag>) Then
  Begin
    If gdSelected In State Then
      dbgDados.Canvas.Font.Color := clLime
    Else
      dbgDados.Canvas.Font.Color := clBlue;

    dbgDados.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  End;

end;

procedure TfrmEstornoPagar.dbgDadosKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_Return: pSelecionaDuplicata;
    VK_Escape: pLimpaCampos;
    VK_F10   : Begin
                 Key := 0;
                 btnConfirma.Click;
               End;
  End;

end;

procedure TfrmEstornoPagar.edtCodEmpKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************MO*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmpresa) Then
  Begin
    fValidaCampos(edtCodEmp,False);
    self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmEstornoPagar.edtCodForKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}
  If fPesqFornecedor(conForCompleta, Self, edtCodFor, edtNomFor, Nil, Key, arrFornecedor) Then
  Begin
    If fValidaCampos(edtCodFor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmEstornoPagar.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  pLimpaCampos;
  inherited;
end;

procedure TfrmEstornoPagar.FormCreate(Sender: TObject);
  Var
    LCriou: Boolean;
begin
  inherited;
  intConfirma := -1;
  strChamada := '';

  strCodigoCaixa := '';

  If Assigned(frwk) Then
    FreeAndNil(frwk);

  fCriaObjManager(LCriou);
end;

procedure TfrmEstornoPagar.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_F7) And (btnMarcarTodas.Visible) Then
    pMarcarTodas(True);
  If (Key = VK_F8) And (btnDesmarcarTodas.Visible) Then
    pMarcarTodas(False);
end;

procedure TfrmEstornoPagar.FormShow(Sender: TObject);
begin
  inherited;
  If Not Assigned(objResumoDeCaixa) Then
    objResumoDeCaixa := TResumoDeCaixa.Create();

  If (dtaDtaCai <= 0) Then
    objResumoDeCaixa.fNecessitaFecharCaixa(False, dtaDtaCai, strCodigoCaixa, False);

  If dtaDtaCai <= 0 Then
    dtaDtaCai := VS_Date;

  If fEmptyStr(strOpeRcx) Then
    strOpeRcx := strLoginUsuarioLogado;

  If Not Assigned(objEstorno) Then
  Begin
    objEstorno := TEstornoPagar.Create(Self, blnResCai, strOpeRcx, dtaDtaCai, strCodigoCaixa, objResumoDeCaixa);
    dtsDados.DataSet := objEstorno.qryPag;
  End;

end;

function TfrmEstornoPagar.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  {*********************************}
  {* REALIZA VALIDAÇÕES DOS CAMPOS *}
  {******************************AF*}

  Try
    Result := True;

    If Sender = edtNumDup Then objEstorno.strNumDup := edtNumDup.Text
    Else If Sender = edtParcel Then objEstorno.strParcel := edtParcel.Text

    Else If Sender = edtCodEmp Then
    Begin
      edtNomEmp.Clear;
      objEstorno.strCodEmp := edtCodEmp.Text;
      edtNomEmp.Text := objEstorno.strDesEmp;
    End

    Else If Sender = edtSerie  Then objEstorno.strSerie_ := edtSerie.Text
    Else if Sender = edtCodFor then
    Begin
      edtNomFor.Clear;
      objEstorno.strCodFor := edtCodFor.Text;
      edtNomFor.Text := objEstorno.strDesFor;
    End
    Else If Sender = btnConsultar Then
    Begin
      If fEmptyStr(edtNumDup.Text) Then
      Begin
        objEstorno.strNumDup := edtNumDup.Text;
      End
      Else
      If fEmptyStr(edtCodEmp.Text) Then
      Begin
        objEstorno.strNumDup := edtCodEmp.Text;
      End
      Else
      If blnBuscaPorChave Then
      Begin
        If Not fVerificaCampos Then
          Result := False
        Else
        Begin
          objEstorno.pCarregaDados;
          btnMarcarTodas.Visible := objEstorno.blnSelecaoIndividual;
          btnDesmarcarTodas.Visible := objEstorno.blnSelecaoIndividual;

          if not objEstorno.qryPag.IsEmpty then
          begin
            pSetFocus(dbgDados);
          end;
        End;
      End;
    End;

  Except
    On E: ExceptionAutCom Do
    Begin
      pMensagemOk(E.Message);
      Result := False;
    End;

    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '');
      Result := False;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

{*****************************************}
{* CHAMA TELA DE ESTORNO                 *}
{**************************************AF*}
procedure TfrmEstornoPagar.pConfirmaEstorno;
Begin

  If InterlockedIncrement(intConfirma) = 0 Then
  Begin

    Try
      pConfirmaEstornoInterno;
      InterlockedDecrement(intConfirma);
    Except
      On E: Exception Do
      Begin
        InterlockedDecrement(intConfirma);
        pMensagensErro(E.Message, 'TfrmEstornoPagar.pConfirmaEstorno');
      End;
    End;

  End
  Else
    InterlockedDecrement(intConfirma);

End;

procedure TfrmEstornoPagar.pConfirmaEstornoInterno;
  Var
    cdsDadosCaixa: TDataset;
Begin

  If Not fVerificaCampos Then
    Exit;

  Try
    If objEstorno.qryPag.RecordCount = 0 Then
    Begin
      pMensagemOk('Não há duplicatas a serem estornadas' + IIF(blnResCai,' ou não foi baixada pelo resumo de caixa!','!'));

      pSetFocus(edtNumDup);
      pLimpaCampos;
      Exit;
    End;

    {**********************************}
    {* NÃO HÁ DUPLICATAS SELECIONADAS *}
    {*******************************AF*}
    If objEstorno.PagMar.Count <= 0 Then
    Begin
      pMensagemOk('Não há duplicatas selecionadas!');

      pSetFocus(dbgDados);
      Exit;
    End;

    cdsDadosCaixa := objResumoDeCaixa.fRetornaDadosLancamentosCaixaSeqCon(objEstorno.PagMar[0].intRcxCon.ToString,
                                                                          objEstorno.PagMar[0].strEmpBai,
                                                                          objEstorno.PagMar[0].dtaDtaPag);

    blnFechadoCaixa := (objResumoDeCaixa.strTipoFechamento.Equals('C')) And
                       ((Not Assigned(cdsDadosCaixa)) Or
                        (cdsDadosCaixa.IsEmpty) Or
                        (cdsDadosCaixa.FieldByName('RCX_LANFEC').AsString = 'S'));

    objEstorno.blnFechadoCaixa := blnFechadoCaixa;

    {***********************************}
    {* ESTORNO NÃO PERMITIDO EM RESUMO *}
    {* COM DATA DIFERENTE              *}
    {********************************AF*}
    If (blnResCai) And (objEstorno.PagMar[0].dtaDtaPag <> VS_Date) Then
    Begin
      pMensagemOk('Estorno não permitido, o resumo de caixa somente estorna a duplicata quando a data de recebimento for a mesma do dia.' + #13#10 +
                  'Por favor, estornar pelo financeiro.');

      pSetFocus(dbgDados);
      Exit;
    End

    Else If (blnResCai) And
            (Not strCodigoCaixa.IsEmpty) And
            (objResumoDeCaixa.fCaixaDeBaixaCtpDiferenteDoCaixaDeEstorno(strCodigoCaixa,
                                                                        VS_strCodEmp,
                                                                        objEstorno.PagMar[0].intRcxCon)) Then
    Begin
      fMensagem('ATENÇÃO', 'Estorno não permitido, pois o caixa da baixa é diferente do caixa que está em operação.', ['&Ok']);

      pSetFocus(dbgDados);
      blnMudarFoco := False;
    End

    {*********************************************}
    {* TRAVA LEVADA PARA A SELEÇÃO DE DUPLICATAS *}
    {* untTEstornoPagar pInsertSelecion          *}
    {*********************************************}
    {* EMPRESA DE BAIXA DIFERENTE                *}
    {******************************************AF*}
    {Else If objEstorno.PagMar[0].strEmpBai <> VS_strCodEmp Then
    Begin
      pMensagemOk('Permitido apenas estornar documentos baixados pela empresa ' + VS_strCodEmp + '!');

      pSetFocus(dbgDados);
      Exit;
    End}

    Else If Not objEstorno.fVerificaDatasDiferentes(objEstorno.PagMar[0]) Then
    Begin
      pSetFocus(dbgDados);
      Exit;
    End

    Else If Not objEstorno.fVerificaDatasDiferentesRcx(objEstorno.PagMar[0]) Then
    Begin
      pSetFocus(dbgDados);
      Exit;
    End

    Else If (blnRescai) And
            (cdsDadosCaixa.FieldByName('RCX_LANFEC').AsString = 'S') Then
    Begin
      fMensagem('ATENÇÃO', 'Estorno não permitido pelo Resumo de Caixa, pois após esse pagamento o caixa já foi fechado.' + #13 +
                           'Por favor, estornar pelo financeiro ou cancele fechamento do caixa.', ['&O k']);

      pSetFocus(dbgDados);
      Exit;
    End

    Else If (Not blnRescai) And
            (objResumoDeCaixa.strTipoFechamento = 'C') And
            (objEstorno.PagMar[0].intRescai = 1) And
            (objEstorno.PagMar[0].dtaDtaPag = dtaDtaCai) And
            (cdsDadosCaixa.FieldByName('RCX_LANFEC').AsString = 'N') Then
    Begin
      fMensagem('ATENÇÃO', 'Estorno não permitido pois o pagamento foi feito pelo Resumo de Caixa e ainda não houve fechamento.', ['&O k']);

      pSetFocus(dbgDados);
      Exit;
    End

    Else If Not objEstorno.fVerificaSaldoMaximoCaixa(objEstorno.PagMar[0]) Then
    Begin
      pSetFocus(dbgDados);
      Exit;
    End

    Else if not objEstorno.VerificaSeExisteRcxCon then
    begin
      pSetFocus(dbgDados);
      Exit;
    end

    Else if objEstorno.fTemPagamentoAntecipadoComPagamentoNormal then
    begin
      pMensagemOk('Não é possível estornar duplicatas com pagamento antecipado junto com duplicatas sem pagamento antecipado!');
      pSetFocus(dbgDados);
      Exit;
    End



    {***************}
    {* CONFIRMAÇÃO *}
    {************AF*}
    Else If (fMensagem('', 'Confirma estorno de duplicata(s)?', ['&Sim', '&Não']) = 1) Then
    Begin

      If objEstorno.fEstornaDuplicataConjugadas(strChamada) Then
      Begin
        pLimpaCampos;
        pSetFocus(edtNumDup);
      End
      Else
        Exit;

    End
    Else
      pSetFocus(dbgDados);

  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;

End;

procedure TfrmEstornoPagar.pLimpaCampos;
begin
  edtNomFor.Clear;
  edtNumDup.Clear;
  edtCodFor.Clear;
  edtSerie.Clear;
  edtNomEmp.Clear;
  edtCodEmp.Clear;
  edtParcel.Text := 'A';

  objEstorno.pLimparDados;

  btnMarcarTodas.Visible := False;
  btnDesmarcarTodas.Visible := False;

  pSetFocus(edtNumDup);
end;

procedure TfrmEstornoPagar.pMarcarTodas(blnMarcado: Boolean);
var
  intRecNo: Integer;
begin
  If (Not objEstorno.qryPag.Active) Or (objEstorno.qryPag.IsEmpty) Then
    Exit;

  Try
    with objEstorno.qryPag do
    begin
      intRecNo := RecNo;
      DisableControls;
      try
        First;
        while not Eof do
        begin
          If blnMarcado and (not objEstorno.PagMar.Contains(Current<TCadPag>)) Then
            objEstorno.pInsertSelecion;

          If (not blnMarcado) and objEstorno.PagMar.Contains(Current<TCadPag>) Then
            objEstorno.pDeleteSelecion;

          Next;
        end;
      finally
        RecNo := intRecNo;
        EnableControls;
      end;
    end;

  Except
    On E: ExceptionAutCom Do pMensagemOk(E.Message);
    On E: Exception Do pMensagensErro(E.Message, '');
  End;

  dbgDados.Refresh;
end;

procedure TfrmEstornoPagar.pSelecionaDuplicata;
Begin

  If (Not objEstorno.qryPag.Active) Or (objEstorno.qryPag.IsEmpty) Then
    Exit;

  Try
    If objEstorno.PagMar.Contains(objEstorno.qryPag.Current<TCadPag>) Then
      objEstorno.pDeleteSelecion
    Else
      objEstorno.pInsertSelecion;

  Except
    On E: ExceptionAutCom Do pMensagemOk(E.Message);
    On E: Exception Do pMensagensErro(E.Message, '');
  End;

  dbgDados.Refresh;
End;

end.
