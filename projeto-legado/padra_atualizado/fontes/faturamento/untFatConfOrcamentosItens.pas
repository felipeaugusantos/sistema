unit untFatConfOrcamentosItens;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, Grids, DBGridCitel, DBGrids,
  EditFocus, DB,  Uni, UniDataSetProvider, UniClientDataSet, StrUtils,
  MaskUtils, AppEvnts, frxClass, frxDBSet, BitBtnLockedIncrem, untMovCdb,
  TypInfo, untIteBar, MemDS, DBAccess, Provider, frxExportCSVTestabilidade,
  Datasnap.DBClient, untLiberacao, Math, Types;

type
  TfrmFatConfOrcamentosItens = class(TfrmPai)
    pnlGeral: TPanel;
    dbgItens: TDBGridCitel;
    pnlRodape: TPanel;
    lblCodBar: TLabel;
    edtCodIte: TEditFocus;
    Label2: TLabel;
    edtQtdIte: TEditFocus;
    qryItens: TUniQuery;
    dtsItens: TDataSource;
    cdsItens: TUniClientDataSet;
    dspItens: TUniDataSetProvider;
    btnQuantidade: TBitBtnLocked;
    btnConfirma: TBitBtnLocked;
    btnExpAut: TBitBtnLocked;
    btnMarcarTudo: TBitBtnLocked;
    lblLimparExpedido: TLabel;
    procedure dbgItensDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnQuantidadeClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnMarcarTudoClick(Sender: TObject);
    procedure btnExpAutClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSairClick(Sender: TObject);
    procedure dbgItensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    blnFecharForm: Boolean;
    strValBus    : String;
    strTipBus    : String;
    strCamBus    : String;
    strCodIteFor : String;
    objIteBar    : TIteBar;
    strBarBal    : String;
    blnFecharESC : Boolean;
    strNumLot    : String;

    strValBusComplementar: String;
    strCamBusComplementar: String;
    blnTemItensTintas : Boolean;
    blnNaoConfereItensTransfReq: Boolean;

    intDecQtd : Integer;

    objLiberacao : TLiberacao;
    function fTemItensTintas: Boolean;
    procedure pExpedeItem(blnValidaTrava: Boolean=true);
    procedure pCarregaItensPedido;
    procedure pOnFilter(DataSet: TDataSet; var Accept: Boolean);

    function fTotalmenteExpedido(): Boolean;

    function fEncontraItem(Var strMensagem: String): Boolean;
    function fRetEmpresa: String;
    procedure pMarcarTodosProdutos(blnValidaTrava: Boolean = False);
    procedure pGravaItensPedido;
    procedure pLimpaItemExpedidoSelecionado;
    procedure pAtualizaSepOpeExpPedido(strCodCon, strCodSep, strObsExp: String);
    function fSolicitaConferenteSeparador(var strCodCon, strCodSep, strObsExp: String): Boolean;
    function fValidaPermissaoParaConferenciaParcialDoItem(const AblnConfirma: Boolean): Boolean;
    function fItensParcialmenteConferidos: TStringList;
    procedure pAtualizaTipBus;
    procedure pValidaTransfRequisicao;
    function fTravaLIBITEF11():Boolean;
    function fTravaVALCBE():Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;

  public
    { Public declarations }

    strNumDoc: String;
    strEspDoc: String;
    strCodOpe: String;
    strCodEmp: String;
    strCodSep: String;
    strCodCon: String;
    strObsExp: String;
    dtaSepIni: TDate;
    horSepIni: TTime;

    blnDocImportadoPedOrc: Boolean;
    blnRcxF11: Boolean;
    blnRetBal: Boolean;
    blnLimExp: Boolean;

    blnConferido: Boolean;
    objCodBar: TCodigoBarras;
    blnRetiraDigSeparador : Boolean;
  end;

var
  frmFatConfOrcamentosItens: TfrmFatConfOrcamentosItens;

implementation

uses untfuncoesSimples, untConstantes, untFuncFat, untTypesSistema, untFuncoes, untFatGor,
     untFatSeparadorConferente, untCadLote;

{$R *.dfm}

function TfrmFatConfOrcamentosItens.fTemItensTintas: Boolean;
  Var
    cdsClone : TUniClientDataSet;
begin
  cdsClone := TUniClientDataSet.Create(Nil);
  pCloneDataSet(cdsClone, cdsItens);
  Try
    cdsClone.Filtered := False;
    cdsClone.Filter   := '(IDEPRO <> ' + QuotedStr('NOR') + ')';
    cdsClone.Filtered := True;
    cdsClone.First;
    Result := Not cdsClone.IsEmpty;
  Finally
    FreeAndNil(cdsClone);
  End;
End;

function TfrmFatConfOrcamentosItens.fRetEmpresa: String;
begin
  Result := IIF(fEmptyStr(strCodEmp), VS_strCodEmp, strCodEmp);
end;

function TfrmFatConfOrcamentosItens.fTotalmenteExpedido: Boolean;
begin
  Result := True;

  cdsItens.First;

  While (Not cdsItens.Eof) Do
  Begin

    If (fFormataFloat(cdsItens.FieldByName('QTDITE').AsFloat, fCfgSis('DECQTD', varInteger))  <>
        fFormataFloat(cdsItens.FieldByName('QTDLIB').AsFloat, fCfgSis('DECQTD', varInteger))) Then
    Begin
      Result := False;
      Break;
    End;

    cdsItens.Next;
  End;

  cdsItens.First;
end;

function TfrmFatConfOrcamentosItens.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (Sender = edtCodIte) Then
  Begin
    Result := True;
  End

  Else If (Sender = edtQtdIte) Then
  Begin
    If (fEmptyStr(edtQtdIte.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A quantidade deve ser preenchida!', ['&Ok']);
      Result := False;
    End
    Else If (fFormataFloat(fStrToFloat(edtQtdIte.Text), intDecQtd) <= 0.0) Then
    Begin
      fMensagem('ATENÇÃO!', 'A quantidade deve ser maior que Zero!', ['&Ok']);
      Result := False;
    End
    Else If (Frac(fFormataFloat(fStrToFloat(edtQtdIte.Text), intDecQtd)) <> 0) And Assigned(edtQtdIte.OnKeyPress) Then
    Begin
      {**********************************************************************}
      { CHECAGEM ADICIONAL, CASO O USUÁRIO TENTE DIGITAR UM VALOR FRACIONADO }
      { SEM APAGAR A VÍRGULA DA MÁSCARA                                      }
      {*******************************************************************VA*}
      fMensagem('ATENÇÃO!', 'Não é permitido informar valor fracionado para esse item!', ['&O k']);
      Result := False;
    End
    Else
    Begin
      pSetFocus(edtCodIte);
      edtQtdIte.Enabled := False;
      blnMudarFoco := False;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmFatConfOrcamentosItens.pExpedeItem(blnValidaTrava: Boolean=true);
  Const
    strAutomotivas: String = '_LAZ_SKY_GEN_PPG_ZYN_STA_WAN_WCP_SAL_GLA_DUP_AUT_FAR_GLA_MZA_NEX_BZC_BZA_DOX_STW_AJT_ROB_ALK_COA_LCA_PFA_ALA_BLA_';

  Var
    strMensagem: String;
    blnAchou   : Boolean;
    blnBarExp  : Boolean;
    strValBusAux: String;
    strCamBusAux: String;
    strTxtCap  : String;
    fltQtdBal  : Double;
    intQtdBal  : Integer;
    objIteBar  : TIteBar;
    strCodIteUni,
    strCodGruUni: String;
    fltQtdIteUni: Double;
    strCodIteRet: String;
    strNumLotRet: String;

  procedure pInverteLabelBusca;
  begin
    If (strCamBus='CODBAT') Then
    Begin
      strTxtCap:=CAP_CODBAR_EMB;
      lblCodBar.Caption:=CAP_CODBAR_FOR;
    End
    Else
    Begin
      strTxtCap:=CAP_CODBAR_FOR;
      lblCodBar.Caption:=CAP_CODBAR_EMB;
    End;
  end;

  procedure pArmazenaCondicaoBusca(chrAcao:char);
  begin
    Case chrAcao Of
    'A':Begin
          strValBusAux := strValBus;
          strCamBusAux := strCamBus;
        End;
    'V':Begin
          strValBus := strValBusAux;
          strCamBus := strCamBusAux;
        End;
    End;
  end;

  procedure pIdentificaPreparaExpedicaoTintometrica;
    Var
      blnExpedicaoItemTintometrico,
      blnAchou: Boolean;
  Begin
    If (blnTemItensTintas) And (Length(edtCodIte.Text) > fTamCodIte) Then
    Begin
      blnExpedicaoItemTintometrico := False;
      pArmazenaCondicaoBusca('A'); //ARMAZENA
      strValBus := edtCodIte.Text;
      Try
        strCamBus := 'CODBAR'; //CÓDIGO DE BARRAS EMBALAGEM
        blnAchou  := cdsItens.FindFirst;
        blnExpedicaoItemTintometrico := blnAchou And (cdsItens.FieldByName('IDEPRO').AsString <> 'NOR');
        If (blnExpedicaoItemTintometrico) And (fCfgSis('EXPTIN') = '2') Then
        Begin
          pInverteLabelBusca;
          strCamBusComplementar := 'CODBAT';
          strValBusComplementar := Trim(InputBox('AutCom', strTxtCap, ''));
          strCodIteFor          := strValBusComplementar;
        End;    

        If (Not blnAchou) Then
        Begin
          strCamBus := 'BAREMB'; //CÓDIGO DE BARRAS EMBALAGEM
          blnAchou  := cdsItens.FindFirst;
          blnExpedicaoItemTintometrico := blnAchou And (cdsItens.FieldByName('IDEPRO').AsString <> 'NOR');
          If (blnExpedicaoItemTintometrico) And (fCfgSis('EXPTIN') = '2') Then
          Begin
            pInverteLabelBusca;
            strCamBusComplementar := 'CODBAT';
            strValBusComplementar := Trim(InputBox('AutCom', strTxtCap, ''));
            strCodIteFor          := strValBusComplementar;
          End;    
        End;

        If (Not blnAchou) And (fCfgSis('EXPTIN') = '2') Then
        Begin
          strCamBus := 'CODBAT'; //CÓDIGO DE BARRAS FÓRMULA
          blnAchou  := cdsItens.FindFirst;
          blnExpedicaoItemTintometrico := blnAchou And (cdsItens.FieldByName('IDEPRO').AsString <> 'NOR');
          If (blnExpedicaoItemTintometrico) Then
          Begin
            If (Pos(cdsItens.FieldByName('IDEPRO').AsString, strAutomotivas) <= 0) Then
            Begin
              pInverteLabelBusca;
              strCamBusComplementar := 'CODBAR;BAREMB';
              strValBusComplementar := Trim(InputBox('AutCom', strTxtCap, ''));
              strCodIteFor          := strValBusComplementar;
            End;
          End;    
        End;
      Finally
        If (Not blnExpedicaoItemTintometrico) Then
          pArmazenaCondicaoBusca('A'); //VOLTA
      End;
    End;
  End;

begin
  blnMudarFoco := False;
  strValBusComplementar := '';
  strCamBusComplementar := '';
  strCodIteFor := '';
  strNumLot := '';

  If (Length(edtCodIte.Text) > fTamCodIte) And (Not fBarrasBalanca(edtCodIte.Text, strBarBal)) Then
  Begin
    strCamBus := 'BAREMB';
    If (fCfgSis('ETIDIF', varBoolean)) Then
    Begin
      try
        objIteBar := TIteBar.Create;
        If objIteBar.fLerCodigoBarrasUnidades(edtCodIte.Text, strCodIteUni, strCodGruUni, fltQtdIteUni) Then
        Begin
          edtCodIte.Text := strCodIteUni;
          edtQtdIte.Text := floatToStr(fltQtdIteUni);
          strCamBus := 'CODITE';
        End;
      finally
        freeAndNil(objIteBar);
      end;
    End;
  End
  Else
  Begin
    If Not fEmptyStr(edtCodIte.Text) Then
    Begin
      strCamBus := 'CODITE';

      If fBarrasBalanca(edtCodIte.Text, strBarBal) Then
      Begin
        intQtdBal := StrToIntDef(Copy(edtCodIte.Text, 8, 5),0);
        edtQtdIte.Text := FormatFloat(edtQtdIte.EditFormat, intQtdBal);
        edtCodIte.Text := Copy(edtCodIte.Text, 3, 5);

        If fCfgSis('DVQBAL') = 'S' Then
        Begin
          fltQtdBal := intQtdBal / 1000;
          edtQtdIte.Text := FormatFloat(edtQtdIte.EditFormat, fltQtdBal);
        End;
      End
      Else
        edtCodIte.Text := fStrZero(edtCodIte.Text, fTamCodIte);

      blnBarExp := (fCampoTabela('ITE_BAREXP', 'CADITE', ['ITE_CODITE'], [edtCodIte.Text]) = 'S') and fCfgSis('BAREXP', varBoolean);

      If blnValidaTrava And blnBarExp Then
      Begin
        edtCodIte.Clear;
        pMensagemSonora('Para expedir este produto é necessário informar o código de barras.');
        Exit;
      End;
    End;
  End;

  If Not fEmptyStr(edtCodIte.Text) Then
  Begin
    strMensagem := '';

    If (cdsItens.RecordCount > 0) And
       (fValidarLotePeloCodigoBarrasDoLote(strCodIteRet, strNumLotRet, edtCodIte.Text)) Then
    Begin
      edtCodIte.Text := strCodIteRet;
      strNumLot := strNumLotRet;
      strCamBus := 'CODITE';
    End;

    strValBus := edtCodIte.Text;
    cdsItens.IndexFieldNames := 'AUTOINCREM';

    cdsItens.DisableControls;

    pIdentificaPreparaExpedicaoTintometrica;

    blnAchou := fEncontraItem(strMensagem);

    If (Not blnAchou) And (Length(edtCodIte.Text) > fTamCodIte) Then
    Begin
      strCamBus := 'CODBAR';
      blnAchou := fEncontraItem(strMensagem);
    End;

    cdsItens.EnableControls;

    If (Not blnAchou) Then
    Begin
      pMensagemSonora('', CHECKOUT_SEM_SUCESSO);
      If (Length(edtCodIte.Text) <= fTamCodIte) Or (strCamBus = 'CODITE') Then
      Begin
        If fCampoTabela('COUNT(*)', 'CADITE', ['ITE_CODITE'], [edtCodIte.Text]) > 0 Then
          strMensagem := 'Produto (' + edtCodIte.Text + iif(fEmptyStr(strCodIteFor),'',' - '+strCodIteFor) + ') não encontrado no pedido!'  
        Else
          strMensagem := 'Produto (' + edtCodIte.Text + iif(fEmptyStr(strCodIteFor),'',' - '+strCodIteFor) + ') não cadastrado no sistema!';
      End
      Else  
      Begin
        if untIteBar.fCodigoDeBarrasExiste(edtCodIte.Text) then
          strMensagem := 'Código de Barras (' + edtCodIte.Text + iif(fEmptyStr(strCodIteFor),'',' - '+strCodIteFor) + ') não encontrado no pedido!'
        else
          strMensagem := 'Código de Barras (' + edtCodIte.Text + iif(fEmptyStr(strCodIteFor),'',' - '+strCodIteFor) + ') não cadastrado no sistema!';
      End  
    End
    Else
      pMensagemSonora('', CHECKOUT_COM_SUCESSO);

    If (Not fEmptyStr(strMensagem)) Then
    Begin
      fMensagem('', strMensagem, ['&OK']);
    End;

    edtCodIte.Clear;
    lblCodBar.Caption:=CAP_CODBAR_EMB;
  End
  Else
  Begin
    If Not fEmptyStr(edtCodIte.Text) Then
      blnMudarFoco := False
    Else
      blnMudarFoco := True;
  End;
end;

procedure TfrmFatConfOrcamentosItens.dbgItensDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;

  {**********************************}
  { CONFIGURACAO DE COR P/ SELECAO   }
  {*******************************IV*}
  If (Not cdsItens.Active) Or (cdsItens.IsEmpty) Then
  Begin
    Exit;
  End;

  {**********************************}
  { CONFIGURACAO DE COR P/ EXPEDICAO }
  {*******************************JB*}
  If (fCfgSis('ITECFO', varBoolean) And fCfgSis('DESCHK', varBoolean) And (cdsItens.FieldByName('DESCHK').AsString = 'S')) And
     (fFormataFloat(cdsItens.FieldByName('QTDITE').AsFloat, fCfgSis('DECQTD', varInteger)) = fFormataFloat(cdsItens.FieldByName('QTDLIB').AsFloat, fCfgSis('DECQTD', varInteger))) Then
  Begin
    dbgItens.Canvas.Brush.Color := clGray;
  End
  Else
  If (fFormataFloat(cdsItens.FieldByName('QTDITE').AsFloat, fCfgSis('DECQTD', varInteger)) = fFormataFloat(cdsItens.FieldByName('QTDLIB').AsFloat, fCfgSis('DECQTD', varInteger))) Then
  Begin
    dbgItens.Canvas.Brush.Color := $0096CFA7;
  End
  Else
  Begin
    If (fFormataFloat(cdsItens.FieldByName('QTDITE').AsFloat, fCfgSis('DECQTD', varInteger)) > fFormataFloat(cdsItens.FieldByName('QTDLIB').AsFloat, fCfgSis('DECQTD', varInteger))) And
       (fFormataFloat(cdsItens.FieldByName('QTDLIB').AsFloat, fCfgSis('DECQTD', varInteger)) <> 0) Then
      dbgItens.Canvas.Brush.Color := $00CCFFFF;
  End;

  dbgItens.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmFatConfOrcamentosItens.dbgItensKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Shift = [ssShift]) Then
  Begin
    Case Key Of
      VK_F5: pLimpaItemExpedidoSelecionado;
    End;
  End;
end;

procedure TfrmFatConfOrcamentosItens.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  If (blnFecharESC) Then
  Begin
    If fMensagem('ATENÇÃO!', 'Deseja realmente sair?', ['&Sim', '&Não']) = 2 Then
    Begin
      blnFecharESC := False;
      Action := CaNone;
      Exit;
    End;
  End;

  inherited;

end;

procedure TfrmFatConfOrcamentosItens.FormCreate(Sender: TObject);
begin
  inherited;
  strCodEmp := '';
  blnRcxF11 := True;
  blnRetBal := False;
  blnDocImportadoPedOrc := False;
  strBarBal := fCfgSis('DIGBAL');
  blnRetiraDigSeparador := False;
  strCodCon := '' ;
  strObsExp := '';
  objLiberacao := TLiberacao.Create;

  fFindColumnByName(dbgItens, 'QTDITE').Visible := fCfgSis('QTEXCF', varBoolean);

  // Diminui a coluna de descrição do item para caber a coluna de quantidade
  If fFindColumnByName(dbgItens, 'QTDITE').Visible Then
    fFindColumnByName(dbgItens, 'DESITE').Width := fFindColumnByName(dbgItens, 'DESITE').Width - fFindColumnByName(dbgItens, 'QTDITE').Width;

  blnFecharESC := False;
  blnLimExp := False;
  strNumLot := EmptyStr;

  intDecQtd := fCfgSis('DECQTD', varInteger);

  blnNaoConfereItensTransfReq := False;

  If fCfgSis('TIPBAR', varString) = '2' Then
   edtCodIte.MaxLength := 43;

end;

procedure TfrmFatConfOrcamentosItens.FormDestroy(Sender: TObject);
begin
  If assigned(objLiberacao) then
    FreeAndNil(objLiberacao);

  inherited;
end;

procedure TfrmFatConfOrcamentosItens.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_RETURN : If ((ActiveControl) = edtCodIte) Then pExpedeItem;
    VK_ESCAPE : btnSair.Click;
    VK_F6     : btnQuantidade.Click;
    VK_F7     : btnExpAut.Click;
    VK_F8     : btnMarcarTudo.Click;
    VK_F10    : Begin
                  Key := 0;
                  btnConfirma.Click;
                End;
  End;
  
end;

procedure TfrmFatConfOrcamentosItens.btnExpAutClick(Sender: TObject);
begin
  inherited;
  If (Not fVerificaAcessoSistema('EXPRAT', strLoginUsuarioLogado)) Then
  Begin
    fMensagem('ATENÇÃO!', 'Esse usuário não tem direitos para executar essa operação!', ['&Ok']);
    Exit;
  End;

  btnExpAut.Enabled := False;

  pMarcarTodosProdutos;

  btnConfirma.Click;

  btnExpAut.Enabled := True;
end;

procedure TfrmFatConfOrcamentosItens.btnMarcarTudoClick(Sender: TObject);
begin
  inherited;
  If Not fVerificaAcessoSistema('EXPRTD', strLoginUsuarioLogado) Then
  Begin
    fMensagem('ATENÇÃO!', 'Esse usuário não tem direitos para executar essa operação!', ['&Ok']);
    Exit;
  End;

  pMarcarTodosProdutos(True);
end;

procedure TfrmFatConfOrcamentosItens.btnQuantidadeClick(Sender: TObject);
begin
  inherited;

  If (Not btnQuantidade.Enabled) Then
    Exit;

  edtQtdIte.Enabled := True;
  pSetFocus(edtQtdIte);
end;

procedure TfrmFatConfOrcamentosItens.btnSairClick(Sender: TObject);
begin
  blnFecharESC := True;
  inherited;
end;

procedure TfrmFatConfOrcamentosItens.pGravaItensPedido;
var qryUpdate: TUniQuery;
    blnLibSpr: Boolean;
begin
  Try
    blnLibSpr := True;
    qryUpdate := fCriaQuery(Self);

    With cdsItens do
    Begin
      First;
      While not eof do
      Begin
        With qryUpdate Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add('UPDATE EXTDOR SET FDO_QTDRET = :QTDLIB');
          SQL.Add('WHERE FDO_SEQFDO = :SEQFDO');
          ParamByName('QTDLIB').AsFloat  := cdsItens.FieldByName('QTDLIB').AsFloat;
          ParamByName('SEQFDO').AsString := cdsItens.FieldByName('AUTOINCREM').AsString;
          ExecSQL;
        End;

        If blnLibSpr then
          blnLibSpr := (cdsItens.FieldByName('QTDLIB').AsFloat >= cdsItens.FieldByName('QTDITE').AsFloat);

        Next;
      End;
    End;

    If blnLibSpr Then
    Begin
      With qryUpdate Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(' UPDATE  ');
        SQL.Add('   EXTGOR, ');
        SQL.Add('   FATGOR  ');
        SQL.Add(' SET EXTGOR.FGO_LIBSPR = "S"');
        SQL.Add(' WHERE EXTGOR.FGO_SEQFGO = FATGOR.AUTOINCREM ');
        SQL.Add('   AND FATGOR.FGO_NUMDOC = :NUMDOC');
        SQL.Add('   AND FATGOR.FGO_ESPDOC = :ESPDOC');
        SQL.Add('   AND FATGOR.FGO_CODEMP = :CODEMP');
        ParamByName('NUMDOC').AsString := strNumDoc;
        ParamByName('ESPDOC').AsString := strEspDoc;
        ParamByName('CODEMP').AsString := fRetEmpresa;
        ExecSQL;
      End;
    End;

  Finally
    FreeAndNil(qryUpdate);
  End;
end;

procedure TfrmFatConfOrcamentosItens.pLimpaItemExpedidoSelecionado;
var
  blnTemAcessoMarcarTudo: Boolean;
  strOperador: string;
begin
  If (Not cdsItens.Active) Then
    Exit;

  If (cdsItens.IsEmpty) Then
    Exit;

  If (cdsItens.RecNo <= 0) Then
    Exit;

  blnTemAcessoMarcarTudo := fVerificaAcessoSistema('EXPMTD', strLoginUsuarioLogado);

  If (blnTemAcessoMarcarTudo) Or (ffrmSenha(strOperador)) Then
  Begin
    If (blnTemAcessoMarcarTudo) Or (fVerificaAcessoSistema('LIMEXP', fRetCodVendedor(strOperador))) Then
    Begin
      cdsItens.Edit;
      cdsItens.FieldByName('QTDEXP').AsFloat := 0;
      cdsItens.FieldByName('QTDLIB').AsFloat := 0;
      cdsItens.Post;

      blnLimExp := True;
    End
    Else
    Begin
      fMensagem('', 'Operador informado não possui direitos de acesso para ' + #13#10 +
                    'limpar a quantidade expedida do produto!', ['&Ok']);
    End;
  End
  Else
  Begin
    fMensagem('', 'Operador informado não possui direitos de acesso para ' + #13#10 +
                  'limpar a quantidade expedida do produto!', ['&Ok']);
  End;
end;

procedure TfrmFatConfOrcamentosItens.pCarregaItensPedido;
  Var
    cdsClone: TUniClientDataSet;
begin

  With qryItens Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT                                                   ');
    SQL.Add('  FDO_EMPITE AS EMPITE,                                  ');
    SQL.Add('  CONCAT(FDO_CODITE, "-", FDO_DESCRI) AS DESITE,         ');
    SQL.Add('  FDO_CODITE AS CODITE,                                  ');
    SQL.Add('  SUM(FDO_QTDITE - FDO_QTDBAI) AS QTDITE,                ');
    SQL.Add('  IFNULL((SELECT SUM(PRE_QTDITE) FROM PREPTE P           ');
    SQL.Add('          INNER JOIN FDOABS A ON P.AUTOINCREM = A.ABS_SEQPTE     ');
    SQL.Add('          WHERE A.ABS_SEQFDO = FATDOR.AUTOINCREM), 0) AS QTDTRA, ');
    SQL.Add('  IFNULL((SELECT SUM(PRQ_QTDITE) FROM PREPRQ P           ');
    SQL.Add('          INNER JOIN FDOABS A ON P.AUTOINCREM = A.ABS_SEQPRQ     ');
    SQL.Add('          WHERE A.ABS_SEQFDO = FATDOR.AUTOINCREM), 0) AS QTDREQ, ');
    SQL.Add('  SUM(IFNULL(FDO_QTDEXP,0)) AS QTDEXP,                   ');
    SQL.Add('  UNI_SIGUNI AS UNIDAD,                                  ');

    If Not blnRcxF11 Then
      SQL.Add('  FDO_QTDRET AS QTDLIB,                                ')
    Else
    Begin
      SQL.Add('  (CASE                                               ');
      SQL.Add('     WHEN (FDO_ENTRET = "R") AND                      ');
      SQL.Add('          (FDO_LOCRET = "C") AND                      ');
      SQL.Add('          (FDO_ENTFUT = "N") THEN                     ');
      SQL.Add('        FDO_QTDRET                                    ');
      SQL.Add('   ELSE                                               ');
      SQL.Add('     0.0000                                           ');
      SQL.Add('   END)  AS QTDLIB,                                   ');
    End;

    SQL.Add('  IF(FDO_CODITE IN (:ITESER,:SERTER), "S", "N") AS ITESER,               ');
    SQL.Add('  IF(FDO_IDEPRO =  "" OR FDO_IDEPRO IS NULL, " ", FDO_IDEPRO) AS IDEPRO, ');
    SQL.Add('  FDO_ENTRET AS ENTRET,                                  ');
    SQL.Add('  FDO_LOCRET AS LOCRET,                                  ');
    SQL.Add('  G.ITE_SALDOS AS SALEST,                                ');
    SQL.Add('  FATDOR.AUTOINCREM AS AUTOINCREM,                       ');
    SQL.Add('  FATGOR.AUTOINCREM AS GORINCREM,                        ');

    If (fCfgSis('EXPTIN',varString) = '1') Then
      SQL.Add('  IF(FDO_CODACA IS NOT NULL AND FDO_CODACA <> "", ACA_CODBAR, I.ITE_CODBAR) AS CODBAR, ')
    Else
    Begin
      SQL.Add('  I.ITE_CODBAR AS CODBAR,                                                            ');
      SQL.Add('  ACA_CODBAR   AS CODBAT,                                                            ');
    End;

    SQL.Add('  I.ITE_CODUNI AS CODUNI,                                          ');
    SQL.Add('  "B" AS TIPBUS,                                         ');

    SQL.Add('  (SELECT GROUP_CONCAT(CONCAT("-", BAR_CODBAR, "-")) FROM');
    SQL.Add('   ITEBAR WHERE I.ITE_CODITE = BAR_CODITE) AS BAREMB,    ');

    SQL.Add('  I.ITE_EMBALA AS EMBALA,                                ');
    SQL.Add('  FDO_DESCRI   AS DESCRI, ');
    SQL.Add('  FDO_NUMLOT   AS NUMLOT, ');
    SQL.Add('  FDO_ENTFUT   AS ENTFUT, ');
    SQL.Add('  I.ITE_BAREXP AS BAREXP, ');
    SQL.Add('  G.ITE_DESCHK AS DESCHK  ');
    SQL.Add('FROM                                                     ');
    SQL.Add('  FATDOR                                                 ');
    SQL.Add('  JOIN FATGOR ON FATGOR.AUTOINCREM = FATDOR.FDO_SEQGER   ');
    SQL.Add('  JOIN CADITE I ON I.ITE_CODITE = FDO_CODITE             ');
    SQL.Add('  JOIN ITEGER G ON I.ITE_CODITE = G.ITE_CODITE AND       ');
    SQL.Add('                   G.ITE_CODEMP = FDO_CODEMP             ');
    SQL.Add('  JOIN CADUNI ON UNI_CODUNI   = I.ITE_CODUNI             ');
    SQL.Add('  LEFT JOIN CADACA ON ACA_CODACA = FDO_CODACA AND        ');
    SQL.Add('                      ACA_CODEMP = FDO_EMPACA            ');
    SQL.Add('  LEFT JOIN EXTDOR ON EXTDOR.FDO_SEQFDO = FATDOR.AUTOINCREM ');
    SQL.Add('WHERE                                                    ');
    If blnRetBal Then
    Begin
      SQL.Add(' FALSE ');
    End
    Else
    Begin
      SQL.Add('  FDO_QTDITE > FDO_QTDBAI AND                            ');
      SQL.Add('  IFNULL(FDO_ITEEMB,"N") <> "S" AND                      ');
      SQL.Add('  FDO_NUMDOC = :NUMDOC AND                               ');
      SQL.Add('  FDO_ESPDOC = :ESPDOC AND                               ');
      SQL.Add('  FDO_CODEMP = :CODEMP                                   ');

      SQL.Add('GROUP BY ');
      SQL.Add('  FDO_IDEPRO, FDO_CODITE, FDO_DESCRI, FDO_NUMLOT, FDO_ENTRET, FDO_LOCRET, FDO_ENTFUT, FDO_EMPITE ');

      ParamByName('ITESER').AsString := fCfgSis('ITESER');
      ParamByName('SERTER').AsString := fCfgSis('SERTER');
      ParamByName('NUMDOC').AsString := strNumDoc;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODEMP').AsString := fRetEmpresa;
    End;
  End;

  qryItens.Open;
  pSetaClient(qryItens);
  cdsItens.Open;

  If blnRetBal Then
  Begin
    cdsItens.LogChanges := False;
    cdsItens.EmptyDataSet;

    cdsClone := TUniClientDataSet.Create(Self);
    Try
      pCloneDataSet(cdsClone, cdsVenda);

      cdsClone.Filtered := False;
      cdsClone.Filter   := 'ITE_LOCRET=''B'' OR ITE_LOCRET=''B2''';
      cdsClone.Filtered := True;

      While Not cdsClone.Eof Do
      Begin
        cdsItens.Insert;

        cdsItens.FieldByName('EMPITE').AsString     := IfEmptyStr(cdsClone.FieldByName('ITE_EMPITE').AsString, VS_strCodEmp);
        cdsItens.FieldByName('DESITE').AsString     := cdsClone.FieldByName('ITE_DESITE').AsString;
        cdsItens.FieldByName('CODITE').AsString     := cdsClone.FieldByName('ITE_CODITE').AsString;
        cdsItens.FieldByName('QTDITE').AsFloat      := cdsClone.FieldByName('ITE_QTDITE').AsFloat;
        cdsItens.FieldByName('QTDEXP').AsFloat      := cdsClone.FieldByName('ITE_QTDEXP').AsFloat;
        cdsItens.FieldByName('QTDLIB').AsFloat      := cdsClone.FieldByName('ITE_QTDEXP').AsFloat;
        cdsItens.FieldByName('UNIDAD').AsString     := cdsClone.FieldByName('ITE_UNIDAD').AsString;
        cdsItens.FieldByName('ITESER').AsString     := IIF(Pos(cdsClone.FieldByName('ITE_CODITE').AsString, fCfgSis('ITESER')+'_'+fCfgSis('SERTER')+'_') > 0, 'S', 'N');
        cdsItens.FieldByName('IDEPRO').AsString     := cdsClone.FieldByName('ITE_IDEPRO').AsString;
        cdsItens.FieldByName('ENTRET').AsString     := cdsClone.FieldByName('ITE_ENTRET').AsString;
        cdsItens.FieldByName('LOCRET').AsString     := cdsClone.FieldByName('ITE_LOCRET').AsString;
        cdsItens.FieldByName('SALEST').AsFloat      := cdsClone.FieldByName('ITE_SALDOS').AsFloat;
        cdsItens.FieldByName('AUTOINCREM').AsString := cdsClone.FieldByName('AUTOINCREM').AsString;
        cdsItens.FieldByName('GORINCREM').AsString  := '';
        If (fCfgSis('EXPTIN',varString) = '1') Then
          cdsItens.FieldByName('CODBAR').AsString   := cdsClone.FieldByName('ITE_CODBAR').AsString
        Else
        Begin
          cdsItens.FieldByName('CODBAR').AsString   := cdsClone.FieldByName('ITE_CODBAR').AsString;
          If (Not fEmptyStr(cdsClone.FieldByName('ITE_CODACA').AsString)) Then
            cdsItens.FieldByName('CODBAT').AsString := fCampoTabela('ACA_CODBAR', 'CADACA', ['ACA_CODACA','ACA_CODEMP'], [cdsClone.FieldByName('ITE_CODACA').AsString,cdsClone.FieldByName('ITE_EMPACA').AsString])
        End;
        cdsItens.FieldByName('CODUNI').AsString     := cdsClone.FieldByName('ITE_CODUNI').AsString;
        cdsItens.FieldByName('TIPBUS').AsString     := 'B';
        cdsItens.FieldByName('BAREMB').AsString     := fCampoTabela('GROUP_CONCAT(CONCAT("-", BAR_CODBAR, "-"))', 'ITEBAR', ['BAR_CODITE'], [cdsClone.FieldByName('ITE_CODITE').AsString]);
        cdsItens.FieldByName('EMBALA').AsFloat      := cdsClone.FieldByName('ITE_EMBALA').AsFloat;
        cdsItens.FieldByName('DESCRI').AsString     := cdsClone.FieldByName('ITE_DESITE').AsString;
        cdsItens.FieldByName('NUMLOT').AsString     := cdsClone.FieldByName('ITE_NUMLOT').AsString;
        cdsItens.FieldByName('ENTFUT').AsString     := cdsClone.FieldByName('ITE_ENTFUT').AsString;
        cdsItens.FieldByName('BAREXP').AsString     := fCampoTabela('ITE_BAREXP', 'CADITE', ['ITE_CODITE'], [cdsClone.FieldByName('ITE_CODITE').AsString]);
        cdsItens.FieldByName('DESCHK').AsString     := fCampoTabela('ITE_DESCHK', 'ITEGER', ['ITE_CODITE','ITE_CODEMP'], [cdsClone.FieldByName('ITE_CODITE').AsString,IfEmptyStr(cdsClone.FieldByName('ITE_EMPITE').AsString, VS_strCodEmp)]);

        cdsItens.Post;

        cdsClone.Next;
      End;
    Finally
      FreeAndNil(cdsClone);
    End;
  End;

  pValidaTransfRequisicao;

  If (Not blnRetBal) And fUsaRotinaExpedicaoConferenciaRetiraCaixa() Then
  Begin
    cdsItens.First;
    While Not cdsItens.Eof Do
    Begin
      If fFormataFloat(cdsItens.FieldByName('QTDEXP').AsFloat, intDecQtd) > 0 Then
      Begin
        cdsItens.Edit;
        cdsItens.FieldByName('QTDLIB').Value := cdsItens.FieldByName('QTDEXP').AsFloat;
        cdsItens.Post;
      End;
      cdsItens.Next;
    End;
    cdsItens.First;
  End;

  blnTemItensTintas := fTemItensTintas;
  strValBusComplementar := '';
  strCamBusComplementar := '';
  
  If fCfgSis('AUTCEN', varBoolean) And fCfgSis('USAEXS', varBoolean) Then
  Begin
    If cdsItens.Locate('ITESER', 'S', []) Then
    Begin
      cdsItens.First;
      While Not cdsItens.Eof Do
      Begin
        cdsItens.Edit;
        cdsItens.FieldByName('QTDLIB').Value := cdsItens.FieldByName('QTDITE').Value;
        cdsItens.Post;
        cdsItens.Next;
      End;
      blnConferido  := True;
      blnFecharForm := True;
      Exit;
    End;
  End;

  If fCfgSis('ITECFO', varBoolean) And fCfgSis('DESCHK', varBoolean) Then
  Begin
    cdsItens.First;
    While Not cdsItens.Eof Do
    Begin
      If cdsItens.FieldByName('DESCHK').AsString = 'S' Then
      Begin
        cdsItens.Edit;
        cdsItens.FieldByName('QTDLIB').Value := cdsItens.FieldByName('QTDITE').Value;
        cdsItens.Post;
      End;

      cdsItens.Next;
    End;
    cdsItens.First;
  End;

  cdsItens.OnFilterRecord := pOnFilter;

  blnFecharForm := cdsItens.IsEmpty and (not blnNaoConfereItensTransfReq);

  If (blnFecharForm) Then
    fMensagem('ATENÇÃO!', 'Não há itens neste documento!', ['&Ok'])
  Else
  Begin
    strCamBus := 'ENTRET';
    strTipBus := '=';
    strValBus := 'E';

    While cdsItens.FindFirst Do cdsItens.Delete;

    If fCfgSis('LOCRET', VarBoolean) Then
    Begin
      strCamBus := 'LOCRET';
      strTipBus := '=';
      strValBus := 'E';

      While cdsItens.FindFirst Do cdsItens.Delete;

      If (not blnRetBal) And (not fCfgSis('NOTDES', varBoolean)) Then
      Begin
        strCamBus := 'LOCRET';
        strTipBus := '=';
        strValBus := 'B';

        While cdsItens.FindFirst Do cdsItens.Delete;

        strCamBus := 'LOCRET';
        strTipBus := '=';
        strValBus := 'B2';

        While cdsItens.FindFirst Do cdsItens.Delete;
      End;
    End;

    strCamBus := 'ITESER';
    strTipBus := '=';
    strValBus := 'S';

    While cdsItens.FindFirst Do cdsItens.Delete;

    {*********************************************}
    {* DEVE CONFERIR SOMENTE OS PRODUTOS DA LOJA *}
    {******************************************JC*}
    If fCfgSis('EMPFAT', VarBoolean) Then {And fCfgSis('EMPFVN', VarBoolean) Then Req.: 120422}
    Begin
      strCamBus := 'EMPITE';
      strTipBus := '<>';
      strValBus := VS_strCodEmp;

      While cdsItens.FindFirst Do cdsItens.Delete;

      strTipBus := '=';
    End;

    If cdsItens.IsEmpty Then
    Begin
      blnConferido  := True;
      blnFecharForm := True;
    End;

  End;

  If (Not blnRetBal) And fUsaRotinaExpedicaoConferenciaRetiraCaixa And fTotalmenteExpedido Then
  Begin
    blnConferido  := True;
    blnFecharForm := True;
  End;

end;

procedure TfrmFatConfOrcamentosItens.FormShow(Sender: TObject);
begin
  inherited;
  blnFecharForm := False;
  blnConferido  := False;
  blnTemItensTintas := False;
  edtQtdIte.EditFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
  edtQtdIte.Text       := FormatFloat(edtQtdIte.EditFormat, 1);

  pCarregaItensPedido;
  If blnRetBal Then
    Caption := 'Conferência de Produtos: - Retira Balcão'
  Else
    Caption := Caption + strNumDoc + '-' + strEspDoc;

  If Not fTotalmenteExpedido Then
    pSetFocus(edtCodIte);

  If (Self.strEspDoc = 'PD') And
     (fCfgSis('F11FPD', varBoolean)) And
     (fTotalmenteExpedido) Then
  Begin
    blnConferido  := True;
    blnFecharForm := True;
  End;
end;

procedure TfrmFatConfOrcamentosItens.FormPaint(Sender: TObject);
begin
  inherited;
  If (blnFecharForm) Then
    Close;
end;

function TfrmFatConfOrcamentosItens.fTravaLIBITEF11():Boolean;
begin
  Result := fVerificaAcessoSistema('LIBITEF11', strCodOpe);

  If (Not Result) And (Not fEmptyStr(fCfgSis('SENCFO'))) Then
  Begin
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('Quantidade divergente F11 Resumo de Caixa');

    objLiberacao.strDirAce := 'LIBITEF11';
    objLiberacao.strSenLib := fCfgSis('SENCFO');
    objLiberacao.strMsgSen := 'Senha Liberação';
    objLiberacao.blnMosMen := True;
    objLiberacao.strCodOpe := strCodOpe;
    objLiberacao.strCodDig := strCodOpe;

    Result := objLiberacao.fLibera;
  End
  Else
    Result := True;
end;

function TfrmFatConfOrcamentosItens.fTravaVALCBE():Boolean;
begin
  Result := fVerificaAcessoSistema('VALCBE', strCodOpe);

  If (Not Result) Then
  Begin
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('Liberar conferência no F11 do Resumo de Caixa com código de barras obrigatório');

    objLiberacao.strDirAce := 'VALCBE';
    objLiberacao.strMsgSen := 'Senha Liberação';
    objLiberacao.blnMosMen := True;
    objLiberacao.strCodOpe := strCodOpe;
    objLiberacao.strCodDig := strCodOpe;

    Result := objLiberacao.fLibera;
  End;
end;

procedure TfrmFatConfOrcamentosItens.btnConfirmaClick(Sender: TObject);
  Var
    blnConfirma: Boolean;
    blnBarExp: Boolean;
begin
  inherited;

  Try

    Self.Enabled := False;

    blnConfirma := fTotalmenteExpedido;

    cdsItens.First;

    If blnRetBal Then
    Begin
      If (not blnConfirma) Then
        fMensagem('ATENÇÃO!', 'A conferência do documento não está completa!', ['&Ok']);
    End
    Else If fCfgSis('VALCBE', varBoolean) Then
    Begin
      If (Not blnConfirma) Then
      Begin
        blnConfirma := fTravaLIBITEF11();

        If blnConfirma Then
        Begin
          blnBarExp := (cdsItens.FieldByName('BAREXP').asString = 'S') and fCfgSis('BAREXP', varBoolean);

          If blnBarExp Then
            blnConfirma := fTravaVALCBE();
        End;

      End;
    End
    Else
    Begin
      If (Not blnConfirma) Then
      Begin
        blnConfirma := (fMensagem('ATENÇÃO!', 'O documento não está completo!' + #13#10 +
                                              'Deseja continuar?', ['&Sim', '&Não']) = 1);

        If blnConfirma And (blnRcxF11 Or blnDocImportadoPedOrc) Then
          blnConfirma := fTravaLIBITEF11();
      End;
    End;

    Self.Enabled := True;

  Except
    On E: Exception Do
    Begin
      Self.Enabled := True;
      blnConfirma := False;
      pMensagensErro(E.Message, '[TfrmFatConfOrcamentosItens.btnConfirmaClick]');
    End;
  End;

  If (blnConfirma) And (Not fTotalmenteExpedido) Then
  Begin
    blnConfirma := fValidaPermissaoParaConferenciaParcialDoItem(blnConfirma);

    If (fCfgSis('FOEXIT') = 'S') And (blnConfirma) Then
      pMarcarTodosProdutos;
  End;

  If (blnConfirma) And (fCfgSis('RESECO') = 'S') and (blnRetiraDigSeparador) Then
  Begin
    If (Not fSolicitaConferenteSeparador(strCodCon, strCodSep, strObsExp)) Then
      blnConfirma := False
  End;

  If (Not blnConfirma) Then
  Begin
    pSetFocus(edtCodIte);
  End
  Else
  Begin
    Try

      fStartTransaction;
      If (not blnRcxF11) and (not blnRetBal) Then
      Begin
        pGravaItensPedido;
        pGravaExpRet(cdsItens.FieldByName('GORINCREM').AsString, strCodSep, dtaSepIni, horSepIni, Date, fTime() );
      End;

      If (fCfgSis('RESECO') = 'S') and (blnRetiraDigSeparador) Then
        pAtualizaSepOpeExpPedido(strCodCon, strCodSep, strObsExp);

      If (fCfgSis('TIPEXP', varString) = '3') And (blnRetiraDigSeparador) Then
        pAtualizaTipBus;

      fCommit;

      Close;
      blnConferido := True;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        blnConferido := False;
        pMensagensErro(E.Message, '[TfrmFatConfOrcamentosItens.btnConfirmaClick]');
      End;
    End;
  End;

end;

procedure TfrmFatConfOrcamentosItens.pOnFilter(DataSet: TDataSet; var Accept: Boolean);

  function fAtendeBuscaComplementar: Boolean;
  begin
    Result := True;

    If (Not fEmptyStr(strCamBusComplementar) And Not fEmptyStr(strCamBusComplementar)) Then
    Begin
      If SameText(strCamBusComplementar, 'CODBAR;BAREMB') Then
      begin
        Result := (Pos('-' + strValBusComplementar + '-', DataSet.FieldByName('BAREMB').AsString) > 0) Or
                  ((DataSet.FieldByName('CODBAR').AsString = strValBusComplementar))
      end
      Else If SameText(strCamBusComplementar, 'BAREMB') Then
      begin
        Result := (Pos('-' + strValBusComplementar + '-', DataSet.FieldByName(strCamBusComplementar).AsString) > 0)
      end
      Else
      begin
        Result := (DataSet.FieldByName(strCamBusComplementar).AsString = strValBusComplementar)
      end;
    End;
  end;

begin
  If SameText(strCamBus, 'BAREMB') Then
    Accept := Pos('-' + strValBus + '-', DataSet.FieldByName(strCamBus).AsString) > 0
  Else If strTipBus = '<>' Then
    Accept := (DataSet.FieldByName(strCamBus).AsString <> strValBus)
  Else
    Accept := (DataSet.FieldByName(strCamBus).AsString = strValBus);

  Accept := Accept And fAtendeBuscaComplementar;
end;

procedure TfrmFatConfOrcamentosItens.pValidaTransfRequisicao;
var
  fltTotal: Double;
begin
  if (not blnRcxF11) then
    Exit;

  cdsItens.First;

  while not cdsItens.Eof do
  Begin
    fltTotal := cdsItens.FieldByName('QTDITE').AsFloat - cdsItens.FieldByName('QTDTRA').AsFloat - cdsItens.FieldByName('QTDREQ').AsFloat;

    if (fltTotal > 0) then
    begin
      cdsItens.Edit;
      cdsItens.FieldByName('QTDITE').Value := fltTotal;
      cdsItens.Post;

      cdsItens.Next;
    end
    else
    begin
      blnNaoConfereItensTransfReq := True;
      cdsItens.Delete;
    end;
  end;

  cdsItens.First;
end;

function TfrmFatConfOrcamentosItens.fEncontraItem(Var strMensagem: String): Boolean;
var
  fltQtdIte,
  fltEmbala:Double;
  strAux   : String;
  fltTmpQtd : Double;
begin
  Result := False;

  Try
    objIteBar := TIteBar.Create(opcFuncoes);

    strAux := edtCodIte.Text + iif(fEmptyStr(strCodIteFor),'',' - '+strCodIteFor);

    cdsItens.First;
    If (cdsItens.FindFirst) Then
    Begin

      Result := True;

      Repeat
        If SameText(strCamBus, 'BAREMB') Then
          fltEmbala := objIteBar.fQuantidadeEmbalagem(cdsItens.FieldByName('CODITE').AsString, strValBus)
        Else
          fltEmbala := 1;

        fltQtdIte := fFormataFloat(cdsItens.FieldByName('QTDLIB').AsFloat + fltEmbala * fStrToFloat(edtQtdIte.Text), fCfgSis('DECQTD', VarInteger));

        If (fEmptyStr(strNumLot)) Or (cdsItens.FieldByName('NUMLOT').AsString = strNumLot) Then
        Begin
          If (fFormataFloat(cdsItens.FieldByName('QTDITE').AsFloat, intDecQtd) >= fFormataFloat(fltQtdIte, intDecQtd)) Then
          Begin
            If (Frac(fFormataFloat(fStrToFloat(edtQtdIte.Text), intDecQtd)) <> 0) And
               fItemNaoFracionavel('VN', cdsItens.FieldByName('CODUNI').AsString) Then
            Begin
              {**********************************************************************}
              { CHECAGEM ADICIONAL, CASO O USUÁRIO TENTE DIGITAR UM VALOR FRACIONADO }
              { SEM APAGAR A VÍRGULA DA MÁSCARA                                      }
              {*******************************************************************VA*}
              strMensagem := 'Não é permitido informar valor fracionado para esse item!';
              Break;
            End
            Else
            Begin
              cdsItens.Edit;
              cdsItens.FieldByName('QTDLIB').AsFloat := cdsItens.FieldByName('QTDLIB').AsFloat +
                                                        fltEmbala * fStrToFloat(edtQtdIte.Text);

              If (strCamBus = 'CODITE') Then
                cdsItens.FieldByName('TIPBUS').AsString := 'C';

              cdsItens.Post;

              If Assigned(objCodBar) Then
                objCodBar.pAddCodBar(strValBus, cdsItens.FieldByName('CODITE').AsString, fltEmbala * fStrToFloat(edtQtdIte.Text));

              edtQtdIte.Text := FormatFloat(edtQtdIte.EditFormat, 1);
              strMensagem := '';
              Break;
            End;
          End
          Else
          Begin
            if (strCamBus = 'BAREMB') then
              fltTmpQtd := cdsItens.FieldByName('EMBALA').AsFloat
            else
              fltTmpQtd := fStrToFloat(edtQtdIte.Text);

            If (fFormataFloat(fltTmpQtd, intDecQtd) > 1.0) Then
              strMensagem := 'Quantidade não permitida para o produto (' + strAux + ').'
            Else
            Begin
              If (fFormataFloat(cdsItens.FieldByName('QTDLIB').AsFloat, intDecQtd) < fFormataFloat(cdsItens.FieldByName('QTDITE').AsFloat, intDecQtd)) And
                 (fFormataFloat(fStrToFloat(edtQtdIte.Text), intDecQtd) > fFormataFloat(cdsItens.FieldByName('QTDITE').AsFloat, intDecQtd)) Then
                strMensagem := 'Quantidade não permitida para o produto (' + strAux + ').'
              Else
              Begin
                If (fFormataFloat(cdsItens.FieldByName('QTDLIB').AsFloat, intDecQtd) = fFormataFloat(cdsItens.FieldByName('QTDITE').AsFloat, intDecQtd)) Then
                  strMensagem := 'Produto (' + strAux + ') já foi totalmente confirmado!'
                Else
                  strMensagem := 'Quantidade não permitida para o produto (' + strAux + ').'
              End;
            End;
          End;
        End
        Else
          strMensagem := fMensagemValidacaoPeloCodigoBarrasDoLote(edtCodIte.Text, strNumLot, cdsItens);

      Until (Not cdsItens.FindNext);

    End;
  Finally
    FreeAndNil(objIteBar);
  End;
end;

procedure TfrmFatConfOrcamentosItens.pMarcarTodosProdutos(blnValidaTrava: Boolean = False);
 Var
   fltQtdIte: Double;
   cdsLista : TUniClientDataSet;
begin

  Try
    cdsLista := TUniClientDataSet.Create(Self);
    cdsLista.Data := cdsItens.Data;

    If blnRetBal Then
    Begin
      cdsLista.IndexFieldNames := '';
      cdsLista.IndexDefs.Clear;
      With cdsLista.IndexDefs.AddIndexDef Do
      Begin
        Name       := 'IDX_ORDEM';
        Fields     := 'CODITE;QTDITE';
        DescFields := 'QTDITE';
      End;
      cdsLista.IndexName := 'IDX_ORDEM';
    End;

    With cdsLista Do
    Begin
      First;
      While Not Eof Do
      Begin

        fltQtdIte := FieldByName('QTDITE').AsFloat;

        If fFormataFloat(FieldByName('QTDLIB').AsFloat, intDecQtd) < fFormataFloat(fltQtdIte, intDecQtd) Then
        Begin
          edtCodIte.Text := FieldByName('CODITE').AsString;
          edtQtdIte.Text := FloatToStrF(fltQtdIte - FieldByName('QTDLIB').AsFloat, ffFixed, 12, fCfgSis('DECQTD', varInteger));
          pExpedeItem(blnValidaTrava);
        End;

        Next;
      End;
    End;
  Finally
    FreeAndNil(cdsLista);
  End;

end;

procedure TfrmFatConfOrcamentosItens.pAtualizaSepOpeExpPedido(strCodCon, strCodSep, strObsExp: String);
  var
    qryAux: TUniQuery;
begin

  qryAux := fCriaQuery(Nil);
  Try
    qryAux.Close;
    qryAux.SQL.Text := ' UPDATE FATGOR INNER JOIN EXTGOR ON EXTGOR.FGO_SEQFGO = FATGOR.AUTOINCREM ' +
                       '    SET FGO_SEPEXP = :SEPEXP ' +
    IIF(strCodCon.IsEmpty,'',',FGO_OPEEXP = :OPEEXP  ')+
    IIF(strObsExp.IsEmpty,'',',FGO_OBSEXP = :OBSEXP  ')+
                       '  WHERE FATGOR.FGO_NUMDOC = :NUMDOC'+
                       '    AND FATGOR.FGO_ESPDOC = :ESPDOC'+
                       '    AND FATGOR.FGO_CODEMP = :CODEMP';

    qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
    qryAux.ParamByName('CODEMP').AsString := fRetEmpresa;

    qryAux.ParamByName('SEPEXP').AsString := strCodSep;

    If (Not strCodCon.IsEmpty) Then
      qryAux.ParamByName('OPEEXP').AsString := strCodCon;

    If (Not strObsExp.IsEmpty) Then
      qryAux.ParamByName('OBSEXP').AsString := strObsExp;

    qryAux.ExecSQL;
    qryAux.Close;
  Finally
    FreeAndNil(qryAux);
  End;
end;

procedure TfrmFatConfOrcamentosItens.pAtualizaTipBus;
Var
  qryAux   : TUniQuery;
  cdsClone : TUniClientDataSet;
begin
  cdsClone := TUniClientDataSet.Create(Nil);
  qryAux := fCriaQuery;
  Try
    pCloneDataSet(cdsClone, cdsItens);

    qryAux.SQL.Add(' UPDATE FATDOR ');
    qryAux.SQL.Add('    SET FDO_TIPBUS = :TIPBUS ');
    qryAux.SQL.Add('  WHERE AUTOINCREM = :AUTINC ');

    cdsClone.First;
    While Not cdsClone.Eof Do
    Begin
      qryAux.Close;
      qryAux.ParamByName('AUTINC').AsString := cdsClone.FieldByName('AUTOINCREM').AsString;
      qryAux.ParamByName('TIPBUS').AsString := cdsClone.FieldByName('TIPBUS').AsString;
      qryAux.ExecSQL;

      cdsClone.Next;
    End;
  Finally
    FreeAndNil(qryAux);
    FreeAndNil(cdsClone);
  End;
end;

function TfrmFatConfOrcamentosItens.fSolicitaConferenteSeparador(Var strCodCon,
  strCodSep, strObsExp :String): Boolean;
  Var
    blnColetor: Boolean;
begin
  blnColetor := False;
  Result := TFatSeparadorConferente.New
    .Coletor(blnColetor)
    .CarregaConferente(False)
    .MostrarObs(False)
    .Solicitar(strCodCon, strCodSep, strObsExp);

end;

function TfrmFatConfOrcamentosItens.fValidaPermissaoParaConferenciaParcialDoItem(const AblnConfirma: Boolean): Boolean;
  Var
    stlItens: TStringList;
    intCont: Integer;
begin
  Result := AblnConfirma;

  Try
    stlItens := fItensParcialmenteConferidos;

    If (stlItens.count > 0) And (Not fVerificaAcessoSistema('QTDITEF11', strLoginUsuarioLogado)) Then
    Begin
      objLiberacao.objMsgRemota.strDirAce := 'QTDITEF11';

      objLiberacao.objMsgLibera.pAddTexto('Operador sem permissão para realizar conferência '+
                                          'parcial de itens no F11 - Resumo de Caixa');

      objLiberacao.objMsgLibera.pAddTexto('Documento: '+strNumDoc+ ' - ' + strEspDoc);
      objLiberacao.objMsgLibera.pAddQuebra;
      objLiberacao.objMsgLibera.pAddTexto('Itens com quantidade divergente:');

      For intCont := 0 To Pred(stlItens.count) Do
        objLiberacao.objMsgLibera.pAddTexto(stlItens[intCont]);

      objLiberacao.strDirAce  := 'QTDITEF11';
      objLiberacao.strSenLib  := fCfgSis('SENLBD');
      objLiberacao.strMsgSen  := 'Realizar conferência parcial de itens no F11 - Resumo de Caixa';
      objLiberacao.strCodOpe  := strLoginUsuarioLogado;
      objLiberacao.pInformaNumDocEspDocCodEmp(strNumDoc, strEspDoc, strCodEmp);

      Result := objLiberacao.fLibera;
    End;
  Finally
    FreeAndNil(stlItens);
  End;
end;

function TfrmFatConfOrcamentosItens.fItensParcialmenteConferidos: TStringList;
begin
  Result := TStringList.Create;
  cdsItens.First;

  While (Not cdsItens.Eof) Do
  Begin
    If (cdsItens.FieldByName('QTDLIB').AsFloat > 0) Then
    Begin
      If (Not (CompareValue(cdsItens.FieldByName('QTDITE').AsFloat,
                            cdsItens.FieldByName('QTDLIB').AsFloat) = EqualsValue)) Then
      Begin
        Result.Add(cdsItens.FieldByName('DESITE').AsString);
      End;
    End;

    cdsItens.Next;
  End;

  cdsItens.First;
end;

End.
