unit untFatFatorServico;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, frxClass, Uni, untMsgLiberacao, untLiberacao,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons, untFatGor,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus, untFuncFat, System.TypInfo, untFuncFatTypes,
  Shared.Functions.DataSet;


type
  TfrmFatFatorServico = class(TfrmPaiSimples)
    pnlPrincipal: TPanel;
    btnConfirma: TBitBtnLocked;
    pnlCabecalho: TPanel;
    pnlInformacao: TPanel;
    pnlFator: TPanel;
    lblPedOrc: TLabel;
    edtNumDoc: TEditFocus;
    edtEspDoc: TEditFocus;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    lblCliente: TLabel;
    lblVendedor: TLabel;
    lblFpgPto: TLabel;
    lblCndPto: TLabel;
    lblDtaEmi: TLabel;
    edtCodCli: TEditFocus;
    edtCodVen: TEditFocus;
    edtCodCnd: TEditFocus;
    edtCodFpg: TEditFocus;
    edtDtaEmi: TEditFocus;
    edtNomCli: TEditFocus;
    edtNomVen: TEditFocus;
    edtNomCnd: TEditFocus;
    edtNomFpg: TEditFocus;
    lblVlrTot: TLabel;
    edtVlrTot: TEditFocus;
    lblFator: TLabel;
    edtFator: TEditFocus;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtNumDocKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
  private
    { Private declarations }
    FESPCFO: String;
    objLiberacao : TLiberacao;
    FAutIncPedOrc: String;
    FObjFatVenda: TFatVenda;
    FAutIncPedidoBkp: String;
    function fValidaPedidoOrcamento(ANumDoc: String): Boolean;
    function fLiberouAcesso: Boolean;
    function fCarregaPedido: Boolean;
    function fAplicaFatorPedido: Boolean;
    procedure pLimpaTela;
    procedure pInserirItemServico;
    function fRetorIndiceServiço: Integer;
    procedure pInserirServico;
    function fCarregaPedidoBackupFatorServico: TPedidoOriginalFatorServico;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;


implementation

uses
  untFuncoesSimples, untTypesSistema, untConsultas, untGravando;

{$R *.dfm}

procedure TfrmFatFatorServico.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  TfrmGravando.fExecutarModal(pInserirServico, 'Aguarde, Alterando Pedido...', '');
end;

procedure TfrmFatFatorServico.edtNumDocKeyPress(Sender: TObject; var Key: Char);
var
  LQryFatGor: TUniQuery;
  LArrSel: TConsultasArray;
  LEspDoc: String;
begin
  inherited;

  if key = #13 then
  begin
    if fValidaCampos(edtNumDoc, True) then
      Exit;
  end;

  LQryFatGor := fCriaQuery;

  try
    LEspDoc := IIF(FESPCFO = 'OR', 'OR', 'PD');

    If fPesqPedOrc(conPedCompleta, Self, LEspDoc, LEspDoc, VS_strCodEmp ,edtNumDoc, edtEspDoc, edtCodEmp, LQryFatGor, Key, LArrSel) Then
    begin
      If (fValidaCampos(edtNumDoc, True)) Then
        SelectNext(ActiveControl, True, True);
    end;
  finally
    FreeAndNil(LQryFatGor);
  end;
end;

function TfrmFatFatorServico.fAplicaFatorPedido: Boolean;
var
  LValorServico: Double;
  LContador: Integer;
  frmGravando: TfrmGravando;
  LExibirMensagemAoUsuarioBKP: Boolean;
  LIndice: Integer;
  LObjServicos: TClassDadosServicos;
  LFator: Double;
  LPerIss: Double;
  LRedIss: Double;
  LTotalPedido: Double;
  LobjPedido: TPedidoOriginalFatorServico;
begin
  pCriarFormularios(TfrmGravando,frmGravando);
  LExibirMensagemAoUsuarioBKP := VS_ExibirMensagemAoUsuario;
  LObjServicos := TClassDadosServicos.Create(FObjFatVenda.FRecSer);

  try
    Result := False;

    try
      VS_ExibirMensagemAoUsuario := False;

      FObjFatVenda.blnValidarDadosNotaEletronica := False;

      LobjPedido := fCarregaPedidoBackupFatorServico;

      LFator := 1 - StrToFloatDef(edtFator.Text, 0);
      LTotalPedido := FObjFatVenda.fltTotGer;

      LIndice := fRetorIndiceServiço;

      pInserirItemServico;

      FObjFatVenda.pPreencheMatrizFechamento;

      for LContador := 0 to Length(FObjFatVenda.arrMatItens) - 1 do
      begin
        if not fEhItemServico(FObjFatVenda.arrMatItens[LContador].strCodIte) then
        begin
          FObjFatVenda.arrMatItens[LContador].fltUniTar := fFormataFloat((FObjFatVenda.arrMatItens[LContador].fltUniTar * LFator), fCfgSis('DECUNI', varInteger));
          FObjFatVenda.arrMatItens[LContador].fltUniDig := fFormataFloat((FObjFatVenda.arrMatItens[LContador].fltUniDig * LFator), fCfgSis('DECUNI', varInteger));
        end;
      end;

      if FObjFatVenda.fltDesEsp > 0 then
        FObjFatVenda.fltDesEsp := fFormataFloat(FObjFatVenda.fltDesEsp * LFator, 2);

      FObjFatVenda.pCalculaTotGer;

      LValorServico := LTotalPedido - FObjFatVenda.fltTotGer;

      SetPropValue(LObjServicos, 'fltQtdS' + fStrZero(LIndice.ToString, 2), 1);
      SetPropValue(LObjServicos, 'strCodS' + fStrZero(LIndice.ToString, 2), fCfgSis('FNSCSV'));
      SetPropValue(LObjServicos, 'strDesS' + fStrZero(LIndice.ToString, 2), fCampoTabela('SER_DESSER', 'CADSER', ['SER_CODSER'], [fCfgSis('FNSCSV')], False));
      SetPropValue(LObjServicos, 'fltUniS' + fStrZero(LIndice.ToString, 2), LValorServico);
      SetPropValue(LObjServicos, 'fltValS' + fStrZero(LIndice.ToString, 2), LValorServico);
      SetPropValue(LObjServicos, 'strVenS' + fStrZero(LIndice.ToString, 2), FObjFatVenda.strCodVen);
      SetPropValue(LObjServicos, 'strIdeS' + fStrZero(LIndice.ToString, 2), 'S');
      LObjServicos.strDisSer := Concat(LObjServicos.strDisSer, ' ', fCfgSis('FNSDSV'));
      LObjServicos.fltTotSer := LObjServicos.fltTotSer + LValorServico;

      if fCfgSis('ISSSER', varBoolean) then
      begin
        LPerIss := fCampoTabela('SER_ALQISS', 'CADSER', ['SER_CODSER'], [fCfgSis('FNSCSV')]);
        LRedIss := fCampoTabela('SER_REDISS', 'CADSER', ['SER_CODSER'], [fCfgSis('FNSCSV')]);

        if (LIndice > 0) then
        begin
          if (LObjServicos.fltPerIss <> LPerIss) then
          begin
            fMensagem('ATENÇÃO!', 'A alíquota de ISS dos serviços devem ser todas iguais!', ['&OK']);
            Exit;
          end;

          if (LObjServicos.fltRedIss <> LRedIss) then
          begin
            fMensagem('ATENÇÃO!', 'A redução de ISS dos serviços devem ser todas iguais!', ['&OK']);
            Exit;
          end;
        end;
      end
      else
      begin
        LPerIss := fCfgSis('PERISS', varDouble);
        LRedIss := fCfgSis('REDISS', varDouble);
        LObjServicos.fltPerIss := LPerIss;
        LObjServicos.fltRedIss := LRedIss;
      end;

      LObjServicos.fltBasIss := fFormataFloat(LObjServicos.fltTotSer  * (1 - LObjServicos.fltRedIss / 100.0), 2);
      LObjServicos.fltValIss := fCalculaValorIss(LObjServicos.fltBasIss, LObjServicos.fltPerIss);

      FObjFatVenda.FRecSer := LObjServicos.recServicos;

      FObjFatVenda.pPreencheMatrizFechamento;

      for LContador := 0 to Length(FObjFatVenda.arrMatItens) - 1 do
      begin
        if not fEhItemServico(FObjFatVenda.arrMatItens[LContador].strCodIte) then
        begin
          FObjFatVenda.arrMatItens[LContador].fltUniTar := fFormataFloat((FObjFatVenda.arrMatItens[LContador].fltUniTar * LFator), fCfgSis('DECUNI', varInteger));
          FObjFatVenda.arrMatItens[LContador].fltUniDig := fFormataFloat((FObjFatVenda.arrMatItens[LContador].fltUniDig * LFator), fCfgSis('DECUNI', varInteger));
        end;
      end;

      FObjFatVenda.pCalculaTotGer;

      frmGravando.strChave := 'FATVENDAS';

      FObjFatVenda.FPedidoFatorServico := LobjPedido;
      FObjFatVenda.FAplicouFatorDeServico := True;

      frmGravando.fExecutarAcao := FObjFatVenda.fGravaArquivosDesmembrandoVenda;
      frmGravando.ShowModal;

      FAutIncPedOrc := FObjFatVenda.strAutIncFatGor;

      Result := frmGravando.blnConfirma;

    except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmFatFatorServico.fAplicaFatorPedido]');
        Exit;
      End;
    end;
  finally
    VS_ExibirMensagemAoUsuario := LExibirMensagemAoUsuarioBKP;
    pFreeAndNil(frmGravando);
    FreeAndNil(LObjServicos);
  end;

end;

function TfrmFatFatorServico.fCarregaPedido: Boolean;
var
  LQryFatGor: TUniQuery;
  LDeletouItens: Boolean;
begin
  LQryFatGor := fCriaQuery;

  try
    Result := False;

    LQryFatGor.Close;
    LQryFatGor.SQL.Clear;
    LQryFatGor.SQL.Add(fSelectFromFatgorLeftAuxiliares(False));
    LQryFatGor.SQL.Add('WHERE ');
    LQryFatGor.SQL.Add('  F.FGO_NUMDOC = :NUMDOC AND ');
    LQryFatGor.SQL.Add('  F.FGO_ESPDOC = :ESPDOC AND ');
    LQryFatGor.SQL.Add('  F.FGO_CODEMP = :CODEMP ');
    LQryFatGor.ParamByName('NUMDOC').AsString := edtNumDoc.Text;
    LQryFatGor.ParamByName('ESPDOC').AsString := FESPCFO;
    LQryFatGor.ParamByName('CODEMP').AsString := VS_strCodEmp;
    LQryFatGor.Open;

    cdsVenda.EmptyDataSet;
    FObjFatVenda.strOriF11 := 'S';
    FObjFatVenda.strNumOrc := edtNumDoc.Text;
    FObjFatVenda.strEspOrc := FESPCFO;
    FObjFatVenda.strEmpOri := VS_strCodEmp;
    FObjFatVenda.strEspDoc := FESPCFO;
    FObjFatVenda.fltFatorServico := StrToFloatDef(edtFator.Text, 0);

    FObjFatVenda.blnAplicouFatorServico := True;

    FObjFatVenda.pCarregaCondicaoPagamentoPedido(LQryFatGor);
    untFuncFat.pCarregarClientePedidoOrcamento(FObjFatVenda);

    try
      FObjFatVenda.pCarregaPedidoOrcamento(LQryFatGor, LDeletouItens);
      FObjFatVenda.pPreencheMatrizFechamento;
      FObjFatVenda.pCalculaTotGer;
    except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmFatFatorServico.fCarregaPedido]');
        Exit;
      End;
    end;

    Result := fAplicaFatorPedido;
  finally
    FreeAndNil(LQryFatGor);
  end;
end;

function TfrmFatFatorServico.fCarregaPedidoBackupFatorServico: TPedidoOriginalFatorServico;
var
  LinfPedido: IMyCampoTabela;
  LItensPedido: TUniQuery;
begin
  LinfPedido := fCampoTabela(['FGO_NUMDOC','FGO_ESPDOC','FGO_CODEMP','FGO_CODCLI','FGO_TOTPRO','FGO_DESESP',
                              'FGO_BASIPI','FGO_TOTIPI','FGO_BASICM','FGO_TOTICM','FGO_BASRET','FGO_TOTRET'],'FATGOR',['AUTOINCREM'],[FAutIncPedidoBkp]);

  Result.strNumDoc := LinfPedido.FieldByName('FGO_NUMDOC').AsString;
  Result.strEspDoc := LinfPedido.FieldByName('FGO_ESPDOC').AsString;
  Result.strCodEmp := LinfPedido.FieldByName('FGO_CODEMP').AsString;
  Result.strCodCli := LinfPedido.FieldByName('FGO_CODCLI').AsString;
  Result.fltTotPro := LinfPedido.FieldByName('FGO_TOTPRO').AsFloat;
  Result.fltDesEsp := LinfPedido.FieldByName('FGO_DESESP').AsFloat;
  Result.fltBasIpi := LinfPedido.FieldByName('FGO_BASIPI').AsFloat;
  Result.fltTotIpi := LinfPedido.FieldByName('FGO_TOTIPI').AsFloat;
  Result.fltBasIcm := LinfPedido.FieldByName('FGO_BASICM').AsFloat;
  Result.fltTotIcm := LinfPedido.FieldByName('FGO_TOTICM').AsFloat;
  Result.fltBasRet := LinfPedido.FieldByName('FGO_BASRET').AsFloat;
  Result.fltTotRet := LinfPedido.FieldByName('FGO_TOTRET').AsFloat;

  LItensPedido := fCriaQuery;

  try
    LItensPedido.Close;
    LItensPedido.SQL.Clear;
    LItensPedido.SQL.Add('SELECT FDO_NUMDOC, FDO_ESPDOC, FDO_CODEMP, FDO_CODCLI, FDO_CODITE, FDO_SEQIND,');
    LItensPedido.SQL.Add('       FDO_UNITAR, FDO_TOTITE, FDO_VLRCON, FDO_COMREP, FDO_TOTCOM, FDO_UNIDIG,');
    LItensPedido.SQL.Add('       FDO_VALFLE, FDO_UNDIDE, FDO_DESESP, FDO_BASIPI, FDO_VALIPI, FDO_BASICM,');
    LItensPedido.SQL.Add('       FDO_VALICM, FDO_BASRET, FDO_VALRET');
    LItensPedido.SQL.Add('FROM FATDOR');
    LItensPedido.SQL.Add('INNER JOIN EXTDOR');
    LItensPedido.SQL.Add('ON(FATDOR.AUTOINCREM = EXTDOR.FDO_SEQFDO)');
    LItensPedido.SQL.Add('WHERE FDO_SEQGER = :SEQGER');

    LItensPedido.ParamByName('SEQGER').AsString := FAutIncPedidoBkp;

    LItensPedido.Open;

    FillChar(Result.objItensPedido, SizeOf(Result.objItensPedido), #0);
    SetLength(Result.objItensPedido, LItensPedido.RecordCount);

    while not LItensPedido.Eof do
    begin
      Result.objItensPedido[LItensPedido.RecNo - 1].strNumDoc :=  LItensPedido.FieldByName('FDO_NUMDOC').AsString;
      Result.objItensPedido[LItensPedido.RecNo - 1].strEspDoc :=  LItensPedido.FieldByName('FDO_ESPDOC').AsString;
      Result.objItensPedido[LItensPedido.RecNo - 1].strCodEmp :=  LItensPedido.FieldByName('FDO_CODEMP').AsString;
      Result.objItensPedido[LItensPedido.RecNo - 1].strCodCli :=  LItensPedido.FieldByName('FDO_CODCLI').AsString;
      Result.objItensPedido[LItensPedido.RecNo - 1].strCodIte :=  LItensPedido.FieldByName('FDO_CODITE').AsString;
      Result.objItensPedido[LItensPedido.RecNo - 1].intSeqInd :=  LItensPedido.FieldByName('FDO_SEQIND').AsInteger;
      Result.objItensPedido[LItensPedido.RecNo - 1].fltUniTar :=  LItensPedido.FieldByName('FDO_UNITAR').AsFloat;
      Result.objItensPedido[LItensPedido.RecNo - 1].fltTotIte :=  LItensPedido.FieldByName('FDO_TOTITE').AsFloat;
      Result.objItensPedido[LItensPedido.RecNo - 1].fltVlrCon :=  LItensPedido.FieldByName('FDO_VLRCON').AsFloat;
      Result.objItensPedido[LItensPedido.RecNo - 1].fltComRep :=  LItensPedido.FieldByName('FDO_COMREP').AsFloat;
      Result.objItensPedido[LItensPedido.RecNo - 1].fltTotCom :=  LItensPedido.FieldByName('FDO_TOTCOM').AsFloat;
      Result.objItensPedido[LItensPedido.RecNo - 1].fltUniDig :=  LItensPedido.FieldByName('FDO_UNIDIG').AsFloat;
      Result.objItensPedido[LItensPedido.RecNo - 1].fltValFle :=  LItensPedido.FieldByName('FDO_VALFLE').AsFloat;
      Result.objItensPedido[LItensPedido.RecNo - 1].fltUndIde :=  LItensPedido.FieldByName('FDO_UNDIDE').AsFloat;
      Result.objItensPedido[LItensPedido.RecNo - 1].fltDesEsp :=  LItensPedido.FieldByName('FDO_DESESP').AsFloat;
      Result.objItensPedido[LItensPedido.RecNo - 1].fltBasIpi :=  LItensPedido.FieldByName('FDO_BASIPI').AsFloat;
      Result.objItensPedido[LItensPedido.RecNo - 1].fltValIpi :=  LItensPedido.FieldByName('FDO_VALIPI').AsFloat;
      Result.objItensPedido[LItensPedido.RecNo - 1].fltBasIcm :=  LItensPedido.FieldByName('FDO_BASICM').AsFloat;
      Result.objItensPedido[LItensPedido.RecNo - 1].fltValIcm :=  LItensPedido.FieldByName('FDO_VALICM').AsFloat;
      Result.objItensPedido[LItensPedido.RecNo - 1].fltBasRet :=  LItensPedido.FieldByName('FDO_BASRET').AsFloat;
      Result.objItensPedido[LItensPedido.RecNo - 1].fltValRet :=  LItensPedido.FieldByName('FDO_VALRET').AsFloat;

      LItensPedido.Next;
    end;
  finally
    FreeAndNil(LItensPedido);
  end;
end;


function TfrmFatFatorServico.fLiberouAcesso: Boolean;
begin
  Result := True;

  if fVerificaAcessoSistema('FNSPED') then
    Exit;

  objLiberacao.Clear;
  objLiberacao.objMsgLibera.pAddTexto('Informar Fator para Nota de Serviço no Orçamento/Pedido.');
  objLiberacao.objMsgLibera.pAddSeparador(67);
  objLiberacao.objMsgLibera.pAddTextoCaption('PEDIDO......', Concat(edtNumDoc.Text,'-',edtEspDoc.Text,'-',edtCodEmp.Text), 12, alEsquerda, teAmbos, '', 19);
  objLiberacao.objMsgLibera.pAddTextoCaption('CLIENTE.....', Concat(edtCodCli.Text,'-',edtNomCli.Text), 12, alEsquerda, teAmbos, '', 80);
  objLiberacao.objMsgLibera.pAddTextoCaption('VENDEDOR....', Concat(edtCodVen.Text,'-',edtNomVen.Text), 12, alEsquerda, teAmbos, '', 80);
  objLiberacao.objMsgLibera.pAddTextoCaption('COND.PAGTO..', Concat(edtCodCnd.Text,'-',edtNomCnd.Text,' ',fFormataCondPag(fRetConPag(edtCodCnd.Text))), 12, alEsquerda, teAmbos, '', 80);
  objLiberacao.objMsgLibera.pAddTextoCaption('FORMA PAGTO.', Concat(edtCodFpg.Text,'-',edtNomFpg.Text), 12, alEsquerda, teAmbos, '', 80);
  objLiberacao.objMsgLibera.pAddTextoCaption('VR.TOTAL DOC', edtVlrTot.Text, 12, alEsquerda, teAmbos, '', 10);
  objLiberacao.objMsgLibera.pAddSeparador(67);
  objLiberacao.objMsgLibera.pAddTextoCaption('FATOR.......', edtFator.Text, 12, alEsquerda, teAmbos, '', 10);
  objLiberacao.objMsgLibera.pAddSeparador(67);

  objLiberacao.strDirAce := 'FNSPED';
  objLiberacao.strMsgSen := 'Informar Fator para Nota de Serviço no Orçamento/Pedido.';
  objLiberacao.strCodOpe := strLoginUsuarioLogado;

  Result := objLiberacao.fLibera;
end;

procedure TfrmFatFatorServico.FormCreate(Sender: TObject);
begin
  inherited;
  FESPCFO := fCfgSis('ESPCFO');
  lblPedOrc.Caption := IIF(FESPCFO = 'OR', 'Orçamento:', 'Pedido:');
  objLiberacao := TLiberacao.Create;
  FAutIncPedOrc := EmptyStr;
  pCriarCdsVenda(Self);
  FObjFatVenda := TFatVenda.CreateInstance(FESPCFO);
  FAutIncPedidoBkp := EmptyStr;
end;

procedure TfrmFatFatorServico.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(objLiberacao);

  if Assigned(FObjFatVenda) then
    FreeAndNil(FObjFatVenda);
end;

procedure TfrmFatFatorServico.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  case key of
    VK_F10: btnConfirma.Click;
  end;
end;

procedure TfrmFatFatorServico.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(edtNumDoc);
end;

function TfrmFatFatorServico.fRetorIndiceServiço: Integer;
begin
  Result := fCampoTabela('COUNT(FGO_SEQFGO) AS INDICE', 'SERGOR', ['FGO_SEQFGO'], [FObjFatVenda.strIncOrc], False) + 1;
end;

function TfrmFatFatorServico.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtNumDoc) Then
    Begin
      If fEmptyStr(edtNumDoc.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe o documento!', ['&Ok']);
        Result := False;
      End
      Else If Not fValidaPedidoOrcamento(edtNumDoc.Text) Then
        Result := False;
    End
    Else If (Sender = edtFator) Then
    Begin
      if (StrToFloatDef(edtFator.Text, 0) <= 0) Or (StrToFloatDef(edtFator.Text, 0) > 1) then
      begin
        fMensagem('ATENÇÃO!', 'O Fator para Nota Especial deve estar enter 0.00000001 e 1.00000000, verifique!', ['&Ok']);
        Result := False;
      end;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmFatFatorServico.fValidaPedidoOrcamento(ANumDoc: String): Boolean;
var
  LQryPedido: TUniQuery;
begin
  LQryPedido := fCriaQuery;

  try
    Result := True;

    LQryPedido.Close;
    LQryPedido.SQL.Clear;
    LQryPedido.SQL.Add('SELECT F.AUTOINCREM, F.FGO_ESPDOC, F.FGO_CODEMP, F.FGO_CODCLI, F.FGO_CODVEN,');
    LQryPedido.SQL.Add('       F.FGO_CODCND, F.FGO_CODFPG, F.FGO_DTAENT, F.FGO_VLRCON, IFNULL(E.FGO_FATSER, 0) AS FATSER');
    LQryPedido.SQL.Add('FROM FATGOR F');
    LQryPedido.SQL.Add('INNER JOIN EXTGOR E');
    LQryPedido.SQL.Add('ON(F.AUTOINCREM = E.FGO_SEQFGO)');
    LQryPedido.SQL.Add('WHERE F.FGO_NUMDOC = :NUMDOC');
    LQryPedido.SQL.Add('AND F.FGO_ESPDOC = :ESPDOC');
    LQryPedido.SQL.Add('AND F.FGO_CODEMP = :CODEMP');
    LQryPedido.ParamByName('NUMDOC').AsString := ANumDoc;
    LQryPedido.ParamByName('ESPDOC').AsString := IIF(FESPCFO = 'OR', 'OR', 'PD');
    LQryPedido.ParamByName('CODEMP').AsString := VS_strCodEmp;
    LQryPedido.Open;

    if LQryPedido.IsEmpty then
    begin
      fMensagem('ATENÇÃO!', ''+IIF(FESPCFO = 'OR', 'Orçamento', 'Pedido')+' não encontrado!', ['&Ok']);
      Result := False;
      Exit;
    end;

    if LQryPedido.FieldByName('FATSER').AsFloat > 0 then
    begin
      fMensagem('ATENÇÃO!', 'O '+IIF(FESPCFO = 'OR', 'Orçamento', 'Pedido')+' informado já possui fator!', ['&Ok']);
      Result := False;
      Exit;
    end;

    FAutIncPedidoBkp := LQryPedido.FieldByName('AUTOINCREM').AsString;
    edtEspDoc.Text := LQryPedido.FieldByName('FGO_ESPDOC').AsString;
    edtCodEmp.Text := LQryPedido.FieldByName('FGO_CODEMP').AsString;
    edtCodCli.Text := LQryPedido.FieldByName('FGO_CODCLI').AsString;
    edtCodVen.Text := LQryPedido.FieldByName('FGO_CODVEN').AsString;
    edtCodCnd.Text := LQryPedido.FieldByName('FGO_CODCND').AsString;
    edtCodFpg.Text := LQryPedido.FieldByName('FGO_CODFPG').AsString;
    edtDtaEmi.Text := DateToStr(LQryPedido.FieldByName('FGO_DTAENT').AsDateTime);
    edtVlrTot.Text := FormatFloat('#,##0.00', LQryPedido.FieldByName('FGO_VLRCON').AsFloat);
    edtNomEmp.Text := fRetNomeEmpresa;
    edtNomCli.Text := fRetNomCliente(edtCodCli.Text);
    edtNomVen.Text := fRetNomVendRep(edtCodVen.Text);
    edtNomCnd.Text := fRetDesConPag(edtCodCnd.Text);
    edtNomFpg.Text := fRetDescFpg(edtCodFpg.Text);
  finally
    FreeAndNil(LQryPedido);
  end;
end;

procedure TfrmFatFatorServico.pInserirItemServico;
Var
  qryCadIte,
  qryIteGer,
  qryAbfIcm: TUniQuery;
  LCodIte: String;
begin

  qryCadIte := fCriaQuery(Nil);
  qryIteGer := fCriaQuery(Nil);
  qryAbfIcm := fCriaQuery(Nil);

  try
    LCodIte := fCfgSis('ITESER');
    qryCadIte.SQL.Add('SELECT * FROM CADITE WHERE ITE_CODITE = :CODITE');
    qryCadIte.ParamByName('CODITE').AsString := LCodIte;
    qryCadIte.Open;

    qryIteGer.SQL.Add('SELECT * FROM ITEGER WHERE ITE_CODITE = :CODITE AND ITE_CODEMP = :CODEMP');
    qryIteGer.ParamByName('CODITE').AsString := LCodIte;
    qryIteGer.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryIteGer.Open;

    qryAbfIcm.SQL.Add('SELECT * FROM ABFICM WHERE ABF_CODABF = :CODABF AND ABF_ESTADO = :ESTADO');

    If fCfgSis('TIPABF') = '1' Then
      qryAbfIcm.ParamByName('CODABF').AsString := qryCadIte.FieldByName('ITE_CODABF').AsString
    Else
      qryAbfIcm.ParamByName('CODABF').AsString := qryIteGer.FieldByName('ITE_CODABF').AsString;

    qryAbfIcm.ParamByName('ESTADO').AsString := FObjFatVenda.strCliEst;
    qryAbfIcm.Open;

    FObjFatVenda.pInserirItemServico(Nil, qryCadIte, qryIteGer, qryAbfIcm, '');
  finally
    FreeAndNil(qryCadIte);
    FreeAndNil(qryIteGer);
    FreeAndNil(qryAbfIcm);
  end;
end;

procedure TfrmFatFatorServico.pInserirServico;
begin
  if not fVerificaCampos then
    Exit;

  if not fLiberouAcesso then
    Exit;

  if not fCarregaPedido then
  begin
    pLimpaTela;

    if Assigned(FObjFatVenda) then
    begin
      FreeAndNil(FObjFatVenda);
      FObjFatVenda := TFatVenda.CreateInstance(FESPCFO);
    end;

    Exit;
  end;

  fMensagem('ATENÇÃO!', 'Documento alterado com sucesso!', ['&Ok']);
  pLimpaTela;
end;

procedure TfrmFatFatorServico.pLimpaTela;
var
  LContador: Integer;
begin
  for LContador := 0 to Self.ComponentCount -1 do
  begin
    if (Self.Components[LContador] is TEditFocus) then
      TEditFocus(Self.Components[LContador]).Clear;
  end;

  FAutIncPedOrc := EmptyStr;
  FAutIncPedidoBkp := EmptyStr;
end;

end.
