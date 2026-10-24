unit untImportaProdFranq;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, EditFocus, Vcl.ComCtrls, MemoFocus, untTImportacaoFranquias,
  Uni, UniClientDataSet, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxSpinEdit, untSelOpcDin;

type
  TfrmImportaProdFranq = class(TfrmPai)
    btnConfirma: TBitBtnLocked;
    grbResumo: TGroupBox;
    btnVerDados: TBitBtnLocked;
    lblSep1: TLabel;
    lblTabelas: TLabel;
    lblQtdReg: TLabel;
    lblDetalhes: TLabel;
    lblDepartamento: TLabel;
    lblLinGru: TLabel;
    lblMarcas: TLabel;
    lblUnidades: TLabel;
    lblGrupoProdutos: TLabel;
    lblAtividades: TLabel;
    lblFornecedores: TLabel;
    lblProdutos: TLabel;
    edtQtdDep: TEditFocus;
    edtQtdLinGru: TEditFocus;
    edtQtdMar: TEditFocus;
    edtQtdUni: TEditFocus;
    edtQtdGruProd: TEditFocus;
    edtQtdAti: TEditFocus;
    edtQtdFor: TEditFocus;
    edtQtdProd: TEditFocus;
    edtDetDep: TSpeedButton;
    edtDetLinGru: TSpeedButton;
    edtDetMar: TSpeedButton;
    edtDetUni: TSpeedButton;
    edtDetGruProd: TSpeedButton;
    edtDetAti: TSpeedButton;
    edtDetFor: TSpeedButton;
    edtDetProd: TSpeedButton;
    grbProgresso: TGroupBox;
    pnlProgresso: TPanel;
    lblSep2: TLabel;
    pgrGeral: TProgressBar;
    pgrDetalhe: TProgressBar;
    lblGeral: TLabel;
    lblDetalhe: TLabel;
    pgcLogs: TPageControl;
    tbsLogGeral: TTabSheet;
    tbsLogExclusao: TTabSheet;
    mmoLog: TMemoFocus;
    mmoExclusao: TMemoFocus;
    chkIgnExcPrd: TCheckBox;
    chkIgnExcFor: TCheckBox;
    lblQtdLote: TLabel;
    Label1: TLabel;
    edtQtdLot: TEditFocus;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    edtProdPend: TEditFocus;
    edtFornPend: TEditFocus;
    btnDefineCampos: TBitBtnLocked;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure btnVerDadosClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtDetDepClick(Sender: TObject);
    procedure edtDetLinGruClick(Sender: TObject);
    procedure edtDetMarClick(Sender: TObject);
    procedure edtDetUniClick(Sender: TObject);
    procedure edtDetGruProdClick(Sender: TObject);
    procedure edtDetAtiClick(Sender: TObject);
    procedure edtDetForClick(Sender: TObject);
    procedure edtDetProdClick(Sender: TObject);
    procedure btnDefineCamposClick(Sender: TObject);
  private
    { Private declarations }
    objImportacao: TImportacaoCadastros;
    GerOpcDin: TGerOpcDin;

    Function fUpdateFRALOT: Boolean;
    procedure pLimparComponentes;
    procedure pExibirTelaDetalhes(tcTipoCad: TTipoCad; cdsDados: TUniClientDataSet);
    procedure pCarregaRegPendentes;
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmImportaProdFranq: TfrmImportaProdFranq;

implementation

{$R *.dfm}

uses untImportaProdFranqDetalhes, untFuncoesSimples;

procedure TfrmImportaProdFranq.btnConfirmaClick(Sender: TObject);
  Var
    blnConfirma: Boolean;
begin
  inherited;

  If Not fVerificaCampos Then
    Exit;

  fUpdateFRALOT;

  objImportacao.intLimitRegistros := StrToIntDef(edtQtdLot.Text, 500);

  blnConfirma := (objImportacao.fPossuiRegistros()) And
    (fMensagem('CONFIRMAÇÃO!', 'Confirma importação dos cadastros?', ['&Sim', '&Não'], 2) = 1);

  Try
    pnlProgresso.Visible := blnConfirma;
    lblGeral.Visible     := blnConfirma;
    lblDetalhe.Visible   := blnConfirma;

    objImportacao.blnIgnExcFor := chkIgnExcFor.Checked;
    objImportacao.blnIgnExcPrd := chkIgnExcPrd.Checked;
    objImportacao.arrCamposSelecionados := GerOpcDin.fListaCamposSelecionados;

    If (blnConfirma) Then
      blnConfirma := objImportacao.fRealizarImportacao();

    If (blnConfirma) Or (Not objImportacao.fPossuiRegistros()) Then Begin
      If (objImportacao.fPossuiRegistros()) Then Begin
        mmoLog.Lines.Add(#13#10 + 'Importação finalizada com sucesso!' + #13#10);

        fMensagem('CONFIRMAÇÃO!', 'Importação finalizada com sucesso!', ['&OK']);
      End Else Begin
        mmoLog.Lines.Add(#13#10 + 'Nenhum registro foi encontrado para importação. Operação cancelada!' + #13#10);

        fMensagem('ATENÇÃO!', 'Operação cancelada!', ['&OK']);
      End;
    End Else If (objImportacao.fPossuiRegistros()) Then Begin
      mmoLog.Lines.Add(#13#10 + 'Importação finalizada com erros, nenhum cadastro foi importado. Verifique!' + #13#10);

      fMensagem('ATENÇÃO!', 'Importação finalizada com erros, nenhum cadastro foi importado. Verifique!', ['&OK']);
    End;
  Finally
    pnlProgresso.Visible := False;
    lblGeral.Visible     := False;
    lblDetalhe.Visible   := False;

    pCarregaRegPendentes;
  End;
end;

procedure TfrmImportaProdFranq.btnDefineCamposClick(Sender: TObject);
begin
  inherited;
  If btnDefineCampos.Visible then
    GerOpcDin.pAbrirConfiguracao;
end;

procedure TfrmImportaProdFranq.btnVerDadosClick(Sender: TObject);
  Var
    blnConfirma: Boolean;
begin
  inherited;

  If Not fVerificaCampos Then
    Exit;

  fUpdateFRALOT;

  objImportacao.intLimitRegistros := StrToIntDef(edtQtdLot.Text, 500);

  pLimparComponentes();

  Try
    pnlProgresso.Visible := True;
    lblGeral.Visible     := True;
    lblDetalhe.Visible   := True;

    Self.Repaint();

    mmoLog.Clear();
    mmoExclusao.Clear();
    mmoLog.Lines.Add('Iniciando verificação de dados para importação. Aguarde!');

    edtQtdDep.Text     := 'Aguarde...';
    edtQtdLinGru.Text  := 'Aguarde...';
    edtQtdMar.Text     := 'Aguarde...';
    edtQtdUni.Text     := 'Aguarde...';
    edtQtdGruProd.Text := 'Aguarde...';
    edtQtdAti.Text     := 'Aguarde...';
    edtQtdFor.Text     := 'Aguarde...';
    edtQtdProd.Text    := 'Aguarde...';
    edtProdPend.Text:= 'Aguarde...';
    edtFornPend.Text:= 'Aguarde...';


    Self.Repaint();

    blnConfirma := objImportacao.fVerificaDadosImportacao();

    If (blnConfirma) Then Begin
      edtQtdDep.Text     := IntToStr(objImportacao.cdsCadDep.RecordCount);
      edtQtdLinGru.Text  := IntToStr(objImportacao.cdsCadGru.RecordCount);
      edtQtdMar.Text     := IntToStr(objImportacao.cdsCadMar.RecordCount);
      edtQtdUni.Text     := IntToStr(objImportacao.cdsCadUni.RecordCount);
      edtQtdGruProd.Text := IntToStr(objImportacao.cdsGrpPrd.RecordCount);
      edtQtdAti.Text     := IntToStr(objImportacao.cdsCadAti.RecordCount);
      edtQtdFor.Text     := IntToStr(objImportacao.cdsImpFor.RecordCount);
      edtQtdProd.Text    := IntToStr(objImportacao.cdsImpPro.RecordCount);

      mmoLog.Lines.Add('Verificação da importação finalizada com sucesso!');
      mmoLog.Lines.Add('');
      mmoLog.Lines.Add('Acione a rotina [F10 - Confirmar] para efetivar a importação.');
      mmoLog.Lines.Add('');
      mmoLog.Lines.Add('');
      mmoLog.Lines.Add('');
    End Else Begin
      edtQtdDep.Text     := '0';
      edtQtdLinGru.Text  := '0';
      edtQtdMar.Text     := '0';
      edtQtdUni.Text     := '0';
      edtQtdGruProd.Text := '0';
      edtQtdAti.Text     := '0';
      edtQtdFor.Text     := '0';
      edtQtdProd.Text    := '0';
      edtProdPend.Text:= '0';
      edtProdPend.Text:= '0';


      mmoLog.Lines.Add('Verificação da importação finalizada com erros. Verifique!');
    End;
  Finally
    pnlProgresso.Visible := False;
    lblGeral.Visible     := False;
    lblDetalhe.Visible   := False;

    pCarregaRegPendentes;
  End;
end;

procedure TfrmImportaProdFranq.edtDetAtiClick(Sender: TObject);
begin
  inherited;

  If (objImportacao.cdsCadAti.RecordCount > 0) Then
    pExibirTelaDetalhes(tcAtividade, objImportacao.cdsCadAti)
  Else
    fMensagem('ATENÇÃO!', 'Não há registros para serem visualizados!' , ['&OK']);
end;

procedure TfrmImportaProdFranq.edtDetDepClick(Sender: TObject);
begin
  inherited;

  If (objImportacao.cdsCadDep.RecordCount > 0) Then
    pExibirTelaDetalhes(tcDepartamento, objImportacao.cdsCadDep)
  Else
    fMensagem('ATENÇÃO!', 'Não há registros para serem visualizados!' , ['&OK']);
end;

procedure TfrmImportaProdFranq.edtDetForClick(Sender: TObject);
begin
  inherited;

  If (objImportacao.cdsImpFor.RecordCount > 0) Then
    pExibirTelaDetalhes(tcFornecedores, objImportacao.cdsImpFor)
  Else
    fMensagem('ATENÇÃO!', 'Não há registros para serem visualizados!' , ['&OK']);
end;

procedure TfrmImportaProdFranq.edtDetGruProdClick(Sender: TObject);
begin
  inherited;

  If (objImportacao.cdsGrpPrd.RecordCount > 0) Then
    pExibirTelaDetalhes(tcGrupoProduto, objImportacao.cdsGrpPrd)
  Else
    fMensagem('ATENÇÃO!', 'Não há registros para serem visualizados!' , ['&OK']);
end;

procedure TfrmImportaProdFranq.edtDetLinGruClick(Sender: TObject);
begin
  inherited;

  If (objImportacao.cdsCadGru.RecordCount > 0) Then
    pExibirTelaDetalhes(tcLinhaGrupo, objImportacao.cdsCadGru)
  Else
    fMensagem('ATENÇÃO!', 'Não há registros para serem visualizados!' , ['&OK']);
end;

procedure TfrmImportaProdFranq.edtDetMarClick(Sender: TObject);
begin
  inherited;

  If (objImportacao.cdsCadMar.RecordCount > 0) Then
    pExibirTelaDetalhes(tcMarca, objImportacao.cdsCadMar)
  Else
    fMensagem('ATENÇÃO!', 'Não há registros para serem visualizados!' , ['&OK']);
end;

procedure TfrmImportaProdFranq.edtDetProdClick(Sender: TObject);
begin
  inherited;

  If (objImportacao.cdsImpPro.RecordCount > 0) Then
    pExibirTelaDetalhes(tcProduto, objImportacao.cdsImpPro)
  Else
    fMensagem('ATENÇÃO!', 'Não há registros para serem visualizados!' , ['&OK']);
end;

procedure TfrmImportaProdFranq.edtDetUniClick(Sender: TObject);
begin
  inherited;

  If (objImportacao.cdsCadUni.RecordCount > 0) Then
    pExibirTelaDetalhes(tcUnidade, objImportacao.cdsCadUni)
  Else
    fMensagem('ATENÇÃO!', 'Não há registros para serem visualizados!' , ['&OK']);
end;

procedure TfrmImportaProdFranq.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  FreeAndNil(objImportacao);
  FreeAndNil(GerOpcDin);
end;

Function TfrmImportaProdFranq.fUpdateFRALOT: Boolean;
  Var
    qryUpdate: TUniQuery;
Begin
  Try
    qryUpdate := fCriaQuery;
    qryUpdate.SQL.Text := 'UPDATE CFGSIS SET SIS_VALCFG = :VALCFG WHERE SIS_CODCFG = "CFG_FRALOT" AND SIS_CODEMP = :CODEMP';
    qryUpdate.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryUpdate.ParamByName('VALCFG').AsString := edtQtdLot.Text;
    qryUpdate.Execute;

    Result := True;

    FreeAndNil(qryUpdate);

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, 'TfrmImportaProdFranq.fUpdateFRALOT');
    End;
  End;
End;

procedure TfrmImportaProdFranq.FormCreate(Sender: TObject);
begin
  inherited;
  btnDefineCampos.Visible := fVerificaAcessoSistema('LFGCPF');
  GerOpcDin := TGerOpcDin.Create(Self.Name,
    TBuilderOpcDin.fNovo.pAdd('ITE_COMVAR', 'Comissão Vendedor Externo', True)
                        .pAdd('ITE_COMATA', 'Comissão Representante Externo - Loja', True)
                        .pAdd('ITE_COMDIS', 'Comissão Representante Externo - Distribuidor', True)
                        .pAdd('ITE_COMTB1', '% Comissão Tab. 1', True)
                        .pAdd('ITE_COMTB2', '% Comissão Tab. 2', True)
                        .pAdd('ITE_COMTB3', '% Comissão Tab. 3', True)
                        .pAdd('ITE_COMTB4', '% Comissão Tab. 4', True)
                        .pAdd('ITE_COMTB5', '% Comissão Tab. 5', True)
                        .pAdd('ITE_COMTB6', '% Comissão Tab. 6', True)
                        .pAdd('ITE_COMTB7', '% Comissão Tab. 7', True)
                        .pAdd('ITE_MARMIN', 'Margem Mínima Vendedor - Júnior', True)
                        .pAdd('ITE_MARMSG', 'Margem Mínima Subgerente - Júnior', True)
                        .pAdd('ITE_MARMGE', 'Margem Mínima Gerente - Júnior', True)
                        .pAdd('ITE_DESMAX', 'Desconto Máximo Vendedor - Júnior', True)
                        .pAdd('ITE_DESMSU', 'Desconto Máximo Subgerente - Júnior', True)
                        .pAdd('ITE_DESMGE', 'Desconto Máximo Gerente - Júnior', True)
                        .pAdd('ITE_ESTMIN', 'Estoque Mínimo', True)
                        .pAdd('ITE_ESMIDG', 'Estoque Mínimo Digitado', True)
                        .pAdd('ITE_ESTMAX', 'Estoque Máximo', True)
                        .pAdd('ITE_NVLGIR', 'Nível de Giro', True)
                        .pAdd('ITE_LOCFIS', 'Localização Física', True)
                        .pAdd('ITE_LOCSUP', 'Localização Super Estoque', True)
                        .pAdd('ITE_REAEND', 'Realiza Endereçamento', True)
                        .pAdd('ITE_RPRENT', 'Permite Redução de Preços', True)
                        .pAdd('ITE_TMPGAR', 'Tempo de Garantia', True)
                        .pAdd('ITE_BAREXP', 'Obrigar Código de Barras na Expedição', True)
                        .fBuild
  );
  objImportacao := nil;
end;

procedure TfrmImportaProdFranq.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If (Key = VK_ESCAPE) Then
    btnSair.Click();

  If (Key = VK_F10) Then
    btnConfirma.Click();

  If (Key = VK_F11) Then
    btnVerDados.Click();

  If (Key = VK_F12) Then
    btnDefineCampos.Click();
end;

procedure TfrmImportaProdFranq.FormShow(Sender: TObject);
begin
  inherited;

  pLimparComponentes();

  edtQtdLot.Text := fCfgSis('FRALOT', varInteger);

  objImportacao := TImportacaoCadastros.Create(Nil, mmoLog, mmoExclusao, pgrGeral, pgrDetalhe);
end;

procedure TfrmImportaProdFranq.pExibirTelaDetalhes(tcTipoCad: TTipoCad; cdsDados: TUniClientDataSet);
begin
  Try
    pCriarFormularios(TfrmImpFranquiaDetalhe, frmImpFranquiaDetalhe);
    frmImpFranquiaDetalhe.tcTipoCad := tcTipoCad;
    frmImpFranquiaDetalhe.objImportacao := objImportacao;

    frmImpFranquiaDetalhe.ShowModal();
  Finally
    FreeAndNil(frmImpFranquiaDetalhe);
  End;
end;

procedure TfrmImportaProdFranq.pCarregaRegPendentes;
var
  qryAux: TUniQuery;
const
  SQL_PROD = 'SELECT COUNT(1) AS COUNT FROM IMP_PRODUTO WHERE IMP_DTAIMP IS NULL';
  SQL_FORN = 'SELECT COUNT(1) AS COUNT FROM IMP_FORNECEDOR WHERE IMP_DTAIMP IS NULL';
begin
  Try
    Try
      qryAux := fCriaQuery;

      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Add(SQL_PROD);
      qryAux.Open;

      edtProdPend.Text := qryAux.FieldByName('COUNT').AsString;

      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Add(SQL_FORN);
      qryAux.Open;
      edtFornPend.Text := qryAux.FieldByName('COUNT').AsString;

    Finally
      FreeAndNil(qryAux);
    End;

  Except On
    E:Exception Do
    Begin
       pMensagensErro(E.Message, 'TfrmImportaProdFranq.pCarregaRegPendentes');
    End;
  End;

end;

procedure TfrmImportaProdFranq.pLimparComponentes;
begin
  edtQtdDep.Text     := '0';
  edtQtdLinGru.Text  := '0';
  edtQtdMar.Text     := '0';
  edtQtdUni.Text     := '0';
  edtQtdGruProd.Text := '0';
  edtQtdAti.Text     := '0';
  edtQtdFor.Text     := '0';
  edtQtdProd.Text    := '0';
  mmoLog.Texto       := 'Nenhuma importação realizada...';
  mmoExclusao.Texto  := 'Nenhuma importação realizada...';

  edtProdPend.Text := '0';
  edtFornPend.Text := '0';

  pgrGeral.Min        := 0;
  pgrGeral.Max        := 0;
  pgrGeral.Position   := 0;
  pgrDetalhe.Min      := 0;
  pgrDetalhe.Max      := 0;
  pgrDetalhe.Position := 0;

  pnlProgresso.Visible := False;
  tbsLogGeral.Show();
end;

function TfrmImportaProdFranq.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender)) Then
  Begin

    If (Sender = edtQtdLot) Then
    Begin

      If StrToIntDef(edtQtdLot.Text, -1) <= 0 Then
      Begin
        Result := False;
        pMensagemOk('A quantidade de registros para processamento deve ser maior que zero!');
      End;

    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);

End;


end.
