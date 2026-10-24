unit untFatDigTipoEntregaItens;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiConfirma, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, Mask,
  MaskEditFocus, ComboBoxFocus, EditFocus, Math, DateUtils,UniClientDataSet,
  untFuncFat, BitBtnLockedIncrem, frxClass, StrUtils, frxExportCSVTestabilidade,
  untLiberacao, Data.DB, untConstantes;

type
  TfrmFatDigTipoEntregaItens = class(TfrmPaiConfirma)
    pnlMotivo: TPanel;
    lblMotEntFut: TLabel;
    cmbMotEntFut: TComboBoxFocus;
    lblDatEnt: TLabel;
    mskDtaEnt: TMaskEditFocus;
    lblEntRet: TLabel;
    cmbEntRet: TComboBoxFocus;
    lblCliBus: TLabel;
    cmbCliBus: TComboBoxFocus;
    lblTurno: TLabel;
    cmbTurEnt: TComboBoxFocus;
    lblDiaEnt: TLabel;
    edtDiaEnt: TEditFocus;
    pnlTipEnt: TPanel;
    lblTipEnt: TLabel;
    cmbTipEnt: TComboBoxFocus;
    pnlLocRet: TPanel;
    lblLocRet: TLabel;
    cmbLocRet: TComboBoxFocus;
    rdgPegou: TRadioGroup;
    procedure cmbMotEntFutChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure mskDtaEntKeyPress(Sender: TObject; var Key: Char);
    procedure cmbEntRetChange(Sender: TObject);
    procedure cmbTipEntChange(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure edtDiaEntExit(Sender: TObject);
    procedure mskDtaEntExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure mskDtaEntChange(Sender: TObject);
  private
    blnAlteraTodosItensEntregaImediata: Boolean;
    strEmpresaItens: String;
    blnDesVaz, blnClienteBuscaEntrega: Boolean;
    objLiberacao : TLiberacao;
    FstrEspDoc: string;
    FstrNumDoc: string;
    FstrCodEmp: string;
    blnTrocarLoteAConfirmar: Boolean;
    procedure pDefineEmpresaItens;
    function fGetEmpConfigEntrega: String;
    function fAlteraDataEntregaItens: Boolean;
    function fPermitirApenas1Destino: Boolean;
    procedure pHabilitarCamposEntrega;
    procedure pSetaCampoDestino;
    procedure pEnabledDestino(blnEnabled: Boolean);
    function fTipEntPrimeiroItem: Integer;
    function fLocRetPrimeiroItem: Integer;
    function fPermiteRetiraCaixa: Boolean;
    function fAlteraDocumento: Boolean;
    function fTemLoteDefinido: Boolean;
    function fRetFiltroSelecao: String;
    procedure pVerificaSeVaiAlterarTodosItensComoMesmaDataEntregaImediata;
    function fAlteraJaPegou: Boolean;
    function fRetLocalRetira(strLocRet: String): Integer;
    { Private declarations }
  public
    { Public declarations }
    blnAlterou: Boolean;
    fatVenda: TFatVenda;

    intAutIncPosAltEmp: Integer;
    strCodEmpPosAltEmp: String;
    strItensEntregaImediata: string;
    strSelecao: string;
    arrSelecaoAutoIncrem: TArrayString;

    property strNumDoc: string read FstrNumDoc write FstrNumDoc;
    property strEspDoc: string read FstrEspDoc write FstrEspDoc;
    property strCodEmp: string read FstrCodEmp write FstrCodEmp;
  protected

    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmFatDigTipoEntregaItens: TfrmFatDigTipoEntregaItens;


implementation

uses untFuncoesSimples, untConsultas, untControleEntregaRomaneio, untTypesSistema,
  untFuncoes, Uni;

{$R *.dfm}

procedure TfrmFatDigTipoEntregaItens.btnConfirmaClick(Sender: TObject);
begin
  If (Not fVerificaCampos) Then
    Exit;

  blnTrocarLoteAConfirmar := False;  
  if fTemLoteDefinido then
  begin
    blnTrocarLoteAConfirmar := (fMensagem('', 'Há itens selecionados que tem o lote inválido para Entrega Futura.' + #13 +
                                              'Quando se trata desta operação, é obrigatório utilizar o lote "A Definir" (CFG_ENTDEF).' + #13 +
                                              'Deseja prosseguir e atualizar o lote dos itens para o "A Definir"?', ['&SIM', '&NÃO']) = 1);
    if not blnTrocarLoteAConfirmar then
      Exit;
  end;

  if fEmptyStr(FstrNumDoc) then
  begin
    If (Not fAlteraDataEntregaItens) Then
      Exit;

    If (Not fPermiteRetiraCaixa) then
      Exit;

    If (Not fAlteraJaPegou) Then
      Exit;
  end
  else
  begin
    fAlteraDocumento;
  end;

  Inherited;

  Close;
end;

function TfrmFatDigTipoEntregaItens.fAlteraDataEntregaItens: Boolean;
  Var
    strLocRet,
    strFilter: String;
    blnFilter: Boolean;
    oleItens : OleVariant;

  function fItemComoEntregaFuturaNoPedido(strAutIncFdo: String): Boolean;
  begin
    Result := fCampoTabela('FDO_ENTFUT', 'FATDOR', ['AUTOINCREM'], [strAutIncFdo]) = 'S';
  end;

  function fLocalizarRegistro: boolean;
  begin
    result := (Assigned(fatVenda)) and
              (Assigned(fatVenda.cdsVendaBackup)) and
              (fatVenda.cdsVendaBackup.Active) and
              (not fatVenda.cdsVendaBackup.IsEmpty);

    if Result then
    begin
      fatVenda.cdsVendaBackup.First;
      result := fatVenda.cdsVendaBackup.Locate('AUTOINCREM', cdsVenda.FieldByName('AUTOINCREM').AsInteger, []);
    end;
  end;

  procedure pRevertDadosRegistro;
  var
    objFieldBackup: TField;

    function fValidarCampo: Boolean;
    begin
      result := (Assigned(cdsVenda.FindField(objFieldBackup.FieldName))) and
                (cdsVenda.FieldByName(objFieldBackup.FieldName).Value <> objFieldBackup.Value);
    end;

  begin
    if not fLocalizarRegistro then
      exit;

    for objFieldBackup in fatVenda.cdsVendaBackup.Fields do
    begin
      if not fValidarCampo then
        continue;

      if cdsVenda.State <> dsEdit then
        cdsVenda.Edit;

      cdsVenda.FieldByName(objFieldBackup.FieldName).Value := objFieldBackup.Value;
    end;

    if cdsVenda.State = dsEdit then
      cdsVenda.Post;
  end;

begin
  Result    := False;
  blnFilter := False;
  Try
    strFilter := cdsVenda.Filter;
    blnFilter := cdsVenda.Filtered;
    cdsVenda.Filtered := False;
    oleItens  := cdsVenda.Data;

    If Not fEmptyStr(strSelecao) Then
    Begin
      cdsVenda.Filter := fRetFiltroSelecao;
      cdsVenda.Filtered := True;
    End;

    cdsVenda.First;
    While Not cdsVenda.Eof Do
    Begin
      If ((Not fEmptyStr(Self.strEmpresaItens)) And
          (Self.strEmpresaItens <> cdsVenda.FieldByName('ITE_EMPITE').AsString)) Or
         ((intAutIncPosAltEmp <> -1) And (intAutIncPosAltEmp <> cdsVenda.FieldByName('AUTOINCREM').AsInteger)) Then
      Begin
        cdsVenda.Next;
        Continue;
      End
      Else If (cmbTipEnt.ItemIndex = IDX_ENTREGA_FUTURA) Then
      Begin //TIPO DE ENTREGA: 0 - FUTURA  1 - IMEDIATA
        If cmbMotEntFut.ItemIndex < 0 Then
        Begin
          fMensagem('','O motivo da entrega futura deve ser selecionado!', ['&OK']);
          pRevertDadosRegistro;
          cdsVenda.Next;
          Continue;
        End

        Else If (cdsVenda.FieldByName('ITE_BRINDE').AsString = 'S') Then
        Begin
          fMensagem('ATENÇÃO','Item: ' + cdsVenda.FieldByName('ITE_CODITE').AsString + '. Não será alterado para Entrega Futura por ser brinde!',['&O k']);
          pRevertDadosRegistro;
          cdsVenda.Next;
          Continue;
        End

        Else If (cmbMotEntFut.ItemIndex = IDX_MOTIVO_FALTA_PRODUTO) And
                (fCampoTabela('ITE_PEFFPR', 'CADITE', ['ITE_CODITE'], [cdsVenda.FieldByName('ITE_CODITE').AsString]) <> 'S') Then
        Begin
          If fCfgSis('LIBEFU', varInteger) = 2 Then
          Begin
            fMensagem('AVISO','Item: ' + cdsVenda.FieldByName('ITE_CODITE').AsString + '. Este Item não tem permissão para Entrega Futura com ' +#13#10 +
                              'Status "Falta Produto". Ao fechar a venda, será solicitado senha de liberação.', ['&O k']);
          End
          Else
          Begin
            fMensagem('ATENÇÃO','Item: ' + cdsVenda.FieldByName('ITE_CODITE').AsString + '. Este Item não tem permissão para Entrega Futura com ' + #13#10 +
                                'Status "Falta Produto"! [CADASTRO DE PRODUTOS > ABA DADOS DE SAÍDA > CAMPO "Permitir Entrega Futura com Status "Falta de Produto"?"]',['&O k']);
            pRevertDadosRegistro;
            cdsVenda.Next;
            Continue;
          End;
        End
        Else If (cmbMotEntFut.ItemIndex = IDX_MOTIVO_AGUARDANDO_CLIENTE) And
                (fCampoTabela('ITE_PEEFUT', 'CADITE', ['ITE_CODITE'], [cdsVenda.FieldByName('ITE_CODITE').AsString]) <> 'S') Then
        Begin
          If fCfgSis('LIBEFU', varInteger) = 2 Then
          Begin
            fMensagem('AVISO','Item: ' + cdsVenda.FieldByName('ITE_CODITE').AsString + '. Este Item não tem permissão para Entrega Futura com ' +#13#10 +
                              'Status "Aguardando Cliente". Ao fechar a venda, será solicitado senha de liberação.', ['&O k']);
          End
          Else
          Begin
            fMensagem('ATENÇÃO','Item: ' + cdsVenda.FieldByName('ITE_CODITE').AsString + '. Este Item não tem permissão para Entrega Futura com ' + #13#10 +
                                'Status "Aguardando Cliente"! [CADASTRO DE PRODUTOS > ABA DADOS DE SAÍDA > CAMPO "Permitir Entrega Futura com Status "Aguardando Cliente"?"]',['&O k']);
            pRevertDadosRegistro;
            cdsVenda.Next;
            Continue;
          End;
        End
        Else If (cmbMotEntFut.ItemIndex = IDX_MOTIVO_PREVISAO_ENTREGA) And
                (fCampoTabela('ITE_PEFUTP', 'CADITE', ['ITE_CODITE'], [cdsVenda.FieldByName('ITE_CODITE').AsString]) <> 'S') Then
        Begin
          If fCfgSis('LIBEFU', varInteger) = 2 Then
          Begin
            fMensagem('AVISO','Item: ' + cdsVenda.FieldByName('ITE_CODITE').AsString + '. Este Item não tem permissão para Entrega Futura com ' +#13#10 +
                              'Status "Previsão de Entrega". Ao fechar a venda, será solicitado senha de liberação.', ['&O k']);
          End
          Else
          Begin
            fMensagem('ATENÇÃO','Item: ' + cdsVenda.FieldByName('ITE_CODITE').AsString + '. Este Item não tem permissão para Entrega Futura com ' + #13#10 +
                                'Status "Previsão de Entrega"! [CADASTRO DE PRODUTOS > ABA DADOS DE SAÍDA > CAMPO "Permitir Entrega Futura com Status "Previsão de Entrega"?"]',['&O k']);
            pRevertDadosRegistro;
            cdsVenda.Next;
            Continue;
          End;
        End;

        If (cmbMotEntFut.ItemIndex = IDX_MOTIVO_FALTA_PRODUTO) And (Not fCfgSis('PEFUTF', VarBoolean)) Then
        Begin
          If (fatVenda.strIdePro = 'NOR') And
             (cdsVenda.FieldByName('ITE_QTDITE').AsFloat > 0) And
             (fatVenda.fRetornaSaldoDisponivelItemNormal(cdsVenda.FieldByName('ITE_CODEMP').AsString,
                                                         cdsVenda.FieldByName('ITE_CODITE').AsString,
                                                         cdsVenda.FieldByName('ITE_NUMLOT').AsString,
                                                         '',
                                                         cdsVenda.FieldByName('ITE_CODACA').AsString,
                                                         cdsVenda.FieldByName('ITE_EMPACA').AsString,
                                                         cdsVenda.FieldByName('ITE_SALDOS').AsFloat,
                                                         True,
                                                         True) >= cdsVenda.FieldByName('ITE_QTDITE').AsFloat) Then
          Begin
            fMensagem('ATENÇÃO','Item: ' + cdsVenda.FieldByName('ITE_CODITE').AsString + '. Não é permitido Entrega Futura com ' + #13#10 +
                                'Status "Falta de Produto" quando o ' +
                                'produto possuir estoque disponível!',['&O k']);
            pRevertDadosRegistro;
            cdsVenda.Next;
            Continue;
          End;
        End;

        If (cmbMotEntFut.ItemIndex = IDX_MOTIVO_FALTA_PRODUTO) And
           (Not fItemAtivoParaCompras(cdsVenda.FieldByName('ITE_CODITE').AsString)) Then
        Begin
          fMensagem('ATENÇÃO','Item: ' + cdsVenda.FieldByName('ITE_CODITE').AsString + '. Não é permitido Entrega Futura com ' +
                              'Status "Falta de Produto" quando o ' +
                              'produto não estiver ativo para compras!',['&O k']);
          pRevertDadosRegistro;
          cdsVenda.Next;
          Continue;
        End;

      End;

      {Somente Retira}
      If Not fPermiteInserirSomenteItemRetira(cdsVenda.FieldByName('ITE_CODITE').AsString,
                                              IfThen(fEmptyStr(cdsVenda.FieldByName('ITE_EMPITE').AsString), cdsVenda.FieldByName('ITE_CODEMP').AsString, cdsVenda.FieldByName('ITE_EMPITE').AsString),
                                              fatVenda.strOpcDoc,
                                              (cmbEntRet.Text[1] = 'R')) Then
      Begin
        fMensagem('ATENÇÃO!', 'Item: ' + cdsVenda.FieldByName('ITE_CODITE').AsString + '. Só é permitido ser alterado como Retira!', ['&Ok']);
        pRevertDadosRegistro;
        cdsVenda.Next;
        Continue;
      End;

      {Somente Entrega}
      If Not fPermiteInserirSomenteItemEntrega(cdsVenda.FieldByName('ITE_CODITE').AsString,
                                               IfThen(fEmptyStr(cdsVenda.FieldByName('ITE_EMPITE').AsString), cdsVenda.FieldByName('ITE_CODEMP').AsString, cdsVenda.FieldByName('ITE_EMPITE').AsString),
                                               fatVenda.strOpcDoc,
                                               (cmbEntRet.Text[1] = 'E')) Then
      Begin
        fMensagem('ATENÇÃO!', 'Item: ' + cdsVenda.FieldByName('ITE_CODITE').AsString + '. Só é permitido ser alterado como Entrega!', ['&Ok']);
        pRevertDadosRegistro;
        cdsVenda.Next;
        Continue;
      End;

      If (Not fatVenda.fLiberaTravaTipoMovimento(fatVenda.fRetornaTipoMovimento(cmbEntRet.ItemIndex, cmbTipEnt.ItemIndex),
                                                 cdsVenda.FieldByName('ITE_EMPITE').AsString,
                                                 cdsVenda.FieldByName('ITE_CODITE').AsString,
                                                 cdsVenda.FieldByName('ITE_DESITE').AsString,
                                                 cdsVenda.FieldByName('ITE_QTDITE').AsFloat,
                                                 cdsVenda.FieldByName('AUTOINCREM').AsInteger)) Then
      Begin
        pRevertDadosRegistro;
        cdsVenda.Next;
        Continue;
      End;

      cdsVenda.Edit;

      strLocRet := cdsVenda.FieldByName('ITE_LOCRET').AsString;

      cdsVenda.FieldByName('ITE_ENTFUT').AsString := 'N';
      cdsVenda.FieldByName('ITE_CLIBUS').AsString := Copy(cmbCliBus.Text, 1, 1);
      cdsVenda.FieldByName('ITE_TURENT').AsString := fatVenda.objTurno.fTurnoIntToStr(cmbTurEnt.ItemIndex);
      cdsVenda.FieldByName('ITE_MOTFUT').Clear;
      cdsVenda.FieldByName('ITE_DTENTR').Clear;
      cdsVenda.FieldByName('ITE_LOCRET').Clear;

      If cmbEntRet.Text[1] = 'R' Then //Retira
      Begin
        cdsVenda.FieldByName('ITE_ENTRET').AsString := 'R';

        If fCfgSis('LOCRET', VarBoolean) Then
          cdsVenda.FieldByName('ITE_LOCRET').AsString := fRetSiglaLocalRetira(cmbLocRet.Text);

        fatVenda.intIdxPri := IDX_RETIRA;
      End
      Else
      Begin
        cdsVenda.FieldByName('ITE_ENTRET').AsString := 'E';
        fatVenda.intIdxPri := IDX_ENTREGA;

        // Entrega Imediata ou Entrega Futura com Previsao de Entrega
        If (cmbTipEnt.Text[1] = 'I') Or (cmbMotEntFut.ItemIndex In [1,2]) Then
        Begin
          cdsVenda.FieldByName('ITE_DTENTR').AsDateTime := StrToDateDef(mskDtaEnt.Text, VS_Date);
        End
        Else
        Begin
          if StrToDateDef(mskDtaEnt.Text, 0) > 0 then
            cdsVenda.FieldByName('ITE_DTENTR').AsDateTime := StrToDateDef(mskDtaEnt.Text, VS_Date)
          else
            cdsVenda.FieldByName('ITE_DTENTR').AsDateTime := VS_DATE + fCampoTabela( 'ITE_DIAFOR',
                                                                            'CADITE',
                                                                           ['ITE_CODITE'],
                                                                           [cdsVenda.FieldByName('ITE_CODITE').AsString] );
        End;

        //Entrega Futura
        If (cmbTipEnt.Text[1] = 'F') Then
        Begin
          cdsVenda.FieldByName('ITE_ENTFUT').AsString := 'S';
          cdsVenda.FieldByName('ITE_MOTFUT').AsString := cmbMotEntFut.Text[1];
          if (blnTrocarLoteAConfirmar) and (not fEmptyStr(cdsVenda.FieldByName('ITE_NUMLOT').AsString)) and (cdsVenda.FieldByName('ITE_NUMLOT').AsString <> 'A DEFINIR') then
            cdsVenda.FieldByName('ITE_NUMLOT').AsString := 'A DEFINIR';
        End;

      End;

      {********************************************************}
      {* ITENS DE ENTREGA FUTURA O SISTEMA JA GRAVA EXPEDIDO, *}
      {* PORTANTO CASO ALTERE PARA NAO ENTREGA FUTURA DEVEMOS *}
      {* ZERAR A QUANTIDADE EXPEDIDA DO PRODUTO...            *}
      {****************************************************JC**}
      If (cdsVenda.FieldByName('ITE_QTDEXP').AsFloat > 0) And (Not fEmptyStr(fatVenda.strNumOrc)) And
         (cdsVenda.FieldByName('ITE_ENTFUT').AsString <> 'S') And
         (fItemComoEntregaFuturaNoPedido(cdsVenda.FieldByName('ITE_SEQDET').AsString))  Then
      Begin
        cdsVenda.FieldByName('ITE_QTDEXP').AsFloat := 0;
      End;

      {Req: 159574}
      If (fUsaRotinaExpedicaoConferenciaRetiraCaixa) And
         (cdsVenda.FieldByName('ITE_ENTRET').AsString <> 'R') And
         (cdsVenda.FieldByName('ITE_PEGOU_').AsString = 'S') Then
      Begin
        If (fatVenda.fEhEmissaoDocumentoWMS Or fatVenda.fEmpresaParaFaturamentoUsaWMS(cdsVenda.FieldByName('ITE_EMPITE').AsString)) Then
          cdsVenda.FieldByName('ITE_NUMLOT').AsString := 'A DEFINIR';
        cdsVenda.FieldByName('ITE_PEGOU_').AsString := 'N';
      End;

      cdsVenda.FieldByName('ITE_EMPCAR').AsString :=
        fatVenda.fRetEmpCarregamento(cdsVenda.FieldByName('ITE_CODITE').AsString, (cdsVenda.FieldByName('ITE_ENTRET').AsString = 'E'));

      If (strLocRet = 'B') And (strLocRet <> cdsVenda.FieldByName('ITE_LOCRET').AsString) Then
      Begin
        cdsVenda.FieldByName('ITE_QTDEXP').AsFloat := 0;
        cdsVenda.FieldByName('ITE_QTDRET').AsFloat := 0;
      End;

      cdsVenda.Post;
      cdsVenda.Next;
    End;
    cdsVenda.First;
    Result := fatVenda.fVerificaEstoqueItens(fatVenda.strOpcDoc);
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[fAlteraDataEntregaItens]');
    End;
  End;

  If Not Result Then
    cdsVenda.Data := oleItens;

  cdsVenda.Filter   := strFilter;
  cdsVenda.Filtered := blnFilter;
  fatVenda.pFormataDecimaisGrid;

  blnAlterou := Result;

end;

function TfrmFatDigTipoEntregaItens.fAlteraDocumento: Boolean;
var
  iIndice: Integer;
  qryUpdate: TUniQuery;
  blnLocRet: Boolean;
  strLocRet,
  strCodIte: String;
  FATGOR_ENTFUT, FATGOR_MOTFUT: Variant;
  EXTDOR_CLIBUS, EXTDOR_TURENT, EXTDOR_DTENTR, EXTDOR_LOCRET, EXTDOR_ENTRET: Variant;
begin
  qryUpdate := fCriaQuery;
  try
    For iIndice := Low(ArrSelecaoAutoIncrem) To High(ArrSelecaoAutoIncrem) Do
    Begin
      FATGOR_ENTFUT := 'N';
      FATGOR_MOTFUT := Null;
      EXTDOR_CLIBUS := Copy(cmbCliBus.Text, 1, 1);
      EXTDOR_TURENT := fatVenda.objTurno.fTurnoIntToStr(cmbTurEnt.ItemIndex);
      EXTDOR_DTENTR := Null;
      EXTDOR_LOCRET := Null;

      If cmbEntRet.Text[1] = 'R' Then //Retira
      Begin
        EXTDOR_ENTRET := 'R';

        If fCfgSis('LOCRET', VarBoolean) Then
          EXTDOR_LOCRET := fRetSiglaLocalRetira(cmbLocRet.Text);
      End
      Else
      Begin
        EXTDOR_ENTRET := 'E';

        // Entrega Imediata ou Entrega Futura com Previsao de Entrega
        If (cmbTipEnt.Text[1] = 'I') Or (cmbMotEntFut.ItemIndex In [1,2]) Then
          EXTDOR_DTENTR := StrToDateDef(mskDtaEnt.Text, VS_Date)
        Else
        Begin
          if StrToDateDef(mskDtaEnt.Text, 0) > 0 then
            EXTDOR_DTENTR := StrToDateDef(mskDtaEnt.Text, VS_Date)
          else
          begin
            strCodIte := fCampoTabela('FDO_CODITE', 'FATDOR', ['AUTOINCREM'], [ArrSelecaoAutoIncrem[iIndice]]);
            EXTDOR_DTENTR := VS_DATE + fCampoTabela( 'FDO_DIAFOR',
                                                     'CADITE',
                                                     ['FDO_CODITE'],
                                                     [strCodIte] );
          end;
        End;

        //Entrega Futura
        If (cmbTipEnt.Text[1] = 'F') Then
        Begin
          FATGOR_ENTFUT := 'S';
          FATGOR_MOTFUT := cmbMotEntFut.Text[1];
        End;
      End;

      qryUpdate.SQL.Clear;
      qryUpdate.SQL.ADD('UPDATE FATDOR SET ');
      qryUpdate.SQL.ADD('  FDO_ENTFUT = :ENTFUT,');
      qryUpdate.SQL.ADD('  FDO_MOTFUT = :MOTFUT');
      if blnTrocarLoteAConfirmar then
        qryUpdate.SQL.Add(',  FDO_NUMLOT = IF(IFNULL(FDO_NUMLOT, "") <> "", "A DEFINIR", NULL) ');
      qryUpdate.SQL.ADD('WHERE AUTOINCREM = :AUTOIN');
      qryUpdate.ParamByName('ENTFUT').Value := FATGOR_ENTFUT;
      qryUpdate.ParamByName('MOTFUT').Value := FATGOR_MOTFUT;
      qryUpdate.ParamByName('AUTOIN').Value := ArrSelecaoAutoIncrem[iIndice];
      qryUpdate.ExecSQL;

      strLocRet := fCampoTabela('FDO_LOCRET', 'EXTDOR', ['FDO_SEQFDO'], [ArrSelecaoAutoIncrem[iIndice]]);
      blnLocRet := (strLocRet = 'B') And (strLocRet <> EXTDOR_LOCRET);

      qryUpdate.SQL.Clear;
      qryUpdate.SQL.ADD('UPDATE EXTDOR SET ');
      qryUpdate.SQL.ADD('  FDO_CLIBUS = :CLIBUS,');
      qryUpdate.SQL.ADD('  FDO_TURENT = :TURENT,');
      qryUpdate.SQL.ADD('  FDO_DTENTR = :DTENTR,');
      qryUpdate.SQL.ADD('  FDO_LOCRET = :LOCRET,');
      If blnLocRet Then
      Begin
        qryUpdate.SQL.ADD('FDO_QTDEXP = 0,');
        qryUpdate.SQL.ADD('FDO_QTDRET = 0,');
      End;
      qryUpdate.SQL.ADD('  FDO_ENTRET = :ENTRET');
      qryUpdate.SQL.ADD('WHERE FDO_SEQFDO = :SEQFDO');
      qryUpdate.ParamByName('CLIBUS').Value := EXTDOR_CLIBUS;
      qryUpdate.ParamByName('TURENT').Value := EXTDOR_TURENT;
      qryUpdate.ParamByName('DTENTR').Value := EXTDOR_DTENTR;
      qryUpdate.ParamByName('LOCRET').Value := EXTDOR_LOCRET;
      qryUpdate.ParamByName('ENTRET').Value := EXTDOR_ENTRET;
      qryUpdate.ParamByName('SEQFDO').Value := ArrSelecaoAutoIncrem[iIndice];
      qryUpdate.ExecSQL;

    end;

    qryUpdate.SQL.Clear;
    qryUpdate.SQL.ADD('UPDATE FATGOR SET ');
    qryUpdate.SQL.ADD('  FGO_DTENTR = :DTENTR');
    qryUpdate.SQL.ADD('WHERE FGO_NUMDOC = :NUMDOC');
    qryUpdate.SQL.ADD('  AND FGO_ESPDOC = :ESPDOC');
    qryUpdate.SQL.ADD('  AND FGO_CODEMP = :CODEMP');
    qryUpdate.ParamByName('DTENTR').Value := EXTDOR_DTENTR;
    qryUpdate.ParamByName('NUMDOC').Value := FstrNumDoc;
    qryUpdate.ParamByName('ESPDOC').Value := FstrEspDoc;
    qryUpdate.ParamByName('CODEMP').Value := FstrCodEmp;
    qryUpdate.ExecSQL;

  finally
    FreeAndNil(qryUpdate);
  end;
  Result := True;
  blnAlterou := Result;
end;

function TfrmFatDigTipoEntregaItens.fAlteraJaPegou: Boolean;
var
  strSel: string;
  strFilter: string;
  blnFilter: Boolean;
  oleItens : OleVariant;
begin
  Result := True;
  If rdgPegou.Visible Then
  Begin
    If rdgPegou.ItemIndex = 0 Then
      Exit;

    strFilter := cdsVenda.Filter;
    blnFilter := cdsVenda.Filtered;
    cdsVenda.Filtered  := False;
    oleItens  := cdsVenda.Data;

    If Not fEmptyStr(strSelecao) Then
    Begin
      strSel := 'ITE_ORDITE in ('+strSelecao;
      strSel := strSel + ')';
      cdsVenda.Filter := strSel;
      cdsVenda.Filtered := True;
    End;

    Try
      cdsVenda.First;
      While Not cdsVenda.Eof Do
      Begin
        cdsVenda.Edit;

        If (rdgPegou.ItemIndex = 1) And (cdsVenda.FieldByName('ITE_ENTRET').AsString = 'R') Then
        Begin
          cdsVenda.FieldByName('ITE_PEGOU_').AsString := 'S';
        End
        Else If (rdgPegou.ItemIndex = 2) Then
        Begin
          cdsVenda.FieldByName('ITE_PEGOU_').AsString := 'N';
        End;

        cdsVenda.Post;
        cdsVenda.Next;
      End;

    Except
      Result := False;
    End;

    If Not Result Then
      cdsVenda.Data := oleItens;

    cdsVenda.Filter   := strFilter;
    cdsVenda.Filtered := blnFilter;

    cdsVenda.First;
  End;

  blnAlterou := Result;
end;

procedure TfrmFatDigTipoEntregaItens.cmbEntRetChange(Sender: TObject);
var
  strCfgEmpEnt: String;
begin
  inherited;
  Case cmbEntRet.ItemIndex Of
    //Entrega
    IDX_ENTREGA: Begin

                   strCfgEmpEnt := fGetEmpConfigEntrega;

                   cmbTipEnt.Enabled := (cmbEntRet.Enabled) Or
                                        ((cmbEntRet.Visible) And (cmbTipEnt.Visible) And (Not fCfgSis('ENTFAT',varBoolean,strCfgEmpEnt)) And fCfgSis('SUJROM',varBoolean,strCfgEmpEnt) And fCfgSis('ENTFUT',varBoolean,strCfgEmpEnt));

                   If cmbTipEnt.Enabled Then
                   Begin
                     If (fatVenda.fRetornaSGFTED('', strCfgEmpEnt) = 'S') Then
                       cmbTipEnt.ItemIndex := IDX_ENTREGA_FUTURA  //TIPO DE ENTREGA: 0 - FUTURA  1 - IMEDIATA
                     Else
                       cmbTipEnt.ItemIndex := IDX_ENTREGA_IMEDIATA; //TIPO DE ENTREGA: 0 - FUTURA  1 - IMEDIATA
                   End;

                   pnlTipEnt.Visible := fCfgSis('ENTFUT', varBoolean, fGetEmpConfigEntrega);
                   pnlLocRet.Visible := False;
                 End;

    //Retira
    IDX_RETIRA: Begin
                  cmbTipEnt.Enabled := False;
                  cmbTipEnt.ItemIndex := IDX_ENTREGA_IMEDIATA; //TIPO DE ENTREGA: 0 - FUTURA  1 - IMEDIATA
                  pnlTipEnt.Visible := fCfgSis('ENTFUT', varBoolean, fGetEmpConfigEntrega);
                  pnlLocRet.Visible := False;

                  If fCfgSis('LOCRET', VarBoolean) Then
                  Begin
                    pnlTipEnt.Visible := False;
                    pnlLocRet.Visible := True;
                    cmbLocRet.Enabled := fCfgSis('ALOCRE', VarBoolean);
                  End;
                End;
  End;

  fatVenda.objTurno.pMostraTurno(fatVenda.objTurno.fExibeTurno(fatVenda.strOpcDoc, cmbEntRet.ItemIndex),
                                 lblTurno, cmbTurEnt, True);
  cmbTipEntChange(nil);

  pVerificaSeVaiAlterarTodosItensComoMesmaDataEntregaImediata;
end;

procedure TfrmFatDigTipoEntregaItens.cmbMotEntFutChange(Sender: TObject);
begin
  inherited;

  mskDtaEnt.Enabled := cmbMotEntFut.ItemIndex In [IDX_MOTIVO_FALTA_PRODUTO, IDX_MOTIVO_PREVISAO_ENTREGA];
  edtDiaEnt.Enabled := mskDtaEnt.Enabled;
  edtDiaEnt.Clear;

  Case cmbMotEntFut.ItemIndex Of
    0: mskDtaEnt.Clear;

    1: mskDtaEnt.Text := '31/12/9999';

    2: If Assigned(fatVenda.objConEnt) Then
       Begin
         edtDiaEnt.Text := '0';

         If fatVenda.dtaDtEntr < VS_DATE Then
           mskDtaEnt.Text := DateToStr(VS_DATE)
         Else
           mskDtaEnt.Text := DateToStr(fatVenda.dtaDtEntr);

       End

       Else mskDtaEnt.Text := DateToStr(VS_DATE);
  End;

end;

procedure TfrmFatDigTipoEntregaItens.cmbTipEntChange(Sender: TObject);
begin
  inherited;

  If cmbTipEnt.ItemIndex = IDX_ENTREGA_FUTURA Then //TIPO DE ENTREGA: 0 - FUTURA  1 - IMEDIATA
  Begin
    cmbMotEntFut.Enabled   := True;
    cmbMotEntFut.ItemIndex := IDX_MOTIVO_AGUARDANDO_CLIENTE;
    cmbMotEntFutChange(Sender);

    cmbCliBus.Enabled := blnClienteBuscaEntrega;
  End
  Else
  Begin
    cmbMotEntFut.Enabled := False;
    cmbMotEntFut.ItemIndex := -1;

    If (cmbEntRet.ItemIndex = IDX_RETIRA) Or (fCfgSis('REGCID', varBoolean)) Then //Caso for Retira Ou Usa Configuração da Rota
    Begin
      mskDtaEnt.Enabled := False;
      mskDtaEnt.Text    := '';
      edtDiaEnt.Enabled := False;
      edtDiaEnt.Text    := '';
    End
    Else
    Begin
      mskDtaEnt.Enabled := True;
      edtDiaEnt.Enabled := True;
      edtDiaEnt.Text := fCfgSis('QMDPEI', varInteger, fGetEmpConfigEntrega);

      If fEmptyStr(edtDiaEnt.Text) Then
        edtDiaEnt.Text := '0';

      If Not (Assigned(fatVenda.objConEnt) And (Not fatVenda.fTemEntregaFutura('P'))) Then
        mskDtaEnt.Text := DateToStr(VS_DATE + StrToInt(edtDiaEnt.Text))
      Else
        mskDtaEnt.Text := DateToStr(fatVenda.objConEnt.fProximaDataDisponivel);
    End;

    cmbCliBus.Enabled := False;
    cmbCliBus.ItemIndex := 0;
  End;

  pVerificaSeVaiAlterarTodosItensComoMesmaDataEntregaImediata;
end;

procedure TfrmFatDigTipoEntregaItens.edtDiaEntExit(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtDiaEnt.Text) Then
    edtDiaEnt.Text := '0';

  Case cmbTipEnt.ItemIndex Of
    IDX_ENTREGA_IMEDIATA,
    IDX_ENTREGA_FUTURA :
      mskDtaEnt.Text := DateToStr(VS_DATE + StrToInt(edtDiaEnt.Text));
  End;
end;

procedure TfrmFatDigTipoEntregaItens.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if assigned(objLiberacao) then
    freeandnil(objLiberacao);
end;

procedure TfrmFatDigTipoEntregaItens.FormCreate(Sender: TObject);
begin
  inherited;
  FstrNumDoc := '';
  FstrEspDoc := '';
  FstrCodEmp := '';
  blnAlteraTodosItensEntregaImediata := False;
  objLiberacao := TLiberacao.Create;
end;

procedure TfrmFatDigTipoEntregaItens.FormShow(Sender: TObject);
begin
  inherited;
  blnAlterou := False;
  pDefineEmpresaItens;
  pHabilitarCamposEntrega;
  pCarregaLocalRetira(cmbLocRet.Items);
  pSetaCampoDestino;
  cmbEntRetChange(nil);
  SelectFirst;
  edtDiaEnt.Text := '0';
  rdgPegou.Visible := (Pos(fatVenda.strOpcDoc, 'PD_OR_VN_') > 0) And (fCfgSis('PEGPED', varBoolean));
end;

function TfrmFatDigTipoEntregaItens.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
Begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = cmbTipEnt) And (cmbTipEnt.ItemIndex = 0) Then
    Begin
      If (Not (fCfgSis('PEFCON', varBoolean, fGetEmpConfigEntrega))) And (fClienteConsumidor(fRetNomCliente(fatVenda.strCodCli))) Then
      Begin
        fMensagem('ATENÇÃO!', 'Não é permitido Entrega Futura para Cliente Consumidor!', ['&OK']);
        Result := False;
      End;
    End
    Else If (Sender = cmbEntRet) Then
    Begin
      If (cmbEntRet.Visible) And (cmbEntRet.Enabled) And (cmbEntRet.ItemIndex = IDX_VAZIO) Then
      Begin
         fMensagem('ATENÇÃO!', 'O Campo Destino deve ser informado!', ['&O k']);
         Result := False;
      End;
    End
    Else If (Sender = cmbLocRet) And pnlLocRet.Visible Then
    Begin
      If (cmbLocRet.Visible) And (cmbLocRet.Enabled) And (cmbLocRet.ItemIndex = IDX_VAZIO) Then
      Begin
         fMensagem('ATENÇÃO!', 'O Campo Local Retira deve ser informado!', ['&O k']);
         Result := False;
      End;
    End
    Else If (Sender = cmbTipEnt) And (cmbEntRet.ItemIndex = IDX_ENTREGA) And (cmbTipEnt.ItemIndex = IDX_ENTREGA_IMEDIATA) Then
    Begin
      If (Not (fCfgSis('PEICON', varBoolean, fGetEmpConfigEntrega))) And (fClienteConsumidor(fRetNomCliente(fatVenda.strCodCli))) Then
      Begin
        fMensagem('ATENÇÃO!', 'Não é permitido Entrega Imediata para Cliente Consumidor!', ['&OK']);
        Result := False;
      End;
    End
    Else If (Sender = edtDiaEnt) And
            (edtDiaEnt.Enabled)  And
            (edtDiaEnt.Visible)  And
            (Pos(fatVenda.strOpcDoc,'VN_PD_OR_') > 0) Then
    Begin
      If fEmptyStr(edtDiaEnt.Text) Then
        edtDiaEnt.Text := '0';

      If StrToInt(edtDiaEnt.Text) < 0 Then
      Begin
        fMensagem('','O dia de entrega deve ser igual ou maior que zero!', ['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = mskDtaEnt) And
            (mskDtaEnt.Enabled) And
            (mskDtaEnt.Visible) And
            (Pos(fatVenda.strOpcDoc,'VN_PD_OR_') > 0) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaEnt.Text)) Then
      Begin
        fMensagem('','A data de entrega deve ser preenchida!', ['&OK']);
        Result := False;
      End
      Else If strToDateDef(mskDtaEnt.Text, 0) = 0 Then
      Begin
        fMensagem('ATENÇÃO!', mskDtaEnt.Text + ' não é uma data válida!', ['&Ok']);
        Result := False;
      End
      //QUANDO FOR ENTREGA FUTURA
      Else If (cmbTipEnt.ItemIndex = 0) Then //TIPO DE ENTREGA: 0 - FUTURA  1 - IMEDIATA
      Begin
        Case cmbMotEntFut.ItemIndex Of
          0,1: Begin
                 If StrToDate(mskDtaEnt.Text) < VS_DATE Then
                 Begin
                   fMensagem('','A data deve ser maior ou igual a ' + DateToStr(VS_DATE) + '!', ['&OK']);
                   Result := False;
                 End;
               End;

          2: Begin

               If (StrToDate(mskDtaEnt.Text) < fatVenda.dtaGraPed) Then
               Begin
                 fMensagem('','A data deve ser maior ou igual a data do pedido (' +
                           DateToStr(fatVenda.dtaGraPed) + ') !', ['&OK']);
                 Result := False;
               End

               Else If (Not fatVenda.blnLibMaxDiaFutPrev) And
                       (DaysBetween(StrToDate(mskDtaEnt.Text), VS_Date) > fCfgSis('DIMXFP', varInteger, fGetEmpConfigEntrega)) Then
               Begin
                 objLiberacao.Clear;
                 objLiberacao.objMsgLibera.pAddTexto('A data de entrega não deve exceder mais que ' +
                                                      fCfgSis('DIMXFP', VarString, fGetEmpConfigEntrega) + ' dias da data atual!');

                 objLiberacao.strDirAce := 'DIMXFP';
                 objLiberacao.strMsgSen := 'Máximo de dias para Entrega Futura - Previsão de Entrega.';
                 objLiberacao.strCodOpe := fatVenda.strCodVen;
                 objLiberacao.strCodDig := fatVenda.strCodDig;
                 objLiberacao.strCliente := fatVenda.strCodCli + '-' + fatVenda.strCliOri;
                 objLiberacao.strCpfCnpj := fatVenda.strCliCgc;


                 Result := fatVenda.fFatMensagemLiberacao(objLiberacao);
                 If Result Then
                  fatVenda.blnLibMaxDiaFutPrev := True;
               End
               Else If (Not fatVenda.blnLibMinDiaFutPrev) And
                       (DaysBetween(VS_Date, StrToDate(mskDtaEnt.Text)) < fCfgSis('DIAPRE', varInteger, fGetEmpConfigEntrega)) Then
               Begin
                 objLiberacao.Clear;
                 objLiberacao.objMsgLibera.pAddTexto('A data de entrega deve ser maior que ' +
                                                      fCfgSis('DIAPRE', VarString, fGetEmpConfigEntrega) + ' dias contando a data atual!');
                 objLiberacao.objMsgLibera.pAddTexto(' ');
                 objLiberacao.strDirAce := 'DIAPRE';
                 objLiberacao.strMsgSen := 'Mínimo de dias para Entrega Futura - Previsão de Entrega.';
                 objLiberacao.strCodOpe := fatVenda.strCodVen;
                 objLiberacao.strCodDig := fatVenda.strCodDig;
                 objLiberacao.strCliente := fatVenda.strCodCli + '-' + fatVenda.strCliOri;
                 objLiberacao.strCpfCnpj := fatVenda.strCliCgc;


                 Result := fatVenda.fFatMensagemLiberacao(objLiberacao);
                 If Result Then
                  fatVenda.blnLibMinDiaFutPrev := True;
               End

               Else If Assigned(fatVenda.objConEnt) Then
               Begin
                 If (Not fatVenda.objConEnt.fDataExisteNaMatriz(StrToDateDef(mskDtaEnt.Text, 0), fatVenda.objConEnt.arrDtaOri)) Then
                 Begin
                   If (Not fatVenda.objConEnt.fDataDisponivel(StrToDateDef(mskDtaEnt.Text, 0))) Then
                   Begin
                     fMensagem('ATENÇÃO!', 'Data não disponível para entrega!', ['&Ok']);
                     Result := False;
                   End;
                 End;
               End;

             End;
        End;

      End
      //QUANDO FOR ENTREGA IMEDIATA
      Else If (cmbTipEnt.ItemIndex = 1) Then //TIPO DE ENTREGA: 0 - FUTURA  1 - IMEDIATA
      Begin
        If strToDateDef(mskDtaEnt.Text, 0) < VS_Date Then
        Begin
          fMensagem('ATENÇÃO!', 'A data de entrega deve ser maior ou igual a ' + DateToStr(VS_Date) + '.', ['&Ok']);
          Result := False;
        End
        else If strToDateDef(mskDtaEnt.Text, 0) < (VS_Date + fCfgSis('QMDPEI', varInteger, fGetEmpConfigEntrega)) Then
        Begin
          objLiberacao.Clear;
          objLiberacao.objMsgLibera.pAddTexto('A data de entrega imediata deve ser maior ou igual a ' + DateToStr(VS_Date + fCfgSis('QMDPEI', varInteger, fGetEmpConfigEntrega)) + '.');
          objLiberacao.objMsgLibera.pAddTexto('Data entrega informada: ' + mskDtaEnt.Text);
          objLiberacao.objMsgLibera.pAddTexto('');
          objLiberacao.objMsgLibera.pAddTexto('Informe a senha para permitir data de entrega imediata inferior aos dias definidos na configuração');
          objLiberacao.objMsgLibera.pAddTexto('"CFG_QMDPEI - Quantidade mínima de dias para Entrega Imediata".');
          objLiberacao.objMsgLibera.pAddTexto('');

          objLiberacao.strDirAce := 'QMDPEI';
          objLiberacao.strMsgSen := 'A data de entrega imediata deve ser maior ou igual a ' + DateToStr(VS_Date + fCfgSis('QMDPEI', varInteger, fGetEmpConfigEntrega)) + '.';
          objLiberacao.strCodOpe := fatVenda.strCodVen;
          objLiberacao.strCodDig := fatVenda.strCodDig;
          objLiberacao.strCliente := fatVenda.strCodCli + '-' + fatVenda.strCliOri;
          objLiberacao.strCpfCnpj := fatVenda.strCliCgc;

          Result := fatVenda.fFatMensagemLiberacao(objLiberacao);
        End
        Else If strToDateDef(mskDtaEnt.Text, 0) > (VS_Date + fCfgSis('DIAIME', varInteger, fGetEmpConfigEntrega)) Then
        Begin
          fMensagem('ATENÇÃO!', 'A data de entrega imediata não deve ultrapassar ' +
            fCfgSis('DIAIME', VarString, fGetEmpConfigEntrega) + ' dias!', ['&Ok']);
          Result := False;
        End
        Else If Assigned(fatVenda.objConEnt) Then
        Begin
          If (Not fatVenda.objConEnt.fDataExisteNaMatriz(StrToDateDef(mskDtaEnt.Text, 0), fatVenda.objConEnt.arrDtaOri)) Then
          Begin
            If (Not fatVenda.objConEnt.fDataDisponivel(StrToDateDef(mskDtaEnt.Text, 0))) Then
            Begin
              fMensagem('ATENÇÃO!', 'Data não disponível para entrega!', ['&Ok']);
              Result := False;
            End;
          End;
        End;
      End;

    End

    Else If (Sender = cmbMotEntFut) And
            (cmbMotEntFut.Visible) And
            (cmbMotEntFut.Enabled) And
            (Pos(fatVenda.strOpcDoc,'VN_PD_OR_') > 0) Then
    Begin
      If (cmbMotEntFut.ItemIndex = IDX_MOTIVO_FALTA_PRODUTO) And
         (Not fClientePermiteEntregaFutura(fatVenda.strCodCli, 'F')) Then
      Begin
        fMensagem('ATENÇÃO','Este Cliente não tem permissão para Entrega Futura com ' + sLineBreak +
                            'Status "Falta Produto"!',['&O k']);
        Result := False;
      End

      Else If (cmbMotEntFut.ItemIndex = IDX_MOTIVO_AGUARDANDO_CLIENTE) And
              (Not fClientePermiteEntregaFutura(fatVenda.strCodCli, 'A')) Then
      Begin
        fMensagem('ATENÇÃO','Este Cliente não tem permissão para Entrega Futura com ' + sLineBreak +
                            'Status "Aguardando Cliente"!',['&O k']);
        Result := False;
      End

      Else If (cmbMotEntFut.ItemIndex = IDX_MOTIVO_PREVISAO_ENTREGA) And
              (Not fClientePermiteEntregaFutura(fatVenda.strCodCli, 'P')) Then
      Begin
        fMensagem('ATENÇÃO','Este Cliente não tem permissão para Entrega Futura com ' + sLineBreak +
                            'Status "Previsão de Entrega"!',['&O k']);
        Result := False;
      End
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
End;

procedure TfrmFatDigTipoEntregaItens.mskDtaEntKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If Not Assigned(fatVenda.objConEnt) Then
    Exit;

  If (cmbTipEnt.ItemIndex = IDX_ENTREGA_IMEDIATA) Or //Entrega Imediata ou
     ((cmbTipEnt.ItemIndex = IDX_ENTREGA_FUTURA) And //Entrega Futura e
      (cmbMotEntFut.ItemIndex = IDX_MOTIVO_PREVISAO_ENTREGA)) Then //Previsao de Entrega
  Begin
    If fPesqControleEntrega(Self, mskDtaEnt, Key) And fValidaCampos(mskDtaEnt, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmFatDigTipoEntregaItens.pDefineEmpresaItens;
  Var
    cdsDados   : TUniClientDataSet;
    stlEmpresas: TStringList;
    arrEmpresas: TStringArray;
    strEmpresa : String;
begin
  Self.strEmpresaItens := '';

  If Not fEmptyStr(strCodEmpPosAltEmp) Then
  Begin
    Self.strEmpresaItens := strCodEmpPosAltEmp;
    Exit;
  End;

  If (Pos(fatVenda.strOpcDoc, 'PD_OR_VN_') > 0) And
     fatVenda.blnEmpFat And (fCfgSis('EMCFEN', VarInteger) = 2) And
     (cdsVenda <> nil) Then
  Begin
    stlEmpresas            := TStringList.Create;
    stlEmpresas.Sorted     := True;
    stlEmpresas.Duplicates := dupIgnore;
    cdsDados               := TUniClientDataSet.Create(nil);
    cdsDados.Data          := cdsVenda.Data;

    With cdsDados Do
    Begin
      First;
      While Not Eof Do
      Begin
        If Not fEmptyStr(FieldByName('ITE_EMPITE').AsString) Then
          stlEmpresas.Add(FieldByName('ITE_EMPITE').AsString);
        Next;
      End;
    End;

    SetLength(arrEmpresas, 0);

    For strEmpresa In stlEmpresas Do
      pAddDados(arrEmpresas, strEmpresa + ' - ' + fRetNomeEmpresa(strEmpresa));

    If Length(arrEmpresas) = 1 Then
      Self.strEmpresaItens := LeftStr(arrEmpresas[0],3)

    Else If Length(arrEmpresas) > 1 Then
      Self.strEmpresaItens := LeftStr(arrEmpresas[Pred(fGetMenu('Selecione a Empresa de Entrega/Retira:', arrEmpresas, 1, False, True))],3);

    FreeAndNil(stlEmpresas);
    FreeAndNil(cdsDados);
  End;
end;

function TfrmFatDigTipoEntregaItens.fGetEmpConfigEntrega: String;
begin
  //Caso utilizando definicao de Empresa de Faturamento
  If Assigned(fatVenda) And (Pos(fatVenda.strOpcDoc, 'PD_OR_VN_') > 0) And fatVenda.blnEmpFat Then
  Begin
    //Controlar sistema de entrega por
    Case fCfgSis('EMCFEN', VarInteger) Of
      1: Result := VS_strCodEmp;   //Pela empresa Logada
      2: Result := strEmpresaItens;//pela empresa do produto
    End;
  End;

  If fEmptyStr(fRetNomeEmpresa(Result)) Then
    Result := VS_strCodEmp;
end;

procedure TfrmFatDigTipoEntregaItens.pHabilitarCamposEntrega;
  Var
    blnEntregaFutura: Boolean;
begin
  blnDesVaz              := fCfgSis('DESVAZ', varBoolean) And (fCfgSis('EMCFEN', VarInteger) = 1);
  blnEntregaFutura       := fCfgSis('ENTFUT', varBoolean, fGetEmpConfigEntrega);
  blnClienteBuscaEntrega := blnEntregaFutura And fCfgSis('CLBUEF',varBoolean,fGetEmpConfigEntrega);

  cmbEntRet.Enabled      := fCfgSis('ENTFAT', varBoolean, fGetEmpConfigEntrega);

  lblEntRet.Visible      := True;
  cmbEntRet.Visible      := True;
  lblDatEnt.Visible      := True;
  mskDtaEnt.Visible      := True;
  lblDiaEnt.Visible      := True;
  edtDiaEnt.Visible      := True;

  pnlLocRet.Visible      := False;
  pnlTipEnt.Visible      := blnEntregaFutura;
  lblTipEnt.Visible      := blnEntregaFutura;
  cmbTipEnt.Visible      := blnEntregaFutura;
  cmbTurEnt.Visible      := blnEntregaFutura;

  lblMotEntFut.Visible   := blnEntregaFutura;
  cmbMotEntFut.Visible   := blnEntregaFutura;

  cmbCliBus.Visible      := blnClienteBuscaEntrega;
  lblCliBus.Visible      := blnClienteBuscaEntrega;

  If blnEntregaFutura Then
  Begin
    If (fatVenda.fRetornaSGFTED('', fGetEmpConfigEntrega) = 'S') Then
      cmbTipEnt.ItemIndex := IDX_ENTREGA_FUTURA    //TIPO DE ENTREGA: 0 - FUTURA  1 - IMEDIATA
    Else
      cmbTipEnt.ItemIndex := IDX_ENTREGA_IMEDIATA; //TIPO DE ENTREGA: 0 - FUTURA  1 - IMEDIATA
  End;
end;

function TfrmFatDigTipoEntregaItens.fPermiteRetiraCaixa: Boolean;
var
  strFilter: string;
  blnFilter: Boolean;
  oleItens : OleVariant;
begin
  Result := True;

  If (Pos(fatVenda.strOpcDoc, 'PD_OR_VN_') > 0) Then
  begin
    If (fCfgSis('LOCRET', varBoolean)) And
       (fCfgSis('EMPFAT', varBoolean)) And
       (fCfgSis('ENT_CD', varBoolean)) Then
    Begin
      If (cmbEntRet.Visible) And (cmbEntRet.Enabled) And (cmbEntRet.Text = 'RETIRA') And
         (pnlLocRet.Visible) And (cmbLocRet.Visible) And
         (cmbLocRet.Enabled) And (cmbLocRet.Text = 'CAIXA') Then
      Begin
        strFilter := cdsVenda.Filter;
        blnFilter := cdsVenda.Filtered;
        cdsVenda.Filtered  := False;
        oleItens  := cdsVenda.Data;

        If Not fEmptyStr(strSelecao) Then
        Begin
          cdsVenda.Filter := fRetFiltroSelecao;
          cdsVenda.Filtered := True;
        End;

        cdsVenda.First;
        While Not cdsVenda.Eof Do
        Begin
          If (cdsVenda.FieldByName('ITE_EMPITE').AsString <> VS_strCodEmp) Then
          Begin
            fMensagem('','O destino do item não pode ser RETIRA - CAIXA na operação multi-lojas. Favor utilizar RETIRA - EXPEDIÇÃO ou ENTREGA - IMEDIATA!', ['&OK']);
            pSetFocus(cmbEntRet);
            Result := False;
            Break;
          End;
          cdsVenda.Next;
        End;

        cdsVenda.Data := oleItens;
        cdsVenda.Filter   := strFilter;
        cdsVenda.Filtered := blnFilter;
      End;
    End;
  end;
end;

function TfrmFatDigTipoEntregaItens.fPermitirApenas1Destino: Boolean;
begin
  Result := (Pos(fatVenda.strOpcDoc, 'PD_OR_VN_') > 0) And fCfgSis('TR1DES', varBoolean) And (fCfgSis('EMCFEN', varInteger) = 1);
end;

function TfrmFatDigTipoEntregaItens.fRetFiltroSelecao: String;
  var
    strSelecaoAux: String;
begin
  strSelecaoAux := '';
  If blnAlteraTodosItensEntregaImediata Then
  Begin
    If (Not fEmptyStr(strItensEntregaImediata)) Then
      strSelecaoAux := IIF(Not fEmptyStr(strSelecao),',','') + strItensEntregaImediata;
  End;
  
  Result := ' ITE_ORDITE IN (' + strSelecao + strSelecaoAux + ') ';
end;

procedure TfrmFatDigTipoEntregaItens.pEnabledDestino(blnEnabled: Boolean);
begin
  cmbEntRet.Enabled := blnEnabled;
  cmbLocRet.Enabled := blnEnabled;

  If (blnEnabled) And (cmbEntRet.ItemIndex = IDX_RETIRA) Then
    Exit;

  cmbTipEnt.Enabled := blnEnabled;
  cmbMotEntFut.Enabled := blnEnabled;
  mskDtaEnt.Enabled := blnEnabled;
  edtDiaEnt.Enabled := blnEnabled;
end;

function TfrmFatDigTipoEntregaItens.fTemLoteDefinido: Boolean;
var
  strSel: string;
  strFilter: string;
  blnFilter: Boolean;
  intCont: Integer;
  intContIni: Integer;
  strAutoIncrem: string;
  qryAux: TUniQuery;
begin
  if (fCfgSis('ENTDEF', varString) <> 'S') then
    Exit(False);

  if cmbEntRet.Text[1] = 'E' then
  begin
    if cmbTipEnt.Text[1] <> 'F' then
      Exit(False);
  end
  else
    Exit(False);

  strAutoIncrem := '';  
  
  if fEmptyStr(FstrNumDoc) then
  begin
    strFilter := cdsVenda.Filter;
    blnFilter := cdsVenda.Filtered;
    cdsVenda.Filtered  := False;

    strSel := 'ITE_NUMLOT <> ' + QuotedStr('') + ' AND ITE_NUMLOT <> ' +QuotedStr('A DEFINIR');
    if not fEmptyStr(strSelecao) then
      strSel := strSel + ' AND ' + fRetFiltroSelecao;

    cdsVenda.Filter := strSel;
    cdsVenda.Filtered := True;

    Result := (cdsVenda.RecordCount > 0);

    cdsVenda.Filter   := strFilter;
    cdsVenda.Filtered := blnFilter;
  end
  else
  begin
    if (Length(arrSelecaoAutoIncrem) <= 0) then
      Exit(False);
      
    intContIni := Low(ArrSelecaoAutoIncrem);
    for intCont := intContIni to High(ArrSelecaoAutoIncrem) do
    begin
      if (intCont <> intContIni) then
        strAutoIncrem := strAutoIncrem + ', ';
        
      strAutoIncrem := strAutoIncrem + QuotedStr(ArrSelecaoAutoIncrem[intCont]);
    end;
    
    qryAux := fCriaQuery();
    try
      qryAux.SQL.Add('SELECT ');
      qryAux.SQL.Add('  COUNT(*) QTDE ');
      qryAux.SQL.Add('FROM ');
      qryAux.SQL.Add('  FATDOR ');
      qryAux.SQL.Add('WHERE ');
      qryAux.SQL.Add('  AUTOINCREM IN (' + strAutoIncrem + ')');
      qryAux.SQL.Add('  AND IFNULL(FDO_NUMLOT, "") <> "" ');
      qryAux.SQL.Add('  AND FDO_NUMLOT <> "A DEFINIR" ');

      qryAux.Open;

      Result := (qryAux.FieldByName('QTDE').AsInteger > 0);
    
      qryAux.Close;
    finally
      FreeAndNil(qryAux);
    end;
  end;
end;

function TfrmFatDigTipoEntregaItens.fTipEntPrimeiroItem: Integer;
  Var
    prcScroll: TprcScroll;
    intRecNo: Integer;
Begin
  Result := -1;

  if cdsVenda = nil then
    Exit;

  pDisableControls(cdsVenda, prcScroll);
  intRecNo := cdsVenda.RecNo;
  Try
    cdsVenda.First;

    If cdsVenda.FieldByName('ITE_ENTFUT').AsString = 'S' Then
      Result := IDX_ENTREGA_FUTURA
    Else
      Result := IDX_ENTREGA_IMEDIATA;
  Finally
    cdsVenda.RecNo := intRecNo;
    pEnableControls(cdsVenda, prcScroll);
  End;
end;

function TfrmFatDigTipoEntregaItens.fLocRetPrimeiroItem: Integer;
  Var
    prcScroll: TprcScroll;
    intRecNo: Integer;
Begin
  Result := -1;

  if cdsVenda = nil then
    Exit;

  pDisableControls(cdsVenda, prcScroll);
  intRecNo := cdsVenda.RecNo;
  Try
    cdsVenda.First;
    Result := fRetLocalRetira(cdsVenda.FieldByName('ITE_LOCRET').AsString);
  Finally
    cdsVenda.RecNo := intRecNo;
    pEnableControls(cdsVenda, prcScroll);
  End;
end;

procedure TfrmFatDigTipoEntregaItens.pSetaCampoDestino;
begin
  cmbLocRet.ItemIndex := fSugestaoLocalRetira;

  If fPermitirApenas1Destino Then
  Begin
    {******************************************************}
    {* PERMITIR DEIXAR O COMBO ENTREGA/RETIRA HABILITADO  *}
    {* POIS ESTA ROTINA IRÁ ATUALIZAR TODOS OS ITENS      *}
    {* MANTENDO UM ÚNICO DESTINO. ANTES ESTAVA TRAZENDO O *}
    {* COMBO DESABILITADO E NÃO PERMITIA ALTERAR          *}
    {***************************************************PZ*}
    pEnabledDestino(True);
    cmbEntRet.ItemIndex := fatVenda.intIdxPri; // Indice do primeiro registro inserido
    cmbTipEnt.ItemIndex := fTipEntPrimeiroItem;
    cmbLocRet.ItemIndex := fLocRetPrimeiroItem;
  End
  Else If fatVenda.strOpcDoc = 'UC' Then
    cmbEntRet.ItemIndex := IDX_RETIRA

  Else If fatVenda.strOpcDoc = 'DV' Then
    cmbEntRet.ItemIndex := IDX_ENTREGA

  Else If (blnDesVaz) And (cmbEntRet.Visible) And (fCfgSis('ENTFAT', varBoolean, fGetEmpConfigEntrega)) And (fatVenda <> Nil) Then
  Begin
    If (fatVenda.intIdxPri = -1) Then
      cmbEntRet.ItemIndex := IDX_VAZIO // Indice do primeiro registro inserido
    Else
    Begin
      cmbEntRet.ItemIndex := fatVenda.intIdxPri; // Indice do primeiro registro inserido
      cmbTipEnt.ItemIndex := fTipEntPrimeiroItem;
      cmbLocRet.ItemIndex := fLocRetPrimeiroItem;
    End;
  End

  Else If (Assigned(fatVenda)) And (fatVenda.blnCliFil) Then
  Begin
    If fCfgSis('SUG_TE', VarString, fGetEmpConfigEntrega) = 'S' Then
      cmbEntRet.ItemIndex := IDX_ENTREGA  // Entrega
    Else
      cmbEntRet.ItemIndex := IDX_RETIRA; // Retira
  End

  Else If fCfgSis('SUJROM', VarString, fGetEmpConfigEntrega) = 'S' Then
    cmbEntRet.ItemIndex := IDX_ENTREGA  // Entrega
  Else
    cmbEntRet.ItemIndex := IDX_RETIRA; // Retira

end;

procedure TfrmFatDigTipoEntregaItens.pVerificaSeVaiAlterarTodosItensComoMesmaDataEntregaImediata;
begin
  pnlInfo.Caption := '';
  pnlInfo.Font.Color := clBlack;
  blnAlteraTodosItensEntregaImediata := False;
  If (Not fCfgSis('PDVIME', varBoolean)) And (Pos(fatVenda.strOpcDoc, 'OR_PD_VN_') > 0) Then
  Begin
    If (cmbEntRet.ItemIndex = IDX_ENTREGA) And (cmbTipEnt.ItemIndex = IDX_ENTREGA_IMEDIATA) Then
    Begin
      blnAlteraTodosItensEntregaImediata := True;
      pnlInfo.Caption := 'Todos itens de ENTREGA IMEDIATA serão alterados com a mesma data de entrega, mesmo os não marcados na tela anterior.';
      pnlInfo.Font.Color := clRed;
    End;
  End;
end;

procedure TfrmFatDigTipoEntregaItens.mskDtaEntChange(Sender: TObject);
begin
  inherited;
  fatVenda.blnLibMinDiaFutPrev := False;
  fatVenda.blnLibMaxDiaFutPrev := False;
end;

procedure TfrmFatDigTipoEntregaItens.mskDtaEntExit(Sender: TObject);
var
  intDiaEnt : Extended;
  dtaData   : TDateTime;
begin
  inherited;

  If fEmptyStr(fTiraCaracEspeciais(mskDtaEnt.Text)) Then
    Exit;

  dtaData := StrToDateDef(mskDtaEnt.Text, 0);
  If (Not fTravarDataForaDiaUtil(dtaData, intDiaEnt, FstrCodEmp)) Then
  Begin
    mskDtaEnt.Text := DateToStr(dtaData);
    pSetFocus(mskDtaEnt);
    Exit;
  End;

  edtDiaEnt.Text := FloatToStr(intDiaEnt);
end;

function TfrmFatDigTipoEntregaItens.fRetLocalRetira(strLocRet: String): Integer;
var
  intIdxLocRec: Integer;
begin
  intIdxLocRec := IndexText(strLocRet, ARR_LOC_RET);

  if intIdxLocRec = -1 then
    Result := -1
  else
    Result := cmbLocRet.Items.IndexOf(fVerificaDescAdicionalLocRet(ARR_LOC_RET_DESC[intIdxLocRec], intIdxLocRec));
end;

end.
