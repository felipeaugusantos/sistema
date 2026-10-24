unit untFatDigPedidoCompraItens;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, ComCtrls, Buttons, ExtCtrls,
  Grids, DBGridCitel, DBGrids, Menus, EditFocus, AppEvnts, UniClientDataSet, DB, BitBtnLockedIncrem,
  frxClass, frxExportCSVTestabilidade, Uni, untLiberacao, untMsgLiberacao,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxTextEdit, cxMaskEdit,
  Datasnap.DBClient;

type
  TfrmFatDigPedidoCompraItens = class(TfrmPaiSimples)
    pnlBotoesMostra: TPanel;
    btnFechar: TBitBtnLocked;
    dtsDados: TDataSource;
    btnConfirma: TBitBtnLocked;
    dbgItensDBTableView1: TcxGridDBTableView;
    dbgItensLevel1: TcxGridLevel;
    dbgItens: TcxGrid;
    dbgItensDBTableViewCODITE: TcxGridDBColumn;
    dbgItensDBTableViewDESITE: TcxGridDBColumn;
    dbgItensDBTableViewCODUNI: TcxGridDBColumn;
    dbgItensDBTableViewQTDITE: TcxGridDBColumn;
    dbgItensDBTableViewUNITAR: TcxGridDBColumn;
    dbgItensDBTableViewTOTITE: TcxGridDBColumn;
    dbgItensDBTableViewNUMCMP: TcxGridDBColumn;
    dbgItensDBTableViewNITCMP: TcxGridDBColumn;
    dbgItensDBTableViewCOD_NF: TcxGridDBColumn;
    dbgItensDBTableViewDES_NF: TcxGridDBColumn;
    dbgItensDBTableViewCLIBAR: TcxGridDBColumn;
    dbgItensDBTableViewCODFAB: TcxGridDBColumn;
    dbgItensDBTableViewNUMPLA: TcxGridDBColumn;
    dbgItensDBTableViewPARNUM: TcxGridDBColumn;
    dbgItensDBTableViewREQCOM: TcxGridDBColumn;
    dbgItensDBTableViewDESNES: TcxGridDBColumn;
    dbgItensDBTableViewDTACMP: TcxGridDBColumn;
    procedure btnFecharClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure dbgItensDBTableView1CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure dbgItensDBTableView1EditKeyPress(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Char);
    procedure dbgItensDBTableView1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    objLiberacao : TLiberacao;

    { Private declarations }
    procedure pAfterInsert(DataSet: TDataSet);
    procedure pBeforePost(DataSet: TDataSet);
    procedure pCopiarNumeroPedido;
    procedure pCopiarNumeroPlanta;
    procedure pCopiarPartialNumber;
    procedure pCopiarNumeroRequisito;
    procedure pChamaMenuCopias;
    function fExistePedido(strCodCli, strAutoincrem: String): String;
  public
    { Public declarations }
    strCodCli: String;
    strCodVen: String;

    strNumDoc: String;
    strEspDoc: String;
    strCodEmp: String;

    strChamouF10FatVendas: Boolean;

    cdsDados : TUniClientDataSet;
  end;

var
  frmFatDigPedidoCompraItens: TfrmFatDigPedidoCompraItens;

implementation

uses untFuncoesSimples, System.UITypes, untTypesSistema, untFuncFat;

{$R *.dfm}

procedure TfrmFatDigPedidoCompraItens.btnConfirmaClick(Sender: TObject);
  Var
    strTraCmp   : String;
    strSeqPed   : String;
    strSeqDet   : String;
    qryPedCmp   : TUniQuery;
    blnConfirma : Boolean;
    qryCliPro   : TUniQuery;
    intAgrupador: Integer;
    objTabela : TRegistroMsgLiberaTabela;
   	objLinha  : TLinhaMsgLibera;

  Const
    SQL_ITENS = 'SELECT ' +
                '  CONCAT(FDO_NUMDOC, "-", FDO_ESPDOC, "-", FDO_CODEMP) AS NUMDOC, ' +
                '  FDO_DTAENT AS DTAENT, ' +
                '  FDO_QTDITE AS QTDITE, ' +
                '  FDO_DTAFAT AS DTAFAT, ' +
                '  CONCAT(FDO_NUMFAT, "-", FDO_TIPFAT, "-", FDO_EMPFAT) AS DOCFAT, ' +
                '  CONCAT(FDO_CODITE, "-", FDO_DESCRI) AS DOCITE  ' +
                'FROM ' +
                '  FATDOR ' +
                'WHERE AUTOINCREM IN (:AUTINC) ' +
                'ORDER BY FDO_DTAENT, FDO_CODEMP, FDO_NUMDOC ';

  procedure pAtualizaDadosPedido; begin
    qryPedCmp.Close();
    qryPedCmp.SQL.Clear();

    qryPedCmp.SQL.Text := StringReplace(SQL_ITENS, '(:AUTINC)', '(' + strSeqPed + ')', [rfReplaceAll]);

    qryPedCmp.Open();
    qryPedCmp.First();
  end;

  procedure pAtualizaClipro;
  begin
    if (fEmptyStr(cdsDados.FieldByName('ITE_COD_NF').AsString)) and
       (fEmptyStr(cdsDados.FieldByName('ITE_DES_NF').AsString)) and
       (fEmptyStr(cdsDados.FieldByName('ITE_CLIBAR').AsString)) then
      exit;

    qryCliPro.Close;
    qryCliPro.SQL.Clear;
    qryCliPro.SQL.Add('SELECT                                   ');
    qryCliPro.SQL.Add('  CLIPRO.AUTOINCREM AS AUTINC,           ');
    qryCliPro.SQL.Add('  CLI_CODCLI AS CODCLI,                  ');
    qryCliPro.SQL.Add('  CLI_CODITE AS CODPRO,                  ');
    qryCliPro.SQL.Add('  ITE_DESITE AS NOMPRO,                  ');
    qryCliPro.SQL.Add('  UNI_SIGUNI AS UNIDAD,                  ');
    qryCliPro.SQL.Add('  CLI_COD_NF AS COD_NF,                  ');
    qryCliPro.SQL.Add('  CLI_CODBAR AS CODBAR,                  ');
    qryCliPro.SQL.Add('  CLI_DES_NF AS DES_NF                   ');
    qryCliPro.SQL.Add('FROM                                     ');
    qryCliPro.SQL.Add('  CLIPRO                                 ');
    qryCliPro.SQL.Add('  JOIN CADITE ON ITE_CODITE = CLI_CODITE ');
    qryCliPro.SQL.Add('  LEFT JOIN CADUNI ON UNI_CODUNI = COALESCE(CLI_CODUNI, ITE_CODUNI) ');
    qryCliPro.SQL.Add('WHERE                                    ');
    qryCliPro.SQL.Add('  CLI_CODCLI = :CODCLI                   ');
    qryCliPro.SQL.Add('AND                                      ');
    qryCliPro.SQL.Add('  CLI_CODITE = :CODITE                   ');

    qryCliPro.ParamByName('CODCLI').AsString := strCodCli;
    qryCliPro.ParamByName('CODITE').AsString := cdsDados.FieldByName('ITE_CODITE').AsString;
    qryCliPro.Open;

    if not qryCliPro.isEmpty then
    begin
      qryCliPro.Close;
      qryCliPro.SQL.Clear;
      qryCliPro.SQL.Add('UPDATE CLIPRO SET ');
      qryCliPro.SQL.Add('CLI_COD_NF = '+quotedStr(cdsDados.FieldByName('ITE_COD_NF').AsString)+',');
      qryCliPro.SQL.Add('CLI_DES_NF = '+quotedStr(cdsDados.FieldByName('ITE_DES_NF').AsString)+',');
      qryCliPro.SQL.Add('CLI_CODBAR = '+quotedStr(cdsDados.FieldByName('ITE_CLIBAR').AsString));
      qryCliPro.SQL.Add('WHERE                                    ');
      qryCliPro.SQL.Add('  CLI_CODCLI = :CODCLI                   ');
      qryCliPro.SQL.Add('AND                                      ');
      qryCliPro.SQL.Add('  CLI_CODITE = :CODITE                   ');

      qryCliPro.ParamByName('CODCLI').AsString := strCodCli;
      qryCliPro.ParamByName('CODITE').AsString := cdsDados.FieldByName('ITE_CODITE').AsString;
      qryCliPro.ExecSql;
    end
    else
    begin
      qryCliPro.Close;
      qryCliPro.SQL.Clear;
      qryCliPro.SQL.Add('INSERT INTO CLIPRO    ');
      qryCliPro.SQL.Add('(CLI_CODCLI,          ');
      qryCliPro.SQL.Add(' AUTOINCREM,          ');
      qryCliPro.SQL.Add(' CLI_CODITE           ');
      if (not fEmptyStr(cdsDados.FieldByName('ITE_COD_NF').AsString)) then
        qryCliPro.SQL.Add(' ,CLI_COD_NF          ');
      if (not fEmptyStr(cdsDados.FieldByName('ITE_DES_NF').AsString)) then
        qryCliPro.SQL.Add(' ,CLI_DES_NF          ');
      if (not fEmptyStr(cdsDados.FieldByName('ITE_CLIBAR').AsString)) then
        qryCliPro.SQL.Add(' ,CLI_CODBAR          ');
      qryCliPro.SQL.Add(' )');
      qryCliPro.SQL.Add('VALUES                ');
      qryCliPro.SQL.Add('(:CODCLI,          ');
      qryCliPro.SQL.Add(' :AUTINC,          ');
      qryCliPro.SQL.Add(' :CODITE           ');
      if (not fEmptyStr(cdsDados.FieldByName('ITE_COD_NF').AsString)) then
        qryCliPro.SQL.Add(' ,:COD_NF          ');
      if (not fEmptyStr(cdsDados.FieldByName('ITE_DES_NF').AsString)) then
        qryCliPro.SQL.Add(' ,:DES_NF          ');
      if (not fEmptyStr(cdsDados.FieldByName('ITE_CLIBAR').AsString)) then
        qryCliPro.SQL.Add(' ,:CODBAR          ');

      qryCliPro.SQL.Add(' )');

      qryCliPro.ParamByName('CODCLI').AsString := strCodCli;
      qryCliPro.ParamByName('AUTINC').AsString := fRetAutoIncrem('CLIPRO', VS_strCodEmp);
      qryCliPro.ParamByName('CODITE').AsString := cdsDados.FieldByName('ITE_CODITE').AsString;
      if (not fEmptyStr(cdsDados.FieldByName('ITE_COD_NF').AsString)) then
        qryCliPro.ParamByName('COD_NF').AsString := cdsDados.FieldByName('ITE_COD_NF').AsString;
      if (not fEmptyStr(cdsDados.FieldByName('ITE_DES_NF').AsString)) then
        qryCliPro.ParamByName('DES_NF').AsString := cdsDados.FieldByName('ITE_DES_NF').AsString;
      if (not fEmptyStr(cdsDados.FieldByName('ITE_CLIBAR').AsString)) then
        qryCliPro.ParamByName('CODBAR').AsString := cdsDados.FieldByName('ITE_CLIBAR').AsString;

      qryCliPro.ExecSQL;
    end;
  end;

begin
  inherited;

  Try
    qryPedCmp := fCriaQuery(Self);
    qryCliPro := fCriaQuery(self);

    cdsDados.First();

    strTraCmp := fCfgSis('TRACMP', varString);

    blnConfirma := True;

    If (strTraCmp <> 'N') Then
    Begin
      objLiberacao.Clear;
      objLiberacao.objMsgLibera.pAddTexto('Digitação do Número do Pedido de Compra');
      objLiberacao.objMsgLibera.pAddQuebra;

      objLiberacao.objMsgLibera.pAddQuebra;
      objLiberacao.objMsgLibera.pAddSeparador(129);

      If (strTraCmp = 'A') Then
      Begin
        objLiberacao.objMsgLibera.pAddTexto('Já foi digitado o mesmo pedido de compra em outro documento do mesmo cliente, confira se está');
        objLiberacao.objMsgLibera.pAddTexto('correto o procedimento e prossiga.');
      End
      Else
      Begin
        objLiberacao.objMsgLibera.pAddTexto('Já foi digitado o mesmo pedido de compra em outro documento do mesmo cliente, confira e solicite');
        objLiberacao.objMsgLibera.pAddTexto('liberação para prosseguir, caso necessário.');
      End;

      objTabela := TRegistroMsgLiberaTabela.Create;


      While (Not cdsDados.Eof) Do
      Begin

        strSeqPed := '';
        strSeqDet := fCampoTabela('AUTOINCREM', 'FATGOR', ['FGO_NUMDOC', 'FGO_ESPDOC', 'FGO_CODEMP'],
                       [strNumDoc, strEspDoc, strCodEmp]);

        If (Not fEmptyStr(cdsDados.FieldByName('ITE_NUMCMP').AsString)) Then
        Begin

          strSeqPed := fExistePedido(strCodCli, strSeqDet);

          If (Not fEmptyStr(strSeqPed)) Then
          Begin

            pAtualizaDadosPedido();

            objLinha  := TLinhaMsgLibera.Create;
            objLinha.enuTipoLinha := tlCabecalho;
            objLinha.pAddColuna(''  , 'PRODUTO' , 120 , alEsquerda , teAutcom);
            objLinha.pAddColuna(''  , 'UN'      , 4   , alCentro  , teAutcom);
            objTabela.lstLinhas.Add(objLinha);

            objLinha  := TLinhaMsgLibera.Create;
            objLinha.enuTipoLinha := tlCabecalho;
            objLinha.pAddColuna(''  , 'PRODUTO.VINCULADO' , 126 , alEsquerda , teAutcom);
            objTabela.lstLinhas.Add(objLinha);

            objLinha  := TLinhaMsgLibera.Create;
            objLinha.enuTipoLinha := tlCabecalho;
            objLinha.pAddColuna(''  , 'PED.COMPRA' , 20 , alEsquerda , teAutcom);

            if fCfgSis('SDTRPC', varBoolean) then
              objLinha.pAddColuna(''  , 'DT.CMP.'    , 14 , alCentro   , teAutcom);

            objLinha.pAddColuna(''  , 'SEQ'        , 10 , alEsquerda , teAutcom);
            objLinha.pAddColuna(''  , 'DOCUMENTO'  , 22 , alEsquerda , teAutcom);
            objLinha.pAddColuna(''  , 'DT.EMISSAO' , 14 , alCentro   , teAutcom);
            objLinha.pAddColuna(''  , 'QUANTIDADE' , 12 , alDireita  , teAutcom);
            objLinha.pAddColuna(''  , 'DT.FAT.'    , 14 , alCentro   , teAutcom);
            objLinha.pAddColuna(''  , 'DOC.FAT.'   , 22 , alDireita  , teAutcom);
            objTabela.lstLinhas.Add(objLinha);

            intAgrupador := -1;
            While (Not qryPedCmp.Eof) Do
            Begin
              inc(intAgrupador);

              objLinha  := TLinhaMsgLibera.Create;
              objLinha.enuTipoLinha := tlValor;
              objLinha.intAgrupador := intAgrupador;
              objLinha.pAddColuna('PRODUTO' ,   cdsDados.FieldByName('ITE_CODITE').AsString + '-'
                                              + cdsDados.FieldByName('ITE_DESITE').AsString      , 120 , alEsquerda );
              objLinha.pAddColuna('UN'      ,   cdsDados.FieldByName('ITE_CODUNI').AsString      , 4   , alCentro  );
              objTabela.lstLinhas.Add(objLinha);

              objLinha  := TLinhaMsgLibera.Create;
              objLinha.enuTipoLinha := tlValor;
              objLinha.intAgrupador := intAgrupador;
              objLinha.pAddColuna('PRODUTO.VINCULADO' , qryPedCmp.FieldByName('DOCITE').AsString , 126 , alEsquerda );
              objTabela.lstLinhas.Add(objLinha);

              objLinha  := TLinhaMsgLibera.Create;
              objLinha.enuTipoLinha := tlValor;
              objLinha.intAgrupador := intAgrupador;
              objLinha.pAddColuna('PED.COMPRA' , cdsDados.FieldByName('ITE_NUMCMP').AsString                                   , 20 , alEsquerda );

              if fCfgSis('SDTRPC', varBoolean) then
                objLinha.pAddColuna('DT.CMP.'    , IIF(cdsDados.FieldByName('ITE_DTACMP').AsDateTime = 0,
                                                       fPadR('', 10),
                                                       FormatDateTime('dd/mm/yyyy', cdsDados.FieldByName('ITE_DTACMP').AsDateTime)) , 14 , alCentro);

              objLinha.pAddColuna('SEQ'        , IntToStr(cdsDados.FieldByName('ITE_NITCMP').AsInteger)                                   , 10 , alEsquerda );
              objLinha.pAddColuna('DOCUMENTO'  , qryPedCmp.FieldByName('NUMDOC').AsString                                      , 22 , alEsquerda , teAutcom);
              objLinha.pAddColuna('DT.EMISSAO' , IIF(qryPedCmp.FieldByName('DTAENT').AsDateTime = 0,
                                                     '',
                                                     FormatDateTime('dd/mm/yyyy', qryPedCmp.FieldByName('DTAENT').AsDateTime)) , 14 , alCentro   );
              objLinha.pAddColuna('QUANTIDADE' , FloatToStrF(qryPedCmp.FieldByName('QTDITE').AsFloat,ffNumber, 9, 2)           , 12 , alDireita  );
              objLinha.pAddColuna('DT.FAT.'    , IIF(qryPedCmp.FieldByName('DTAFAT').AsDateTime = 0,
                                                     fPadR('', 10),
                                                     FormatDateTime('dd/mm/yyyy', qryPedCmp.FieldByName('DTAFAT').AsDateTime)) , 14 , alCentro   );
              objLinha.pAddColuna('DOC.FAT.'   , qryPedCmp.FieldByName('DOCFAT').AsString                                      , 22 , alDireita  );
              objTabela.lstLinhas.Add(objLinha);


              qryPedCmp.Next();
            End;

          End;

        End;

        pAtualizaClipro;
        cdsDados.Next();

      End;

      If objTabela.isEmpty Then
        FreeAndNil(objTabela)
      else
      Begin
        objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

        objLiberacao.strDirAce := 'PCRPOP';
        objLiberacao.blnTraTel := (Not (strTraCmp = 'A'));
        objLiberacao.strMsgSen := 'Digitação do Número do Pedido de Compra';
        objLiberacao.strCodOpe := strCodVen;
        objLiberacao.strCodDig := strLoginUsuarioLogado;

        blnConfirma := objLiberacao.fLibera;
      End;

    End;

    If (blnConfirma) Then
    Begin
      Close;
      ModalResult := mrOk;
    End;

  Finally
    FreeAndNil(qryPedCmp);
    FreeAndNil(qryCliPro);
  End;

end;

procedure TfrmFatDigPedidoCompraItens.btnFecharClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmFatDigPedidoCompraItens.dbgItensDBTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If (Not Assigned(cdsDados)) Or (Not cdsDados.Active) Or cdsDados.IsEmpty Then
    Exit;

  if AViewInfo.Item.Index in [dbgItensDBTableViewNUMCMP.Index, dbgItensDBTableViewNITCMP.Index, dbgItensDBTableViewCOD_NF.Index,
                              dbgItensDBTableViewDES_NF.Index, dbgItensDBTableViewCLIBAR.Index, dbgItensDBTableViewNUMPLA.Index,
                              dbgItensDBTableViewPARNUM.Index, dbgItensDBTableViewREQCOM.Index, dbgItensDBTableViewDESNES.Index,
                              dbgItensDBTableViewDTACMP.Index] then
  begin
    ACanvas.Brush.Color := $009FFDF5;
  end;

  if AViewInfo.Selected then
  begin
    ACanvas.Brush.Color := clHighlight;
  end;
end;

procedure TfrmFatDigPedidoCompraItens.dbgItensDBTableView1EditKeyPress(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Char);
begin
  inherited;
  If (CharInSet(Key, ['-', '+', ',', '.']) And
     (dbgItensDBTableView1.Controller.FocusedColumn = dbgItensDBTableViewNITCMP))  Then
  Begin
    Key := #0;
  End;
end;

procedure TfrmFatDigPedidoCompraItens.dbgItensDBTableView1KeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_F5 Then
  Begin
    if dbgItensDBTableViewNUMPLA.Visible then
      pChamaMenuCopias
    else
      pCopiarNumeroPedido;
  End;

  If Key = VK_F10 Then
  Begin
    Key := 0;
    btnConfirma.Click;
  End;

  If Key = VK_Escape Then
  Begin
    btnFechar.Click;
  End;

  If (Key = VK_DELETE) And (cdsDados.State <> dsEdit) Then
  Begin
    Key := 0;
  End;
end;

function TfrmFatDigPedidoCompraItens.fExistePedido(strCodCli, strAutoincrem: String): String;
Var
  qryTmp : TUniQuery;
begin

  qryTmp := fCriaQuery(Self);
  Result := '';

  Try

    qryTmp.SQL.Add(' SELECT GROUP_CONCAT(FATDOR.AUTOINCREM) AS AUTOINCREM FROM FATDOR');
    qryTmp.SQL.Add(' INNER JOIN EXTDOR ON FDO_SEQFDO = AUTOINCREM');
    qryTmp.SQL.Add('   WHERE FDO_CODCLI = :CODCLI');
    qryTmp.SQL.Add('     AND FDO_NUMCMP = :NUMCMP');
    qryTmp.SQL.Add('     AND FDO_NITCMP = :NITCMP');
    qryTmp.SQL.Add('     AND FDO_SEQGER <> :AUTOIN');
    qryTmp.ParambyName('CODCLI').AsString := strCodCli;
    qryTmp.ParambyName('NUMCMP').AsString := cdsDados.FieldByName('ITE_NUMCMP').AsString;
    qryTmp.ParambyName('NITCMP').AsInteger := cdsDados.FieldByName('ITE_NITCMP').AsInteger;
    qryTmp.ParambyName('AUTOIN').AsString := strAutoincrem;
    qryTmp.Open;

    if Not fEmptyStr(qryTmp.FieldByName('AUTOINCREM').AsString) then
      Result := '"' + qryTmp.FieldByName('AUTOINCREM').AsString + '"';

    If Pos(',',Result, 1) > 0 Then
      Result := fReplaceStr(Result, ',', '","');

    qryTmp.Close;
  Except

    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmFatDigPedidoCompraItens.fExistePedido]');
    End;

  End;

  FreeAndNiL(qryTmp);

end;

procedure TfrmFatDigPedidoCompraItens.FormShow(Sender: TObject);
begin
  inherited;
  TFloatField(cdsDados.FieldByName('ITE_QTDITE')).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
  TFloatField(cdsDados.FieldByName('ITE_UNITAR')).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
  TFloatField(cdsDados.FieldByName('ITE_TOTITE')).DisplayFormat := '#,##0.00';
  TIntegerField(cdsDados.FieldByName('ITE_NITCMP')).EditMask    := '000000;0;_';
  TIntegerField(cdsDados.FieldByName('ITE_NITCMP')).DisplayFormat := '000000;0;_';

  dbgItensDBTableViewNUMPLA.Visible := fCampoTabela('CLI_CLIMON', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False) = 'S';
  dbgItensDBTableViewPARNUM.Visible := dbgItensDBTableViewNUMPLA.Visible;
  dbgItensDBTableViewREQCOM.Visible := dbgItensDBTableViewNUMPLA.Visible;

  dbgItensDBTableViewDESNES.Visible := fCfgSis('PDPCDN', varBoolean);
  dbgItensDBTableViewDTACMP.Visible := fCfgSis('SDTRPC', varBoolean);

  if dbgItensDBTableViewNUMPLA.Visible then
    pnlBotoesMostra.Caption := 'Pressione [F5] sobre um produto para  informar o campo que deseja copiar para todos...';

  dtsDados.DataSet := cdsDados;
  cdsDados.AfterInsert := pAfterInsert;
  cdsDados.BeforePost  := pBeforePost;

  if not strChamouF10FatVendas then
  begin
    cdsDados.IndexFieldNames := 'ITE_ORDITE';
  end;

  pSetFocus(dbgItens);
end;

procedure TfrmFatDigPedidoCompraItens.pAfterInsert(DataSet: TDataSet);
begin
  DataSet.Cancel;
end;

procedure TfrmFatDigPedidoCompraItens.pBeforePost(DataSet: TDataSet);
begin
  DataSet.FieldByName('ITE_NUMCMP').AsString := Trim(DataSet.FieldByName('ITE_NUMCMP').AsString);
end;

procedure TfrmFatDigPedidoCompraItens.pChamaMenuCopias;
begin
  Case fGetMenu('Informe qual campo copiar', ['Número do pedido de compra',
                     'Número da planta',
                     'Partial number',
                     'Número de requisição da compra interna do cliente'], 1, False, False, 210) Of
    1: pCopiarNumeroPedido;
    2: pCopiarNumeroPlanta;
    3: pCopiarPartialNumber;
    4: pCopiarNumeroRequisito;
  End;
end;

procedure TfrmFatDigPedidoCompraItens.pCopiarNumeroPedido;
  Var
    strNumCmp: String;
begin
  if dbgItensDBTableViewNUMPLA.Visible then
  begin
    strNumCmp := cdsDados.FieldByName('ITE_NUMCMP').AsString;

    cdsDados.First;
    While Not cdsDados.Eof Do
    Begin
      cdsDados.Edit;
      cdsDados.FieldByName('ITE_NUMCMP').AsString := strNumCmp;
      cdsDados.Post;
      cdsDados.Next;
    End;
  end
  else
  begin
    If fPergunta('Deseja alterar todos os itens para o número ' +
                 'do pedido de compra "' + cdsDados.FieldByName('ITE_NUMCMP').AsString + '" ?') Then
    Begin
      strNumCmp := cdsDados.FieldByName('ITE_NUMCMP').AsString;

      cdsDados.First;
      While Not cdsDados.Eof Do
      Begin
        cdsDados.Edit;
        cdsDados.FieldByName('ITE_NUMCMP').AsString := strNumCmp;
        cdsDados.Post;
        cdsDados.Next;
      End;
    End;
  end
end;

procedure TfrmFatDigPedidoCompraItens.pCopiarNumeroPlanta;
var
  strNumPla: String;
begin
  strNumPla := cdsDados.FieldByName('ITE_NUMPLA').AsString;

  cdsDados.First;
  While Not cdsDados.Eof Do
  Begin
    cdsDados.Edit;
    cdsDados.FieldByName('ITE_NUMPLA').AsString := strNumPla;
    cdsDados.Post;
    cdsDados.Next;
  End;
end;

procedure TfrmFatDigPedidoCompraItens.pCopiarNumeroRequisito;
var
  strReqCom: String;
begin
  strReqCom := cdsDados.FieldByName('ITE_REQCOM').AsString;

  cdsDados.First;
  While Not cdsDados.Eof Do
  Begin
    cdsDados.Edit;
    cdsDados.FieldByName('ITE_REQCOM').AsString := strReqCom;
    cdsDados.Post;
    cdsDados.Next;
  End;
end;

procedure TfrmFatDigPedidoCompraItens.pCopiarPartialNumber;
var
  strParNum: String;
begin
  strParNum := cdsDados.FieldByName('ITE_PARNUM').AsString;

  cdsDados.First;
  While Not cdsDados.Eof Do
  Begin
    cdsDados.Edit;
    cdsDados.FieldByName('ITE_PARNUM').AsString := strParNum;
    cdsDados.Post;
    cdsDados.Next;
  End;
end;

procedure TfrmFatDigPedidoCompraItens.FormCreate(Sender: TObject);
begin
  inherited;
  cdsDados  := TUniClientDataSet.Create(Self);
  objLiberacao := TLiberacao.Create;

  strNumDoc := '';
  strEspDoc := '';
  strCodEmp := '';

  strCodCli := '';
  strCodVen := '';

  strChamouF10FatVendas := False;
end;

procedure TfrmFatDigPedidoCompraItens.FormDestroy(Sender: TObject);
begin
  if Assigned(objLiberacao) then
    FreeAndNil(objLiberacao);
  inherited;

end;

end.
