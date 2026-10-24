unit untBaixaOrdProdGeralIndustrial;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, dxBar, dxBarExtItems, cxClasses, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGridCustomView, cxGrid, untZClient, untFuncoesSimples, untBaixaOrdProdIndustrial,
  Vcl.Mask, MaskEditFocus, cxCalendar, cxTimeEdit, cxMaskEdit,
  typInfo, Math, cxCheckBox, MemoFocus, untTypesSistema, System.Actions, Vcl.ActnList,
  uni, untConsultas, cxGridCitel, untOrdProIndustrial, UniClientDataSet, UniDataSetProvider,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, cxButtonEdit, untCfgGrid, Winapi.ShlObj,
  System.IniFiles, dxDateTimeWheelPicker, dxCore, EditFocus;

  Type
    TRecDimFrm = Record
      wrdHeight,
      wrdWidth: Word;
      blnMaxim,
      blnCarregar: Boolean;
  End;

type
  TfrmBaixaOrdProdGeralIndustrial = class(TfrmPaiConfirma)
    dxBarManager1: TdxBarManager;
    btnClose: TdxBarButton;
    btnBaixarOP: TdxBarButton;
    dxBarGroup1: TdxBarGroup;
    btnUpdate: TdxBarButton;
    pnlRodape: TPanel;
    lblInformacao: TLabel;
    GroupBox1: TGroupBox;
    Shape1: TShape;
    Label6: TLabel;
    Shape2: TShape;
    Label7: TLabel;
    Shape3: TShape;
    Label8: TLabel;
    btnMarcaItem: TBitBtnLocked;
    btnMarcaTodos: TBitBtnLocked;
    pnlCabecalho: TPanel;
    Label4: TLabel;
    mskDtaBai: TMaskEditFocus;
    cxgOrdPro: TcxGrid;
    cxgOrdProTable: TcxGridDBTableView;
    cxgOrdProTableCODORD: TcxGridDBColumn;
    cxgOrdProLevel: TcxGridLevel;
    cxgOrdProTableNUMLOT: TcxGridDBColumn;
    cxgOrdProTableDTACAD: TcxGridDBColumn;
    cxgOrdProTableCODITE: TcxGridDBColumn;
    cxgOrdProTableDESITE: TcxGridDBColumn;
    cxgOrdProTableCODCOR: TcxGridDBColumn;
    cxgOrdProTableDESCOR: TcxGridDBColumn;
    cxgOrdProTableREFERE: TcxGridDBColumn;
    cxgOrdProTableVOLUME: TcxGridDBColumn;
    cxgOrdProTablePESTOT: TcxGridDBColumn;
    cxgOrdProTablePEDIDO: TcxGridDBColumn;
    cxgOrdProTableNUMRES: TcxGridDBColumn;
    cxgOrdProTableDTAPRE: TcxGridDBColumn;
    cxgOrdProTableQTDPRO: TcxGridDBColumn;
    cxgOrdProTableQTDENV: TcxGridDBColumn;
    cxgOrdProTableMARDES: TcxGridDBColumn;
    cxgOrdProTableLOCALI: TcxGridDBColumn;
    cxgOrdProTableDTAVAL: TcxGridDBColumn;
    cxgOrdProTableDTAINI: TcxGridDBColumn;
    cxgOrdProTableHORINI: TcxGridDBColumn;
    cxgOrdProTableDTAFIN: TcxGridDBColumn;
    cxgOrdProTableHORFIN: TcxGridDBColumn;
    ActionList1: TActionList;
    LocalizacaoRapido: TAction;
    btnPreencheQtdEnvasada: TBitBtnLocked;
    cxgOrdProTablePOSSUI_LOT: TcxGridDBColumn;
    cxgOrdProTableEXTDIV: TcxGridDBColumn;
    cdsOrdProInd: TFDMemTable;
    dtsOrdProInd: TDataSource;
    cdsOrdProIndCODORD: TStringField;
    cdsOrdProIndCODITE: TStringField;
    cdsOrdProIndORD_NUMLOT: TStringField;
    cdsOrdProIndORD_PEDIDO: TStringField;
    cdsOrdProIndNUMRES: TStringField;
    cdsOrdProIndITE_DESITE: TStringField;
    cdsOrdProIndORD_CODCOR: TStringField;
    cdsOrdProIndCOR_DESCOR: TStringField;
    cdsOrdProIndITE_REFERE: TStringField;
    cdsOrdProIndVOLUME: TFloatField;
    cdsOrdProIndPESTOT: TFloatField;
    cdsOrdProIndORD_QTDPRO: TFloatField;
    cdsOrdProIndORD_QTDENV: TFloatField;
    cdsOrdProIndAUTOINCREM: TStringField;
    cdsOrdProIndMARDES: TStringField;
    cdsOrdProIndORD_LOCALI: TStringField;
    cdsOrdProIndPOSSUI_LOT: TStringField;
    cdsOrdProIndEXTDIV: TStringField;
    cdsOrdProIndBAIXADA: TStringField;
    cxgOrdProTableBotao: TcxGridDBColumn;
    AjustaProdutoAcabado: TAction;
    btnValidaLoteDosAcabados: TBitBtnLocked;
    btnCfgGri: TBitBtnLocked;
    cdsOrdProIndORD_DTACAD: TDateField;
    cdsOrdProIndORD_DTAPRE: TDateField;
    cdsOrdProIndORD_DTAVAL: TDateField;
    cdsOrdProIndORD_DTAINI: TDateField;
    cdsOrdProIndORD_DTAFIN: TDateField;
    cdsOrdProIndORD_HORINI: TStringField;
    cdsOrdProIndORD_HORFIN: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnMarcaItemClick(Sender: TObject);
    procedure btnMarcaTodosClick(Sender: TObject);
    procedure cxgOrdProTableCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure dtsOrdProIndStateChange(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnPreencheQtdEnvasadaClick(Sender: TObject);
    procedure mskDtaBaiKeyPress(Sender: TObject; var Key: Char);
    procedure AjustaProdutoAcabadoExecute(Sender: TObject);
    procedure btnValidaLoteDosAcabadosClick(Sender: TObject);
    procedure cxgOrdProTableDblClick(Sender: TObject);
    procedure btnCfgGriClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cdsOrdProIndBeforePost(DataSet: TDataSet);
    procedure LocalizacaoRapidoExecute(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure cxgOrdProTableLOCALIPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
  private

    cdsValidacaoLote: TUniClientDataSet;
    prcScroll: TprcScroll;
    objCfgGri: TCfgGrid;
    ArrCamposCfg: TArrCamposCfg;
    ArrCampoBloqueado:  TArrCamposCfg;

    recDimFrm: TRecDimFrm;

    blnPerOsa: Boolean;

    function fSqlConsulta: String;
    function fValidaCamposGrid: Boolean;
    procedure ProcessaKeyDown(ABlnDesmarcando:Boolean = False);



    procedure pAbreConsulta;
    procedure pCriaDataSetValidacaoLote;
    procedure pVerificaLoteOpiNaoEspecifico(frmBaixaOrdProdIndustrial: TfrmBaixaOrdProdIndustrial;
                                            objOrdPro: TOrdProIndustrial;
                                            var blnQuantidadeAProduzirDivergenteQuantidadeEnvasada: Boolean);

    procedure pVerificaSeExisteLoteEmTodosProdutosAcabadoAProduzir(blnVerificaLoteOpiEspecifico: Boolean = False; objOrdPro: TOrdProIndustrial = Nil);
    procedure pCarregaCdsOrdProInd(qryConsulta: TUniQuery);
    procedure pCarregaQuantidadesEnvasadas(objOrdPro: TOrdProIndustrial);
    procedure pMarcaDesmarcaOPI;
    procedure pCarregaArrCampos;
    procedure pCarregaConfiguracoes(frmBaixaOrdProdGeralIndustrial: TForm);
    function fOpiJaBaixada(strCodOrd, strDtaCad: String): Boolean;
    function fValidacoesConfirmacao: Boolean;
    procedure pPreencheCamposPorCfg(frmBaixaOrdProdIndustrial: TfrmBaixaOrdProdIndustrial);
    class function GetSpecialFolderPath(Folder: Integer; CanCreate: Boolean): String;



    procedure pSalvaConfiguracoes(frmBaixaOrdProdGeralIndustrial: TForm);
    Class function fCriarArquivoTemporario(strNomArq: String = ''; strPathTmp: String = ''): String;
    Class function fGetPathTempOpcoesLocais: String;
    Class function fEscreverNoArquivo(strNomArq, strTexto: String): Boolean;
    Class function fArquivoParaString(strNomArq: String): String;

    procedure pTrabalhaFocuDoCampoNaGrid;
    procedure pBeforePost(DataSet: TDataSet);

    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBaixaOrdProdGeralIndustrial: TfrmBaixaOrdProdGeralIndustrial;

implementation

{$R *.dfm}

uses untAjustaDadosProdutoAcabado, cxGridDBDataDefinitions;

{ TfrmBaixaOrdProdGeralIndustrial }


procedure TfrmBaixaOrdProdGeralIndustrial.AjustaProdutoAcabadoExecute(
  Sender: TObject);
Var
  frmBaixaOrdProdIndustrial: TfrmBaixaOrdProdIndustrial;
  frmAjustaDadosProdutoAcabado: TfrmAjustaDadosProdutoAcabado;
  blnBaixaRealizada: Boolean;
begin
  If cdsOrdProInd.FieldByName('MARDES').AsString <> 'M' Then
  Begin
    pMensagemOk('Selecione uma ordem de produção industrial para realizar o ajuste!');
    Exit;
  End;

  VS_ExibirMensagemAguarde:= False;

  blnBaixaRealizada:= (cdsOrdProInd.FieldByName('BAIXADA').AsString = 'S') Or
                      (fOpiJaBaixada(cdsOrdProInd.FieldByName('ORD_CODORD').AsString,
                                     cdsOrdProInd.FieldByName('ORD_DTACAD').AsString));

  If blnBaixaRealizada Then
  Begin
    pMensagemOk('Ordem de Produção já baixada!');
    Exit;
  End;


  pCriarFormularios(TfrmBaixaOrdProdIndustrial, frmBaixaOrdProdIndustrial);
  pCriarFormularios(TfrmAjustaDadosProdutoAcabado, frmAjustaDadosProdutoAcabado);

  Try

    frmBaixaOrdProdIndustrial.blnChamadaDeRotinaExterna := True;
    frmBaixaOrdProdIndustrial.strOrdProInd  := cdsOrdProInd.FieldByName('ORD_CODORD').AsString;
    frmBaixaOrdProdIndustrial.strDataCad    := cdsOrdProInd.FieldByName('ORD_DTACAD').AsString;
    frmBaixaOrdProdIndustrial.pInicializaOnShowDaTela;

    frmBaixaOrdProdIndustrial.objOrdPro.First;

    cdsValidacaoLote.Filter := 'CODORD = ' + QuotedStr(cdsOrdProInd.FieldByName('ORD_CODORD').AsString) +
                               ' AND DTACAD = ' + QuotedStr(cdsOrdProInd.FieldByName('ORD_DTACAD').AsString);
    cdsValidacaoLote.Filtered := True;

    While Not(frmBaixaOrdProdIndustrial.objOrdPro.Eof) do
    Begin

      If cdsValidacaoLote.Locate('CODITE', frmBaixaOrdProdIndustrial.objOrdPro.FieldByName('ORD_CODITE').AsString, []) Then
      Begin

        frmBaixaOrdProdIndustrial.objOrdPro.Locate('ORD_CODITE', cdsValidacaoLote.FieldByName('CODITE').AsString, []);

        frmBaixaOrdProdIndustrial.objOrdPro.Edit;
        frmBaixaOrdProdIndustrial.objOrdPro.FieldByName('ORD_CODITE').AsString := cdsValidacaoLote.FieldByName('CODITE').AsString;
        frmBaixaOrdProdIndustrial.objOrdPro.FieldByName('NUMLOT').AsString     := cdsValidacaoLote.FieldByName('NUMLOT').AsString;
        frmBaixaOrdProdIndustrial.objOrdPro.FieldByName('ORD_QTDENV').AsFloat  := cdsValidacaoLote.FieldByName('QTDENV').AsFloat;
        frmBaixaOrdProdIndustrial.objOrdPro.Post;

      End;

      frmBaixaOrdProdIndustrial.objOrdPro.Next;
    End;

    frmAjustaDadosProdutoAcabado.objOrdPro  := frmBaixaOrdProdIndustrial.objOrdPro;
    frmAjustaDadosProdutoAcabado.cxgItensView.DataController.DataSource:= frmAjustaDadosProdutoAcabado.objOrdPro.dtsSource;
    frmAjustaDadosProdutoAcabado.ShowModal;
    frmBaixaOrdProdIndustrial.objOrdPro:= frmAjustaDadosProdutoAcabado.objOrdPro;

    pVerificaSeExisteLoteEmTodosProdutosAcabadoAProduzir(False, frmBaixaOrdProdIndustrial.objOrdPro);

  Finally

    pFreeAndNil(frmBaixaOrdProdIndustrial);
    pFreeAndNil(frmAjustaDadosProdutoAcabado);

  End;

end;

procedure TfrmBaixaOrdProdGeralIndustrial.pCriaDataSetValidacaoLote;
Begin
  cdsValidacaoLote := TUniClientDataSet.Create(Self);

  cdsValidacaoLote.FieldDefs.Add('CODITE', ftString, 7);
  cdsValidacaoLote.FieldDefs.Add('CODORD', ftString, 3);
  cdsValidacaoLote.FieldDefs.Add('DTACAD', ftString, 12);
  cdsValidacaoLote.FieldDefs.Add('NUMLOT', ftString, 50);
  cdsValidacaoLote.FieldDefs.Add('POSSUI_LOT', ftString, 3);
  cdsValidacaoLote.FieldDefs.Add('EXTDIV', ftString, 3);
  cdsValidacaoLote.FieldDefs.Add('QTDENV', ftFloat);

  cdsValidacaoLote.CreateDataSet;
End;

procedure TfrmBaixaOrdProdGeralIndustrial.pVerificaLoteOpiNaoEspecifico(frmBaixaOrdProdIndustrial: TfrmBaixaOrdProdIndustrial;
                                                                        objOrdPro: TOrdProIndustrial;
                                                                        var blnQuantidadeAProduzirDivergenteQuantidadeEnvasada: Boolean);
begin
  frmBaixaOrdProdIndustrial.strOrdProInd  := cdsOrdProInd.FieldByName('ORD_CODORD').AsString;
  frmBaixaOrdProdIndustrial.strDataCad    := cdsOrdProInd.FieldByName('ORD_DTACAD').AsString;

  frmBaixaOrdProdIndustrial.blnChamadaDeRotinaExterna := True;

  If objOrdPro = Nil Then
  Begin
    frmBaixaOrdProdIndustrial.pInicializaOnShowDaTela;
    objOrdPro:= frmBaixaOrdProdIndustrial.objOrdPro;
  End;

  objOrdPro.First;
  While Not objOrdPro.Eof Do
  Begin
    cdsValidacaoLote.Filter := 'CODORD = ' + QuotedStr(cdsOrdProInd.FieldByName('ORD_CODORD').AsString) +
                               ' AND DTACAD = ' + QuotedStr(cdsOrdProInd.FieldByName('ORD_DTACAD').AsString);
    cdsValidacaoLote.Filtered := True;

    If Not(cdsValidacaoLote.Locate('CODITE', objOrdPro.FieldByName('ORD_CODITE').AsString, [])) Then
      cdsValidacaoLote.Append
    Else
      cdsValidacaoLote.Edit;

    cdsValidacaoLote.FieldByName('CODITE').AsString:= objOrdPro.FieldByName('ORD_CODITE').AsString;
    cdsValidacaoLote.FieldByName('NUMLOT').AsString:= objOrdPro.FieldByName('NUMLOT').AsString;
    cdsValidacaoLote.FieldByName('QTDENV').AsFloat := objOrdPro.FieldByName('ORD_QTDENV').AsFloat;
    cdsValidacaoLote.FieldByName('CODORD').AsString:= objOrdPro.FieldByName('ORD_CODORD').AsString;
    cdsValidacaoLote.FieldByName('DTACAD').AsString:= objOrdPro.FieldByName('ORD_DTACAD').AsString;

    cdsValidacaoLote.Post;

    blnQuantidadeAProduzirDivergenteQuantidadeEnvasada:= (objOrdPro.FieldByName('ORD_QTDPRO').AsFloat > 0) And
                                                         (objOrdPro.FieldByName('ORD_QTDPRO').AsFloat <> objOrdPro.FieldByName('ORD_QTDENV').AsFloat);

    cdsOrdProInd.Edit;

    If blnQuantidadeAProduzirDivergenteQuantidadeEnvasada Then
    Begin
      cdsOrdProInd.FieldByName('EXTDIV').AsString := 'S';  //Existe divergencia de quantidade
    End
    Else
    Begin
      If cdsOrdProInd.FieldByName('EXTDIV').AsString = 'S' Then
        cdsOrdProInd.FieldByName('EXTDIV').AsString := 'N'; //Não Existe divergencia de quantidade
    End;

    If objOrdPro.FieldByName('ORD_QTDENV').AsFloat > 0 Then
      cdsOrdProInd.FieldByName('POSSUI_LOT').AsString:= IIF(fEmptyStr(objOrdPro.FieldByName('NUMLOT').AsString), 'N', 'S');


    cdsOrdProInd.Post;

    cdsValidacaoLote.Filtered := False;
    objOrdPro.Next;
  End;
End;

procedure TfrmBaixaOrdProdGeralIndustrial.pVerificaSeExisteLoteEmTodosProdutosAcabadoAProduzir(blnVerificaLoteOpiEspecifico: Boolean = False; objOrdPro: TOrdProIndustrial = Nil);
Var
  frmBaixaOrdProdIndustrial: TfrmBaixaOrdProdIndustrial;
  blnPossuiNumeroLote: Boolean;
  blnQuantidadeAProduzirDivergenteQuantidadeEnvasada: Boolean;
begin
  pCriarFormularios(TfrmBaixaOrdProdIndustrial, frmBaixaOrdProdIndustrial);

  If Not blnVerificaLoteOpiEspecifico Then
  Begin
    pVerificaLoteOpiNaoEspecifico(frmBaixaOrdProdIndustrial, objOrdPro, blnQuantidadeAProduzirDivergenteQuantidadeEnvasada);
  End
  Else
  Begin

    objOrdPro.First;

    cdsValidacaoLote.Filter := 'CODORD = ' + QuotedStr(cdsOrdProInd.FieldByName('ORD_CODORD').AsString) +
                               ' AND DTACAD = ' + QuotedStr(cdsOrdProInd.FieldByName('ORD_DTACAD').AsString);
    cdsValidacaoLote.Filtered := True;

    cdsOrdProInd.Edit;
    cdsOrdProInd.FieldByName('ORD_QTDENV').AsFloat:= 0;
    cdsOrdProInd.Post;

    While Not objOrdPro.Eof Do
    Begin

       blnQuantidadeAProduzirDivergenteQuantidadeEnvasada:= (objOrdPro.FieldByName('ORD_QTDPRO').AsFloat > 0) And
                                                            (objOrdPro.FieldByName('ORD_QTDPRO').AsFloat <> objOrdPro.FieldByName('ORD_QTDENV').AsFloat);

       blnPossuiNumeroLote:= True;
       If (objOrdPro.FieldByName('ORD_QTDPRO').AsFloat > 0) And (fUsaRotinaWMS) Then
         blnPossuiNumeroLote:= (objOrdPro.FieldByName('ORD_QTDENV').AsFloat > 0) And
                               (Not (fEmptyStr(objOrdPro.FieldByName('NUMLOT').AsString)));

      If Not(cdsValidacaoLote.Locate('CODITE', objOrdPro.FieldByName('ORD_CODITE').AsString, [])) Then
        cdsValidacaoLote.Append
      Else
        cdsValidacaoLote.Edit;

      cdsValidacaoLote.FieldByName('CODITE').AsString:= objOrdPro.FieldByName('ORD_CODITE').AsString;
      cdsValidacaoLote.FieldByName('NUMLOT').AsString:= objOrdPro.FieldByName('NUMLOT').AsString;
      cdsValidacaoLote.FieldByName('QTDENV').AsFloat := objOrdPro.FieldByName('ORD_QTDENV').AsFloat;
      cdsValidacaoLote.FieldByName('CODORD').AsString:= objOrdPro.FieldByName('ORD_CODORD').AsString;
      cdsValidacaoLote.FieldByName('DTACAD').AsString:= objOrdPro.FieldByName('ORD_DTACAD').AsString;

      cdsValidacaoLote.FieldByName('POSSUI_LOT').AsString:= IIf(blnPossuiNumeroLote, 'S', 'N'); // Sim possui lote

      cdsValidacaoLote.FieldByName('EXTDIV').AsString := IIf(blnQuantidadeAProduzirDivergenteQuantidadeEnvasada, 'S', 'N');  //Existe divergencia de quantidade

      cdsValidacaoLote.Post;

      cdsOrdProInd.Edit;
      cdsOrdProInd.FieldByName('ORD_QTDENV').AsFloat:= cdsOrdProInd.FieldByName('ORD_QTDENV').AsFloat + objOrdPro.FieldByName('ORD_QTDENV').AsFloat;
      cdsOrdProInd.Post;

      objOrdPro.Next;
    End;

    If cdsValidacaoLote.Locate('POSSUI_LOT', 'N', []) Then
    Begin
      cdsOrdProInd.Edit;
      cdsOrdProInd.FieldByName('POSSUI_LOT').AsString:= 'N';  // Não possui lote
      cdsOrdProInd.Post;
    End
    Else
    Begin
      cdsOrdProInd.Edit;
      cdsOrdProInd.FieldByName('POSSUI_LOT').AsString:= 'S';  // Sim possui lote
      cdsOrdProInd.Post;
    End;


    If Not(cdsValidacaoLote.Locate('EXTDIV', 'S', [])) Then
    Begin
      cdsOrdProInd.Edit;
      cdsOrdProInd.FieldByName('EXTDIV').AsString := 'N'; //Existe divergencia de quantidade
      cdsOrdProInd.Post;
    End;

  End;

  pFreeAndNil(frmBaixaOrdProdIndustrial);
  cdsValidacaoLote.Filtered := False;

end;

function TfrmBaixaOrdProdGeralIndustrial.fValidaCamposGrid:Boolean;
Begin

  Result:= True;

  cdsOrdProInd.First;
  While Not cdsOrdProInd.Eof Do
  Begin
    If cdsOrdProIndMARDES.AsString = 'M' Then
    Begin

      If fCfgSis('ARMAMO', varBoolean) Then
      Begin
        If fEmptyStr(cdsOrdProInd.FieldByName('ORD_LOCALI').AsString) Then
        Begin
          pMensagemOk('Informe a Localização para a OPI selecionada!');
          Result:= False;
          Break;
        End;
      End;

      If fCfgSis('VALIND', varBoolean) Then
      Begin
        If fEmptyStr(cdsOrdProInd.FieldByName('ORD_DTAVAL').AsString) Then
        Begin
          pMensagemOk('Informe a Data de Validade para a OPI selecionada!');
          Result:= False;
          Break;
        End;
      End;

      If fCfgSis('CONTMP', varBoolean) Then
      Begin

        If fEmptyStr(cdsOrdProInd.FieldByName('ORD_DTAINI').AsString) Then
        Begin
          pMensagemOk('Informe a Data Inicial da Produção para a OPI selecionada!');
          Result:= False;
          Break;
        End;

        If fEmptyStr(cdsOrdProInd.FieldByName('ORD_HORINI').AsString) Then
        Begin
          pMensagemOk('Informe a Hora Inicial da Produção para a OPI selecionada!');
          Result:= False;
          Break;
        End;

        If fEmptyStr(cdsOrdProInd.FieldByName('ORD_DTAFIN').AsString) Then
        Begin
          pMensagemOk('Informe a Data Final da Produção para a OPI selecionada!');
          Result:= False;
          Break;
        End;

        If fEmptyStr(cdsOrdProInd.FieldByName('ORD_HORFIN').AsString) Then
        Begin
          pMensagemOk('Informe a Hora Final da Produção para a OPI selecionada!');
          Result:= False;
          Break;
        End;

      End;

    End;
    cdsOrdProInd.Next;

  End;
End;

procedure TfrmBaixaOrdProdGeralIndustrial.LocalizacaoRapidoExecute(
  Sender: TObject);
  Var
    arrSel: TConsultasArray;
    chrKey   : Char;
    qryConsu: TUniQuery;
begin

  qryConsu := fCriaQuery(Self);
  Try
    chrKey := '/';

    If fEntraCons(chrKey) And fPesqLocFisAmostraProducao(Self, Nil, Nil, qryConsu, chrKey, arrSel) Then
    Begin
      If cdsOrdProInd.State <> dsEdit Then
        cdsOrdProInd.Edit;

      cdsOrdProInd.FieldByName('ORD_LOCALI').AsString := fTrimAll(qryConsu.FieldByName('LOP_LOCFIS').AsString);
      cdsOrdProInd.FieldByName('MARDES').AsString:= 'M';

      cdsOrdProInd.Post;

      cxgOrdProTable.NavigatorButtons.Next.Click;
    End;

  Finally
    FreeAndNil(qryConsu);
  End;
end;

procedure TfrmBaixaOrdProdGeralIndustrial.mskDtaBaiKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If Key = #13 Then
  Begin
    If cdsOrdProInd.IsEmpty Then
      pAbreConsulta;
  End;

end;

Class function TfrmBaixaOrdProdGeralIndustrial.fArquivoParaString(strNomArq: String): String;
  Var
    stlArq: TStringList;
begin
  Try
    stlArq := TStringList.Create;
    stlArq.LoadFromFile(strNomArq);
    Result := stlArq.Text;
  Except
    Result := '';
  End;

  FreeAndNil(stlArq);
end;


Class function TfrmBaixaOrdProdGeralIndustrial.fEscreverNoArquivo(strNomArq, strTexto: String): Boolean;
  Var
    Arquivo: TextFile;
begin
  Result := True;

  Try

    If Not FileExists(strNomArq) Then
    Begin
      Result := False;
    End
    Else
    Begin
      AssignFile(Arquivo, strNomArq);
      Rewrite(Arquivo);
      Write(Arquivo, strTexto);
    End;

  Finally
    CloseFile(Arquivo);
  End;
end;


Class function TfrmBaixaOrdProdGeralIndustrial.fGetPathTempOpcoesLocais: String;
  Var
    Buffer: Array[0..254] Of Char;
    strPatIni: String;
    iniArqIni : TIniFile;
begin
  Result := '';
  GetWindowsDirectory(Buffer, 255);
  strPatIni := StrPas(Buffer) + '\OPCOES_LOCAIS.INI';

  If FileExists(strPatIni) Then
  Begin
    iniArqIni := TIniFile.Create(strPatIni);
    Try
      Result := iniArqIni.ReadString('ARQUIVOS_TEMPORARIOS', 'PATH' , Result)
    Finally
      iniArqIni.Free;
    End;
  End;
end;

class function TfrmBaixaOrdProdGeralIndustrial.GetSpecialFolderPath(Folder: Integer; CanCreate: Boolean): String;
  Var
    FilePath: array [0..255] of Char;
Begin
  SHGetSpecialFolderPath(0, @FilePath[0], FOLDER, CanCreate);
  Result := FilePath;
End;


Class function TfrmBaixaOrdProdGeralIndustrial.fCriarArquivoTemporario(strNomArq: String = ''; strPathTmp: String = ''): String;
  Var
    Caminho  : PChar;
    Arquivo  : file;
    strDirVal: String;


begin
  Result := '';

  Try
    If fEmptyStr(strPathTmp) Then
    Begin
      strDirVal := GetSpecialFolderPath(CSIDL_APPDATA, False) + '\Autcom\';

      If Not DirectoryExists(strDirVal) Then
        CreateDir(strDirVal);

      Caminho := PChar(strDirVal);
    End
    Else
      Caminho := PChar(strPathTmp);

    If fEmptyStr(strNomArq) Then
    Begin
      Result := Caminho + IntToStr(RandomRange(0, 99999));

      While FileExists(Result) Do
      Begin
        Result := Caminho + IntToStr(RandomRange(0, 99999));
      End;
    End
    Else
    Begin
      Result := Caminho + strNomArq;
    End;

    AssignFile(Arquivo, Result);
    Rewrite(Arquivo);

  Finally
    CloseFile(Arquivo);
  End;
end;

procedure TfrmBaixaOrdProdGeralIndustrial.pCarregaConfiguracoes(frmBaixaOrdProdGeralIndustrial: TForm);
  Var
    qryCfgPdc: TUniQuery;
    strArqTemp: String;
    stlCfgFrm: TStringList;

begin
  qryCfgPdc := fCriaQuery;

  qryCfgPdc.SQL.Clear;
  qryCfgPdc.SQL.Add('SELECT * FROM CFGPDC');
  qryCfgPdc.SQL.Add('WHERE CFG_CODOPE = :CODOPE');
  qryCfgPdc.SQL.Add('  AND IFNULL(CFG_NOMGRI, "") =  "Baixa de OPI - Geral" ');

  qryCfgPdc.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;

  qryCfgPdc.Open;

  If Not qryCfgPdc.IsEmpty Then
  Begin
    stlCfgFrm := TStringList.Create;

    strArqTemp := fCriarArquivoTemporario('', fGetPathTempOpcoesLocais);

    If fEscreverNoArquivo(strArqTemp, qryCfgPdc.FieldByName('CFG_CFGGRI').AsString) Then
    Begin
      Try
         TfrmBaixaOrdProdGeralIndustrial(frmBaixaOrdProdGeralIndustrial).cxgOrdProTable.RestoreFromIniFile(strArqTemp);
      Except
      End;
      TfrmBaixaOrdProdGeralIndustrial(frmBaixaOrdProdGeralIndustrial).pCarregaArrCampos;
      DeleteFile(PChar(strArqTemp));
    End;

    stlCfgFrm.Text := qryCfgPdc.FieldByName('CFG_CFGFRM').AsString;

    If stlCfgFrm.Count > 0 Then
      recDimFrm.wrdHeight := StrToIntDef(stlCfgFrm[0], 800);

    If stlCfgFrm.Count > 1 Then
      recDimFrm.wrdWidth := StrToIntDef(stlCfgFrm[1], 1280);

    If stlCfgFrm.Count > 2 Then
      recDimFrm.blnMaxim := StrToIntDef(stlCfgFrm[2], 0) = 1;

    FreeAndNil(stlCfgFrm);
  End;



  FreeAndNil(qryCfgPdc);

end;

procedure TfrmBaixaOrdProdGeralIndustrial.pSalvaConfiguracoes(frmBaixaOrdProdGeralIndustrial: TForm);
  Var
    qryCfgPdc: TUniQuery;
    strArqTemp: String;
    stlCfgFrm: TStringList;
Begin
  If Not Assigned(frmBaixaOrdProdGeralIndustrial) Then
    Exit;


    stlCfgFrm := TStringList.Create;
    stlCfgFrm.Add(IntToStr(recDimFrm.wrdHeight));
    stlCfgFrm.Add(IntToStr(recDimFrm.wrdWidth));

    If recDimFrm.blnMaxim Then
      stlCfgFrm.Add('1')
    Else
      stlCfgFrm.Add('0');

    strArqTemp := fCriarArquivoTemporario('',fGetPathTempOpcoesLocais);
    cxgOrdProTable.StoreToIniFile(strArqTemp, True, [gsoUseFilter, gsoUseSummary]);

    qryCfgPdc := fCriaQuery;

      qryCfgPdc.SQL.Clear;
      qryCfgPdc.SQL.Add('SELECT * FROM CFGPDC');
      qryCfgPdc.SQL.Add('WHERE CFG_CODOPE = :CODOPE');
      qryCfgPdc.SQL.Add('  AND IFNULL(CFG_NOMGRI, "") =  "Baixa de OPI - Geral" ');

      qryCfgPdc.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;

      qryCfgPdc.Open;

      If qryCfgPdc.IsEmpty Then
      Begin
        qryCfgPdc.Insert;
        qryCfgPdc.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CFGPDC', VS_strCodEmp);
      End Else
      Begin
        qryCfgPdc.Edit;
      End;

      qryCfgPdc.FieldByName('CFG_CFGGRI').AsString := fArquivoParaString(strArqTemp);
      qryCfgPdc.FieldByName('CFG_CFGFRM').AsString := stlCfgFrm.Text;
      qryCfgPdc.FieldByName('CFG_CODOPE').AsString := strLoginUsuarioLogado;
      qryCfgPdc.FieldByName('CFG_NOMGRI').AsString := 'Baixa de OPI - Geral';

      qryCfgPdc.Post;

      DeleteFile(PChar(strArqTemp));


    FreeAndNil(qryCfgPdc);
    FreeAndNil(stlCfgFrm);

end;

procedure TfrmBaixaOrdProdGeralIndustrial.btnCfgGriClick(Sender: TObject);
var arrColunasWidth: TColunasWidth;
    i: integer;
begin
  inherited;
  SetLength(arrColunasWidth, cxgOrdProTable.ColumnCount);
  for i := 0 To cxgOrdProTable.ColumnCount -1 do
  Begin
    arrColunasWidth[i] := cxgOrdProTable.Columns[i].Width;
  End;


  objCfgGri := TCfgGrid.Create(Self, cxgOrdProTable, 'Baixa de OPI - Geral', arrColunasWidth, strLoginUsuarioLogado, True, False, ArrCampoBloqueado);
  Try
    objCfgGri.pConfiguraColunas;

    pCarregaArrCampos;

  Finally
    FreeAndNil(objCfgGri);
  End;

  cxgOrdProTableLOCALI.Visible:= fCfgSis('ARMAMO', varBoolean);
  cxgOrdProTableDTAVAL.Visible:= fCfgSis('VALIND', varBoolean);
  cxgOrdProTableDTAINI.Visible:= fCfgSis('CONTMP', varBoolean);
  cxgOrdProTableHORINI.Visible:= fCfgSis('CONTMP', varBoolean);
  cxgOrdProTableDTAFIN.Visible:= fCfgSis('CONTMP', varBoolean);
  cxgOrdProTableHORFIN.Visible:= fCfgSis('CONTMP', varBoolean);

end;

procedure TfrmBaixaOrdProdGeralIndustrial.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmBaixaOrdProdGeralIndustrial.pCarregaArrCampos;
  var
    i : integer;
begin
  SetLength(ArrCamposCfg, 0);
  If Assigned(Self) Then
  begin

    for i := 0 to Self.cxgOrdProTable.ColumnCount -1 do
    Begin
      if Self.cxgOrdProTable.Columns[i] is TcxGridDBColumn then
      begin
        SetLength(ArrCamposCfg, Length(ArrCamposCfg) + 1);
        ArrCamposCfg[i].ComponentName := TcxGridDBColumn(Self.cxgOrdProTable.Columns[i]).Name;
        ArrCamposCfg[i].Visible       := TcxGridDBColumn(Self.cxgOrdProTable.Columns[i]).Visible;
        ArrCamposCfg[i].Width         := TcxGridDBColumn(Self.cxgOrdProTable.Columns[i]).Width;
        ArrCamposCfg[i].BandIndex     := TcxGridDBColumn(Self.cxgOrdProTable.Columns[i]).Index;
      End;
    End;
  End;
end;

function TfrmBaixaOrdProdGeralIndustrial.fOpiJaBaixada(strCodOrd, strDtaCad: String): Boolean;
Var
  qryBuscaOPI: TUniQuery;
Begin
  qryBuscaOPI:= fCriaQuery();
  Try

    qryBuscaOPI.Close;
    qryBuscaOPI.SQL.Clear;
    qryBuscaOPI.SQL.Add('SELECT * FROM ORDGER WHERE ORD_CODORD = :CODORD AND '+
                        '                           ORD_DTACAD = :DTACAD AND '+
                        '                           ORD_DTABAI IS NOT NULL AND '+
                        '                           ORD_CODEMP = :CODEMP ');
    qryBuscaOPI.ParamByName('CODORD').AsString:= strCodOrd;
    qryBuscaOPI.ParamByName('DTACAD').AsDate  := StrToDate(strDtaCad);
    qryBuscaOPI.ParamByName('CODEMP').AsString:= VS_strCodEmp;
    qryBuscaOPI.Open;

    result:= Not(qryBuscaOPI.IsEmpty);

  Finally
    FreeAndNil(qryBuscaOPI);
  End;
End;

function TfrmBaixaOrdProdGeralIndustrial.fValidacoesConfirmacao: Boolean;
begin
  Result := True;
  If fEmptyDate(mskDtaBai.Text) Then
  Begin
    pMensagemOk('Informe a Data da Baixa!');
    Exit(False);
  End;

  cdsOrdProInd.First;

  If cdsOrdProInd.IsEmpty Then
  Begin
    pMensagemOk('Selecione uma ordem de produção industrial para efetuar a baixa!');
    Exit(False);
  End;

  If Not fValidaCamposGrid Then
  Begin
    cdsOrdProInd.Filtered:= False;
    Exit(False);
  End;
End;

procedure TfrmBaixaOrdProdGeralIndustrial.pPreencheCamposPorCfg(frmBaixaOrdProdIndustrial: TfrmBaixaOrdProdIndustrial);
begin
  If fCfgSis('CONTMP', varBoolean) Then
  Begin
    frmBaixaOrdProdIndustrial.mskDtaIni.Text := cdsOrdProInd.FieldByName('ORD_DTAINI').AsString;
    frmBaixaOrdProdIndustrial.mskHorIni.Text := cdsOrdProInd.FieldByName('ORD_HORINI').AsString;
    frmBaixaOrdProdIndustrial.mskDtaFin.Text := cdsOrdProInd.FieldByName('ORD_DTAFIN').AsString;
    frmBaixaOrdProdIndustrial.mskHorFin.Text := cdsOrdProInd.FieldByName('ORD_HORFIN').AsString;
  End;

  If fCfgSis('VALIND', varBoolean) Then
    frmBaixaOrdProdIndustrial.strDataValidade:= cdsOrdProInd.FieldByName('ORD_DTAVAL').AsString;

  If fCfgSis('ARMAMO', varBoolean) Then
    frmBaixaOrdProdIndustrial.edtLocFis.Text:= cdsOrdProInd.FieldByName('ORD_LOCALI').AsString;

End;

procedure TfrmBaixaOrdProdGeralIndustrial.btnConfirmaClick(Sender: TObject);
Var
  strCodResiduo: String;
  strLoteResiduo: String;
  fltQtdResiduo: Double;
  enuTipoBaixa: TTipoBaixa;
  blnTipoBaixaJaDefinido: Boolean;
  blnBaixaRealizada: Boolean;
  blnValidacaoOK: Boolean;
  frmBaixaOrdProdIndustrial: TfrmBaixaOrdProdIndustrial;
begin
  strCodResiduo:= '';
  strLoteResiduo:= '';
  fltQtdResiduo:= 0;
  enuTipoBaixa:= tpbAcabado;
  blnTipoBaixaJaDefinido:= False;
  blnBaixaRealizada:= False;
  blnValidacaoOK:= False;
  VS_ExibirMensagemAguarde:= False;

  If Not fValidacoesConfirmacao Then
    Exit;

  cdsOrdProInd.First;
  While Not cdsOrdProInd.Eof do
  Begin

    If cdsOrdProIndMARDES.AsString = 'M' Then
    Begin

      Try
        pCriarFormularios(TfrmBaixaOrdProdIndustrial, frmBaixaOrdProdIndustrial);



        frmBaixaOrdProdIndustrial.blnValidaBaixaChamadaExterna:= False;
        frmBaixaOrdProdIndustrial.strOrdProInd  := cdsOrdProInd.FieldByName('ORD_CODORD').AsString;
        frmBaixaOrdProdIndustrial.strDataCad    := cdsOrdProInd.FieldByName('ORD_DTACAD').AsString;

        blnBaixaRealizada:= (cdsOrdProInd.FieldByName('BAIXADA').AsString = 'S') Or
                            (fOpiJaBaixada(cdsOrdProInd.FieldByName('ORD_CODORD').AsString,
                                           cdsOrdProInd.FieldByName('ORD_DTACAD').AsString));
        If Not(blnBaixaRealizada) Then
        Begin

           pPreencheCamposPorCfg(frmBaixaOrdProdIndustrial);

          If (cdsOrdProInd.FieldByName('POSSUI_LOT').AsString = 'N') And (fUsaRotinaWMS)  Then
          Begin
            pMensagemOk('A Ordem de Produção '+cdsOrdProInd.FieldByName('ORD_CODORD').AsString+'-'+cdsOrdProInd.FieldByName('ORD_DTACAD').AsString+' '+
                        'não possui lote informado, por favor, ajuste para continuar!');
            Break;
          End;



          lblInformacao.Caption:= 'Baixando Ordem de Produção: '+ cdsOrdProInd.FieldByName('ORD_CODORD').AsString+'-'+cdsOrdProInd.FieldByName('ORD_DTACAD').AsString;

          frmBaixaOrdProdIndustrial.mskDtaBai.Text:= mskDtaBai.Text;

          frmBaixaOrdProdIndustrial.blnChamadaDeRotinaExterna := True;
          frmBaixaOrdProdIndustrial.blnValidaBaixaChamadaExterna:= True;
          frmBaixaOrdProdIndustrial.pInicializaOnShowDaTela;

          If Not frmBaixaOrdProdIndustrial.blnValidacaoOK Then
          Begin
            lblInformacao.Caption:= '';
            Exit;
          End;

          pCarregaQuantidadesEnvasadas(frmBaixaOrdProdIndustrial.objOrdPro);

          frmBaixaOrdProdIndustrial.blnTipoBaixaJaDefinido:= blnTipoBaixaJaDefinido;

          frmBaixaOrdProdIndustrial.strPropCodResiduo := strCodResiduo;
          frmBaixaOrdProdIndustrial.strPropLoteResiduo:= strLoteResiduo;
          frmBaixaOrdProdIndustrial.fltPropQtdResiduo := fltQtdResiduo;
          frmBaixaOrdProdIndustrial.enuPropTipoBaixa  := enuTipoBaixa;

          frmBaixaOrdProdIndustrial.btnConfirmaClick(Sender);
          blnTipoBaixaJaDefinido:= frmBaixaOrdProdIndustrial.blnTipoBaixaJaDefinido;

          If blnTipoBaixaJaDefinido Then
          Begin
            strCodResiduo          := frmBaixaOrdProdIndustrial.strPropCodResiduo;
            strLoteResiduo         := frmBaixaOrdProdIndustrial.strPropLoteResiduo;
            fltQtdResiduo          := frmBaixaOrdProdIndustrial.fltPropQtdResiduo;
            enuTipoBaixa           := frmBaixaOrdProdIndustrial.enuPropTipoBaixa;
          End;

          blnValidacaoOK:= frmBaixaOrdProdIndustrial.blnValidacaoOK;
          blnBaixaRealizada:= frmBaixaOrdProdIndustrial.blnBaixaRealizada;
          If Not(blnValidacaoOK) Or (Not (blnBaixaRealizada)) Then
          Begin
            lblInformacao.Caption:= '';
            cdsOrdProInd.Edit;
            cdsOrdProInd.FieldByName('BAIXADA').AsString:= 'N';
            cdsOrdProInd.Post;
            Break;
          End
          Else
          Begin
            cdsOrdProInd.Edit;
            cdsOrdProInd.FieldByName('BAIXADA').AsString:= 'S';
            cdsOrdProInd.Post;
          End;
        End

      Except
        On E: Exception Do
          pMensagensErro(E.Message, '');
      End;

      pFreeAndNil(frmBaixaOrdProdIndustrial);

      lblInformacao.Caption:= '';

    End;

    cdsOrdProInd.Next;

  End;

  If (blnValidacaoOK) And (blnBaixaRealizada) Then
  Begin
    cdsValidacaoLote.EmptyDataSet;
    cdsOrdProInd.EmptyDataSet;
    cdsOrdProInd.Filtered:= False;
    lblInformacao.Caption:= '';

    strCodResiduo          := '';
    strLoteResiduo         := '';

    pMensagemOk('Baixa de Ordens de Produção Industrial realizada com sucesso!');

  End;

end;

procedure TfrmBaixaOrdProdGeralIndustrial.btnMarcaItemClick(Sender: TObject);
begin
  pMarcaDesmarcaOPI;
end;

procedure TfrmBaixaOrdProdGeralIndustrial.pMarcaDesmarcaOPI;
Begin

  If cdsOrdProInd.IsEmpty Then
    Exit;

  cdsOrdProInd.Edit;

  If cdsOrdProInd.FieldByName('MARDES').AsString = 'D' Then
    cdsOrdProInd.FieldByName('MARDES').AsString:= 'M'
  Else
    cdsOrdProInd.FieldByName('MARDES').AsString:= 'D';

  cdsOrdProInd.Post;

  If cdsOrdProInd.FieldByName('MARDES').AsString = 'M' Then
    pTrabalhaFocuDoCampoNaGrid;

End;

procedure TfrmBaixaOrdProdGeralIndustrial.btnMarcaTodosClick(Sender: TObject);
begin

  If cdsOrdProInd.IsEmpty Then
    Exit;

  cdsOrdProInd.First;
  While Not cdsOrdProInd.Eof do
  Begin
    cdsOrdProInd.Edit;

    If cdsOrdProInd.FieldByName('MARDES').AsString = 'D' Then
      cdsOrdProInd.FieldByName('MARDES').AsString:= 'M'
    Else
      cdsOrdProInd.FieldByName('MARDES').AsString:= 'D';

    cdsOrdProInd.Post;

    cdsOrdProInd.Next;
  End;

end;

procedure TfrmBaixaOrdProdGeralIndustrial.btnPreencheQtdEnvasadaClick(
  Sender: TObject);
Var
  frmBaixaOrdProdIndustrial: TfrmBaixaOrdProdIndustrial;
  blnBaixaRealizada: Boolean;
begin


  If fPergunta('A Quantidade Envasada de todos os produtos das OPIs selecionadas'+
                 ' serão alteradas com a mesma Quantidade Solicitada. Confirma?') Then
  Begin

    If cdsOrdProInd.IsEmpty Then
    Begin
      pMensagemOk('Selecione uma ordem de produção industrial para efetuar a baixa!');
      cdsOrdProInd.Filtered:= False;
      Exit;
    End;

    VS_ExibirMensagemAguarde:= False;

    cdsOrdProInd.First;
    While not cdsOrdProInd.Eof do
    Begin
      pCriarFormularios(TfrmBaixaOrdProdIndustrial, frmBaixaOrdProdIndustrial);
      Try
        If cdsOrdProIndMARDES.AsString = 'M' Then
        Begin
          blnBaixaRealizada:= (cdsOrdProInd.FieldByName('BAIXADA').AsString = 'S') Or
                              (fOpiJaBaixada(cdsOrdProInd.FieldByName('ORD_CODORD').AsString,
                                             cdsOrdProInd.FieldByName('ORD_DTACAD').AsString));
          If Not(blnBaixaRealizada) Then
          Begin

            frmBaixaOrdProdIndustrial.strOrdProInd  := cdsOrdProInd.FieldByName('ORD_CODORD').AsString;
            frmBaixaOrdProdIndustrial.strDataCad    := cdsOrdProInd.FieldByName('ORD_DTACAD').AsString;

            frmBaixaOrdProdIndustrial.blnChamadaDeRotinaExterna := True;

            frmBaixaOrdProdIndustrial.pInicializaOnShowDaTela;

            cdsValidacaoLote.Filter := 'CODORD = ' + QuotedStr(cdsOrdProInd.FieldByName('ORD_CODORD').AsString) +
                                       ' AND DTACAD = ' + QuotedStr(cdsOrdProInd.FieldByName('ORD_DTACAD').AsString);
            cdsValidacaoLote.Filtered := True;

            cdsOrdProInd.Edit;
            cdsOrdProInd.FieldByName('ORD_QTDENV').AsFloat:= 0;
            cdsOrdProInd.Post;

            frmBaixaOrdProdIndustrial.objOrdPro.First;
            While Not frmBaixaOrdProdIndustrial.objOrdPro.Eof Do
            Begin
              frmBaixaOrdProdIndustrial.objOrdPro.Edit;
              frmBaixaOrdProdIndustrial.objOrdPro.FieldByName('ORD_QTDENV').AsString:= frmBaixaOrdProdIndustrial.objOrdPro.FieldByName('ORD_QTDPRO').AsString;
              frmBaixaOrdProdIndustrial.objOrdPro.Post;

              cdsOrdProInd.Edit;
              cdsOrdProInd.FieldByName('ORD_QTDENV').AsFloat:= cdsOrdProInd.FieldByName('ORD_QTDENV').AsFloat + cdsOrdProInd.FieldByName('ORD_QTDPRO').AsFloat;
              cdsOrdProInd.Post;

              If Not(cdsValidacaoLote.Locate('CODITE', frmBaixaOrdProdIndustrial.objOrdPro.FieldByName('ORD_CODITE').AsString, [])) Then
                cdsValidacaoLote.Append
              Else
                cdsValidacaoLote.Edit;

              cdsValidacaoLote.FieldByName('CODITE').AsString:= frmBaixaOrdProdIndustrial.objOrdPro.FieldByName('ORD_CODITE').AsString;
              cdsValidacaoLote.FieldByName('QTDENV').AsFloat := frmBaixaOrdProdIndustrial.objOrdPro.FieldByName('ORD_QTDENV').AsFloat;

              If cdsValidacaoLote.FieldByName('QTDENV').AsFloat <> frmBaixaOrdProdIndustrial.objOrdPro.FieldByName('ORD_QTDENV').AsFloat Then
                cdsValidacaoLote.FieldByName('EXTDIV').AsString := 'S'  //Existe divergencia de quantidade
              Else
                cdsValidacaoLote.FieldByName('EXTDIV').AsString := 'N'; //Não Existe divergencia de quantidade

              cdsValidacaoLote.Post;

              frmBaixaOrdProdIndustrial.objOrdPro.Next;

              If Not(cdsValidacaoLote.Locate('EXTDIV', 'S', [])) Then
              Begin
                cdsOrdProInd.Edit;
                cdsOrdProInd.FieldByName('EXTDIV').AsString := 'N'; //Existe divergencia de quantidade
                cdsOrdProInd.Post;
              End;

            End;
          End;
       End;
       cdsOrdProInd.Next;
      Finally
        pFreeAndNil(frmBaixaOrdProdIndustrial);
        cdsValidacaoLote.Filtered := False;
      End;
    End;
    pMensagemOk('A Quantidade Envasada de todos os produtos das OPIs selecionadas foram preechidos com sucesso!');
  End;

  cdsValidacaoLote.Filtered := False;
  cdsOrdProInd.First;

end;

procedure TfrmBaixaOrdProdGeralIndustrial.btnSairClick(Sender: TObject);
begin
  //inherited;
  Close;
end;

procedure TfrmBaixaOrdProdGeralIndustrial.btnValidaLoteDosAcabadosClick(
  Sender: TObject);
  var
    blnBaixaRealizada: Boolean;
begin

  If cdsOrdProInd.IsEmpty Then
  Begin
    pMensagemOk('Selecione uma ordem de produção industrial para efetuar a validação do lote!');
    Exit;
  End;

  If Not(cdsOrdProInd.Locate('MARDES', 'M', [])) Then
  Begin
    pMensagemOk('Selecione uma ordem de produção industrial para efetuar a validação do lote!');
    Exit;
  End;


  VS_ExibirMensagemAguarde:= False;

  lblInformacao.Caption := 'Aguarde, verificando produtos acabados sem lote...';

  Application.ProcessMessages;

  cdsOrdProInd.First;
  pDisableControls(cdsOrdProInd, prcScroll);

  While Not cdsOrdProInd.Eof Do
  Begin

    If cdsOrdProIndMARDES.AsString = 'M' Then
    Begin
      blnBaixaRealizada:= (cdsOrdProInd.FieldByName('BAIXADA').AsString = 'S') Or
                          (fOpiJaBaixada(cdsOrdProInd.FieldByName('ORD_CODORD').AsString,
                                         cdsOrdProInd.FieldByName('ORD_DTACAD').AsString));
      If Not(blnBaixaRealizada) Then
        pVerificaSeExisteLoteEmTodosProdutosAcabadoAProduzir;
    End;
    cdsOrdProInd.Next;

  End;

  pEnableControls(cdsOrdProInd, prcScroll);

  lblInformacao.Caption := '';
  Application.ProcessMessages;
end;

procedure TfrmBaixaOrdProdGeralIndustrial.cdsOrdProIndBeforePost(
  DataSet: TDataSet);
begin
  inherited;
  If cxgOrdProTableLOCALI.Visible Then
  Begin

    If Not (fEmptyStr(cdsOrdProInd.FieldByName('ORD_LOCALI').AsString)) Then
    Begin

      cdsOrdProInd.FieldByName('ORD_LOCALI').AsString:= fTrimAll(cdsOrdProInd.FieldByName('ORD_LOCALI').AsString);

      If fEmptyStr(fRetNomeLocFisAmostraProducao(cdsOrdProInd.FieldByName('ORD_LOCALI').AsString)) Then
      Begin
        fMensagem('','A localização física da amostra não existe!', ['&OK']);
        cdsOrdProInd.Cancel;
      End;

    End
    Else
      If cdsOrdProInd.FieldByName('MARDES').AsString = 'M' Then
          cdsOrdProInd.FieldByName('MARDES').AsString := 'D';

  End;
end;

procedure TfrmBaixaOrdProdGeralIndustrial.cxgOrdProTableCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,cxgOrdProTableMARDES.Index]) = 'M' Then
    ACanvas.Font.Color := clBlue;

  If fUsaRotinaWMS Then
  Begin

    If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,cxgOrdProTablePOSSUI_LOT.Index]) = 'N' Then // Não possui lote
    Begin
      ACanvas.Brush.Color := $000080FF;

      If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,cxgOrdProTableMARDES.Index]) = 'M' Then
        ACanvas.Font.Color := clBlue
      Else
        ACanvas.Font.Color := clBlack;

      Exit;
    End
    Else
    If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,cxgOrdProTableEXTDIV.Index]) = 'S' Then //Existe divergencia de quantidade
    Begin
      ACanvas.Brush.Color := clYellow;

      If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,cxgOrdProTableMARDES.Index]) = 'M' Then
        ACanvas.Font.Color := clBlue
      Else
        ACanvas.Font.Color := clBlack;

      Exit;
    End
    Else
    Begin
      ACanvas.Brush.Color := clWindow;
      If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,cxgOrdProTableMARDES.Index]) = 'M' Then
        ACanvas.Font.Color := clBlue
      Else
        ACanvas.Font.Color := clBlack;
      Exit;
    End;

  End
  Else
  Begin

    If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,cxgOrdProTableEXTDIV.Index]) = 'S' Then //Existe divergencia de quantidade
    Begin
      ACanvas.Brush.Color := clYellow;

      If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,cxgOrdProTableMARDES.Index]) = 'M' Then
        ACanvas.Font.Color := clBlue
      Else
        ACanvas.Font.Color := clBlack;

      Exit;
    End
    Else
    Begin
      ACanvas.Brush.Color := clWindow;

      If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,cxgOrdProTableMARDES.Index]) = 'M' Then
        ACanvas.Font.Color := clBlue
      Else
        ACanvas.Font.Color := clBlack;

      Exit;
    End;

  End;


end;

procedure TfrmBaixaOrdProdGeralIndustrial.cxgOrdProTableDblClick(
  Sender: TObject);
begin
  inherited;
  pMarcaDesmarcaOPI;
end;

procedure TfrmBaixaOrdProdGeralIndustrial.cxgOrdProTableLOCALIPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  inherited;
  If fEmptyStr(DisplayValue) Then
    Exit;

  If fEmptyStr(fRetNomeLocFisAmostraProducao(fTrimAll(DisplayValue))) Then
  Begin
    fMensagem('','A localização física da amostra não existe!', ['&OK']);
    cdsOrdProInd.Cancel;
  End
  Else
    cdsOrdProInd.FieldByName('MARDES').AsString:= 'M'

end;

procedure TfrmBaixaOrdProdGeralIndustrial.dtsOrdProIndStateChange(
  Sender: TObject);
begin
  inherited;
  If Not(cdsOrdProInd.State In [dsEdit]) Then
  Begin
    cdsOrdProInd.Edit;
  End;
end;

procedure TfrmBaixaOrdProdGeralIndustrial.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  If fMensagem('ATENÇÃO!', 'Deseja realmente sair?', ['&Sim', '&Não'], 2) = 2 Then
  Begin
    Action := CaNone;
    Exit;
  End
  Else
  Begin
    pSalvaConfiguracoes(frmBaixaOrdProdGeralIndustrial);
    inherited;
  End;
end;

procedure TfrmBaixaOrdProdGeralIndustrial.FormCreate(Sender: TObject);
var arrColunasWidth: TColunasWidth;
begin
  inherited;
  pCarregaConfiguracoes(frmBaixaOrdProdGeralIndustrial);

  objCfgGri := TCfgGrid.Create(Self, cxgOrdProTable, 'Baixa de OPI - Geral', arrColunasWidth, strLoginUsuarioLogado, True, False, ArrCampoBloqueado);
  Try

    pCarregaArrCampos;

  Finally
    FreeAndNil(objCfgGri);
  End;

  pCriaDataSetValidacaoLote;

  cxgOrdProTableLOCALI.Visible:= fCfgSis('ARMAMO', varBoolean);
  cxgOrdProTableDTAVAL.Visible:= fCfgSis('VALIND', varBoolean);
  cxgOrdProTableDTAINI.Visible:= fCfgSis('CONTMP', varBoolean);
  cxgOrdProTableHORINI.Visible:= fCfgSis('CONTMP', varBoolean);
  cxgOrdProTableDTAFIN.Visible:= fCfgSis('CONTMP', varBoolean);
  cxgOrdProTableHORFIN.Visible:= fCfgSis('CONTMP', varBoolean);

  blnPerOsa := fCfgSis('PEROSA', varBoolean);
end;

procedure TfrmBaixaOrdProdGeralIndustrial.ProcessaKeyDown(ABlnDesmarcando:Boolean = False);
var frmBaixaOrdProdIndustrial: TfrmBaixaOrdProdIndustrial;
    frmAjustaDadosProdutoAcabado: TfrmAjustaDadosProdutoAcabado;
begin
  If (cdsOrdProInd.FieldByName('MARDES').AsString <> 'M') And (Not ABlnDesmarcando) Then
  Begin
    pMensagemOk('Selecione uma ordem de produção industrial para realizar o ajuste!');
    Exit;
  End;

  If (cdsOrdProInd.FieldByName('POSSUI_LOT').AsString = 'N') Or
    ((cdsOrdProInd.FieldByName('EXTDIV').AsString = 'S') AND fCfgSis('OPCORR', varBoolean)) Then   //Existe divergencia de quantidade
  Begin

    pCriarFormularios(TfrmBaixaOrdProdIndustrial, frmBaixaOrdProdIndustrial);
    pCriarFormularios(TfrmAjustaDadosProdutoAcabado, frmAjustaDadosProdutoAcabado);

    Try

      frmBaixaOrdProdIndustrial.blnChamadaDeRotinaExterna := True;
      frmBaixaOrdProdIndustrial.strOrdProInd  := cdsOrdProInd.FieldByName('ORD_CODORD').AsString;
      frmBaixaOrdProdIndustrial.strDataCad    := cdsOrdProInd.FieldByName('ORD_DTACAD').AsString;
      frmBaixaOrdProdIndustrial.pInicializaOnShowDaTela;

      frmBaixaOrdProdIndustrial.objOrdPro.First;

      cdsValidacaoLote.Filter := 'CODORD = ' + QuotedStr(cdsOrdProInd.FieldByName('ORD_CODORD').AsString) +
                                 ' AND DTACAD = ' + QuotedStr(cdsOrdProInd.FieldByName('ORD_DTACAD').AsString);
      cdsValidacaoLote.Filtered := True;

      While Not(frmBaixaOrdProdIndustrial.objOrdPro.Eof) do
      Begin

        If cdsValidacaoLote.Locate('CODITE', frmBaixaOrdProdIndustrial.objOrdPro.FieldByName('ORD_CODITE').AsString, []) Then
        Begin

          frmBaixaOrdProdIndustrial.objOrdPro.Locate('ORD_CODITE', cdsValidacaoLote.FieldByName('CODITE').AsString, []);

          frmBaixaOrdProdIndustrial.objOrdPro.Edit;
          frmBaixaOrdProdIndustrial.objOrdPro.FieldByName('ORD_CODITE').AsString := cdsValidacaoLote.FieldByName('CODITE').AsString;
          frmBaixaOrdProdIndustrial.objOrdPro.FieldByName('NUMLOT').AsString     := cdsValidacaoLote.FieldByName('NUMLOT').AsString;
          frmBaixaOrdProdIndustrial.objOrdPro.FieldByName('ORD_QTDENV').AsFloat  := cdsValidacaoLote.FieldByName('QTDENV').AsFloat;
          frmBaixaOrdProdIndustrial.objOrdPro.Post;

        End;

        frmBaixaOrdProdIndustrial.objOrdPro.Next;
      End;

      frmAjustaDadosProdutoAcabado.objOrdPro  := frmBaixaOrdProdIndustrial.objOrdPro;
      frmAjustaDadosProdutoAcabado.cxgItensView.DataController.DataSource:= frmAjustaDadosProdutoAcabado.objOrdPro.dtsSource;
      frmAjustaDadosProdutoAcabado.ShowModal;
      frmBaixaOrdProdIndustrial.objOrdPro:= frmAjustaDadosProdutoAcabado.objOrdPro;

      pVerificaSeExisteLoteEmTodosProdutosAcabadoAProduzir(True, frmBaixaOrdProdIndustrial.objOrdPro);

    Finally

      pFreeAndNil(frmBaixaOrdProdIndustrial);
      pFreeAndNil(frmAjustaDadosProdutoAcabado);
      cdsValidacaoLote.Filtered := False;

    End;
  End;
End;


procedure TfrmBaixaOrdProdGeralIndustrial.FormDestroy(Sender: TObject);
begin
  inherited;

  FreeAndNil(cdsValidacaoLote);
end;

procedure TfrmBaixaOrdProdGeralIndustrial.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  blnEstaDesmarcando: Boolean;
begin
  inherited;
  blnEstaDesmarcando := False;
  If (Key = VK_Escape) then
    btnClose.OnClick(Nil);
  If (Key = VK_F5) Or (Key = VK_SPACE) And (Not cxgOrdProTableLOCALI.Focused) then
    pMarcaDesmarcaOPI;
  If (Key = VK_F6) then
    btnMarcaTodos.OnClick(Nil);

  If (Key = VK_RETURN) then
  Begin

    If cdsOrdProInd.State In [dsEdit] Then
    Begin

      If Not cxgOrdProTableLOCALI.Focused Then
      Begin
        blnEstaDesmarcando := cdsOrdProInd.FieldByName('MARDES').AsString = 'M';
        If cdsOrdProInd.FieldByName('MARDES').AsString <> 'M' Then
        Begin
          pMensagemOk('Selecione uma ordem de produção industrial para realizar o ajuste!');
          cdsOrdProInd.CancelUpdates;
          Exit;
        End;
      End;


      cdsOrdProInd.Post;
    End;

    If fCheckParent(ActiveControl, cxgOrdPro) Then
    Begin

      processaKeyDown(blnEstaDesmarcando);

      If cxgOrdProTable.Controller.FocusedColumn = cxgOrdProTableHORFIN Then
      Begin
        cxgOrdProTable.NavigatorButtons.Next.Click;

        pTrabalhaFocuDoCampoNaGrid;
      End
      Else
        cxgOrdProTable.Controller.FocusNextCell(True)
    End;



    //btnBaixarOP.OnClick(Nil);
  End;
end;

procedure TfrmBaixaOrdProdGeralIndustrial.pTrabalhaFocuDoCampoNaGrid;
Begin

  If cxgOrdProTableLOCALI.Visible Then
  Begin
    cxgOrdProTableLOCALI.Focused:= True;
    Exit;
  End;

  If cxgOrdProTableDTAVAL.Visible Then
  Begin
    cxgOrdProTableDTAVAL.Focused:= True;
    Exit;
  End;

  If cxgOrdProTableDTAINI.Visible Then
  Begin
    cxgOrdProTableDTAINI.Focused:= True;
    Exit;
  End;

End;

procedure TfrmBaixaOrdProdGeralIndustrial.FormShow(Sender: TObject);
begin
  inherited;

  mskDtaBai.Text:= DateToStr(fNow);

  pAbreConsulta;

  pSetFocus(mskDtaBai);
end;

function TfrmBaixaOrdProdGeralIndustrial.fSqlConsulta: String;
CONST
  ORD_NUMLOT = 'CONCAT(DATE_FORMAT(ORD_DTACAD,"%d%m%y"), ORD_CODORD) AS ORD_NUMLOT, ';

  ORD_PEDIDO = '(SELECT GROUP_CONCAT(FDO_NUMDOC SEPARATOR " - ") ' +
                                                  '  FROM EXTDOR ' +
                                                  '   LEFT JOIN FATDOR ON FATDOR.AUTOINCREM = FDO_SEQFDO ' +
                                                  '  WHERE FDO_SEQOPI = O.AUTOINCREM ) AS ORD_PEDIDO,';
  NUMRES = 'CONCAT(FATGOR.FGO_NUMDOC, "-", FATGOR.FGO_ESPDOC, "-", FATGOR.FGO_CODEMP) AS NUMRES, ';
Var
  strSQL: String;

begin

  strSQL := strSQL + ' SELECT '+ORD_NUMLOT;//'Número do Lote';
  strSQL := strSQL + ' ORD_CODORD AS ORD_CODORD,                            '; //'Código da OP';
  strSQL := strSQL + ' ORD_DTACAD AS ORD_DTACAD,                            '; //'Data de Cadastro';
  strSQL := strSQL + ' O.ORD_CODITE AS ORD_CODITE,                          '; //'Cód.Item';
  strSQL := strSQL + ' G.ITE_DESITE AS ITE_DESITE,                          '; //'Descrição do Item';
  strSQL := strSQL + ' ORD_CODCOR AS ORD_CODCOR,                            '; //'Cód.Cor';
  strSQL := strSQL + ' COR_DESCOR AS COR_DESCOR,                            '; //'Descrição da Cor';
  strSQL := strSQL + ' G.ITE_REFERE AS ITE_REFERE,                          '; //'Referência';
  strSQL := strSQL + ' SUM(IF(UNI_KILLIT="K", IF(GMT_PESREA > 0, ((ORD_QTDPRO * UNI_PESLIT) / GMT_PESREA),0), ORD_QTDPRO * UNI_PESLIT )) AS VOLUME, '; //'Volume';
  strSQL := strSQL + ' SUM(IF(UNI_KILLIT="K", ORD_QTDPRO * UNI_PESLIT, ORD_QTDPRO * UNI_PESLIT * GMT_PESREA )) AS   PESTOT,                         '; //'Peso Total';
  strSQL := strSQL +   ORD_PEDIDO; //'Pedido de Venda';
  strSQL := strSQL + NUMRES; //'Pedido da Reserva Matéria Prima';
  strSQL := strSQL + ' CAST(ORD_DTAPRE AS DATE) AS ORD_DTAPRE,              '; //'Data de Previsão');
  strSQL := strSQL + ' SUM(CAST(IFNULL(ORDDET.ORD_QTDPRO, 0) AS DECIMAL(12,2))) AS ORD_QTDPRO, '; //'Quantidade Baixa'
  strSQL := strSQL + ' SUM(CAST(IFNULL(ORDDET.ORD_QTDENV, 0) AS DECIMAL(12,2))) AS ORD_QTDENV, '; //'Quantidade Envasada'
  strSQL := strSQL + ' O.AUTOINCREM,                                          ';
  strSQL := strSQL + ' "D" AS MARDES,                                         ';
  strSQL := strSQL + ' ORD_DTAVAL,                                            ';
  strSQL := strSQL + ' ORD_LOCORP AS ORD_LOCALI,                              ';
  strSQL := strSQL + ' ORD_DTAINI,                                            ';
  strSQL := strSQL + ' ORD_HORINI,                                            ';
  strSQL := strSQL + ' ORD_DTAFIN,                                            ';
  strSQL := strSQL + ' ORD_HORFIN,                                            ';
  strSQL := strSQL + ' "S" AS POSSUI_LOT,                                     ';

  {Comentado pois não é para carregar tudo amarelo ao abrir a tela so após haver manutenção}
  {If Not(fCfgSis('CONMAT', VARBOOLEAN)) Then
  Begin
    strSQL := strSQL + ' @QTDPRO:= (SELECT SUM(IFNULL(ORD_QTDPRO, 0)) FROM ORDDET WHERE ORD_SEQGER =  O.AUTOINCREM) AS TOT_QTDPRO, ';
    strSQL := strSQL + ' @QTDENV:= @QTDPRO AS TOT_QTDENV, ';
  End
  Else
  Begin
    strSQL := strSQL + ' @QTDPRO:= (SELECT SUM(IFNULL(ORD_QTDPRO, 0)) FROM ORDDET WHERE ORD_SEQGER =  O.AUTOINCREM) AS TOT_QTDPRO, ';
    strSQL := strSQL + ' @QTDENV:= (SELECT SUM(IFNULL(ORD_QTDENV, 0)) FROM ORDDET WHERE ORD_SEQGER =  O.AUTOINCREM) AS TOT_QTDENV, ';
  End;

  strSQL := strSQL + ' IF( IFNULL(@QTDPRO, 0) <> IFNULL(@QTDENV, 0), "S", "N") AS EXTDIV ';}

  If (fCfgSis('CONMAT', VarBoolean)) Then
  Begin
    strSQL := strSQL + ' @QTDPRO:= (SELECT SUM(IFNULL(ORD_QTDPRO, 0)) FROM ORDDET WHERE ORD_SEQGER =  O.AUTOINCREM) AS TOT_QTDPRO, ';

    If(fCfgSis('OIBXPA',VarBoolean)) Then
     strSQL := strSQL + ' @QTDENV:= (SELECT SUM(IFNULL(ORD_QTDENV, 0) + IFNULL(ORD_QTDCON, 0)) FROM ORDDET WHERE ORD_SEQGER =  O.AUTOINCREM) AS TOT_QTDENV, '
    Else
     strSQL := strSQL + ' @QTDENV:= (SELECT SUM(IFNULL(ORD_QTDCON, 0)) FROM ORDDET WHERE ORD_SEQGER =  O.AUTOINCREM) AS TOT_QTDENV, ';

    strSQL := strSQL + ' IF(IFNULL(@QTDPRO, 0) > 0 AND IFNULL(@QTDENV,0) > 0, IF(IFNULL(@QTDPRO, 0) <> IFNULL(@QTDENV, 0), "S", "N"), "N" ) AS EXTDIV  '
  End
  Else  
    strSQL := strSQL + ' "N" AS EXTDIV '; 

  strSQL := strSQL + 'FROM ORDGER O                                           ';
  strSQL := strSQL + 'INNER JOIN ORDDET ON ORD_SEQGER = O.AUTOINCREM          ';
  strSQL := strSQL + 'INNER JOIN CADITE G ON O.ORD_CODITE = G.ITE_CODITE      ';
  strSQL := strSQL + 'INNER JOIN CADITE D ON D.ITE_CODITE = ORDDET.ORD_CODITE ';
  strSQL := strSQL + 'LEFT  JOIN CADUNI ON UNI_CODUNI = D.ITE_CODUNI          ';
  strSQL := strSQL + 'INNER JOIN CADCOR ON ORD_CODCOR = COR_CODCOR            ';
  strSQL := strSQL + 'LEFT  JOIN GEIMAT ON GMT_CODITE = O.ORD_CODITE          ';
  strSQL := strSQL + '                 AND GMT_CODCOR = ORD_CODCOR            ';
  strSQL := strSQL + '                 AND GMT_FORMUL = ORD_FORMUL            ';

  strSQL := strSQL + ' LEFT JOIN EXTGOR ON EXTGOR.FGO_ORDIND = O.AUTOINCREM      ';
  strSQL := strSQL + ' LEFT JOIN FATGOR ON FATGOR.AUTOINCREM = EXTGOR.FGO_SEQFGO ';
  strSQL := strSQL + ' WHERE ORD_CODEMP = :CODEMP  ';
  strSQL := strSQL + ' AND ORD_DTABAI IS NULL ';
  strSQL := strSQL + ' GROUP BY O.AUTOINCREM ';
  strSQL := strSQL + ' ORDER BY ORD_DTACAD, ORD_CODORD ';

  result:= strSQL;

end;

procedure TfrmBaixaOrdProdGeralIndustrial.pAbreConsulta;
Var
  qryConsulta: TUniQuery;
begin
  btnConfirma.Enabled:= False;
  btnMarcaItem.Enabled:= False;
  btnMarcaTodos.Enabled:= False;
  btnPreencheQtdEnvasada.Enabled:= False;
  btnValidaLoteDosAcabados.Enabled:= False;

  lblInformacao.Caption := 'Aguarde, Carregando ordens de produção industrial...';
  Application.ProcessMessages;

  qryConsulta:= fCriaQuery;
  Try

    qryConsulta.Close;
    qryConsulta.SQL.text := fSqlConsulta;
    qryConsulta.ParamByName('CODEMP').AsString  := VS_strCodEmp;
    qryConsulta.Open;

    If cdsOrdProInd.Active Then
      cdsOrdProInd.Close;

    cdsOrdProIndITE_REFERE.Size := fTamRefere;
    cdsOrdProInd.Open;

    pCarregaCdsOrdProInd(qryConsulta);

    If Not blnPerOsa Then
      cdsOrdProInd.BeforePost := pBeforePost;

    cdsOrdProInd.Open;

    TStringField(cdsOrdProInd.FieldByName('ORD_CODORD')).Alignment := taCenter;
    TStringField(cdsOrdProInd.FieldByName('ORD_PEDIDO')).Alignment := taCenter;
    TStringField(cdsOrdProInd.FieldByName('ORD_NUMLOT')).Alignment := taCenter;
    TStringField(cdsOrdProInd.FieldByName('ITE_REFERE')).Alignment := taCenter;
    TStringField(cdsOrdProInd.FieldByName('ORD_PEDIDO')).Alignment := taCenter;
    TDateTimeField(cdsOrdProInd.FieldByName('ORD_DTAPRE')).Alignment := taCenter;
    TStringField(cdsOrdProInd.FieldByName('VOLUME')).Alignment := taCenter;
    TStringField(cdsOrdProInd.FieldByName('PESTOT')).Alignment := taCenter;

    TFloatField(cdsOrdProInd.FieldByName('VOLUME')).DisplayFormat := fMskDigitos( fCfgSis('DECQTD', varInteger) );
    TFloatField(cdsOrdProInd.FieldByName('PESTOT')).DisplayFormat := fMskDigitos( fCfgSis('DECQTD', varInteger) );
    TFloatField(cdsOrdProInd.FieldByName('ORD_QTDPRO')).DisplayFormat := '###,###,##0.00';
    TFloatField(cdsOrdProInd.FieldByName('ORD_QTDENV')).DisplayFormat := '###,###,##0.00';



    cxgOrdProTable.DataController.DataSource := dtsOrdProInd;
    //cxgOrdProTable.ApplyBestFit;

  Finally
    FreeAndNil(qryConsulta);
  End;

  btnConfirma.Enabled:= True;
  btnMarcaItem.Enabled:= True;
  btnMarcaTodos.Enabled:= True;
  btnPreencheQtdEnvasada.Enabled:= True;
  btnValidaLoteDosAcabados.Enabled:= True;
  lblInformacao.Caption := '';
  VS_ExibirMensagemAguarde:= True;
  Application.ProcessMessages;
  cdsOrdProInd.First;
end;

procedure TfrmBaixaOrdProdGeralIndustrial.pCarregaCdsOrdProInd(qryConsulta: TUniQuery);
Begin
  qryConsulta.First;
  while not qryConsulta.Eof do
  Begin
    cdsOrdProInd.Insert;
    cdsOrdProIndCODORD.AsString    := qryConsulta.FieldByName('ORD_CODORD').AsString;
    cdsOrdProIndORD_DTACAD.AsDateTime    := qryConsulta.FieldByName('ORD_DTACAD').AsDateTime;
    cdsOrdProIndCODITE.AsString    := qryConsulta.FieldByName('ORD_CODITE').AsString;
    cdsOrdProIndORD_NUMLOT.AsString:= qryConsulta.FieldByName('ORD_NUMLOT').AsString;
    cdsOrdProIndORD_PEDIDO.AsString:= qryConsulta.FieldByName('ORD_PEDIDO').AsString;
    cdsOrdProIndNUMRES.AsString    := qryConsulta.FieldByName('NUMRES').AsString;
    cdsOrdProIndITE_DESITE.AsString:= qryConsulta.FieldByName('ITE_DESITE').AsString;
    cdsOrdProIndORD_CODCOR.AsString:= qryConsulta.FieldByName('ORD_CODCOR').AsString;
    cdsOrdProIndCOR_DESCOR.AsString:= qryConsulta.FieldByName('COR_DESCOR').AsString;
    cdsOrdProIndITE_REFERE.AsString:= qryConsulta.FieldByName('ITE_REFERE').AsString;
    cdsOrdProIndVOLUME.AsString    := qryConsulta.FieldByName('VOLUME').AsString;
    cdsOrdProIndPESTOT.AsString    := qryConsulta.FieldByName('PESTOT').AsString;
    cdsOrdProIndORD_DTAPRE.AsString:= qryConsulta.FieldByName('ORD_DTAPRE').AsString;
    cdsOrdProIndORD_QTDPRO.AsString:= qryConsulta.FieldByName('ORD_QTDPRO').AsString;
    cdsOrdProIndORD_QTDENV.AsString:= qryConsulta.FieldByName('ORD_QTDENV').AsString;
    cdsOrdProIndAUTOINCREM.AsString:= qryConsulta.FieldByName('AUTOINCREM').AsString;
    cdsOrdProIndMARDES.AsString    := qryConsulta.FieldByName('MARDES').AsString;
    cdsOrdProIndORD_DTAVAL.AsString:= qryConsulta.FieldByName('ORD_DTAVAL').AsString;
    cdsOrdProIndORD_LOCALI.AsString:= qryConsulta.FieldByName('ORD_LOCALI').AsString;
    cdsOrdProIndORD_DTAINI.AsString:= qryConsulta.FieldByName('ORD_DTAINI').AsString;
    cdsOrdProIndORD_HORINI.AsString:= qryConsulta.FieldByName('ORD_HORINI').AsString;
    cdsOrdProIndORD_DTAFIN.AsString:= qryConsulta.FieldByName('ORD_DTAFIN').AsString;
    cdsOrdProIndORD_HORFIN.AsString:= qryConsulta.FieldByName('ORD_HORFIN').AsString;
    cdsOrdProIndPOSSUI_LOT.AsString:= qryConsulta.FieldByName('POSSUI_LOT').AsString;
    cdsOrdProIndEXTDIV.AsString    := qryConsulta.FieldByName('EXTDIV').AsString;
    cdsOrdProInd.Post;

    qryConsulta.Next;
  End;

End;

procedure TfrmBaixaOrdProdGeralIndustrial.pCarregaQuantidadesEnvasadas(objOrdPro: TOrdProIndustrial);
Begin

  cdsValidacaoLote.Filter := 'CODORD = ' + QuotedStr(cdsOrdProInd.FieldByName('ORD_CODORD').AsString) +
                             ' AND DTACAD = ' + QuotedStr(cdsOrdProInd.FieldByName('ORD_DTACAD').AsString);
  cdsValidacaoLote.Filtered := True;

  cdsValidacaoLote.First;
  While Not cdsValidacaoLote.Eof do
  Begin
    objOrdPro.Locate('ORD_CODITE', cdsValidacaoLote.FieldByName('CODITE').AsString, []);

    objOrdPro.Edit;
    objOrdPro.FieldByName('NUMLOT').AsString    := cdsValidacaoLote.FieldByName('NUMLOT').AsString;
    objOrdPro.FieldByName('ORD_QTDENV').AsFloat := cdsValidacaoLote.FieldByName('QTDENV').AsFloat;
    objOrdPro.Post;

    cdsValidacaoLote.Next;
  End;

  cdsValidacaoLote.Filter := '';
  cdsValidacaoLote.Filtered := False;
End;

procedure TfrmBaixaOrdProdGeralIndustrial.pBeforePost(DataSet: TDataSet);
var
  strAnalisesAberto: String;
begin
  If blnPerOsa Then
    Exit;
  If ((DataSet.FieldByName('MARDES').OldValue = 'D') And (DataSet.FieldByName('MARDES').AsString = 'M')) Then
  Begin
    If TOrdProIndustrial.fDeveGerarAnalise(DataSet.FieldByName('AUTOINCREM').AsString) And TOrdProIndustrial.fNenhumaAnaliseGerada(DataSet.FieldByName('AUTOINCREM').AsString) Then
    Begin
      pMensagemOk('A ordem de produção possui análise de amostras em sua fórmula e nenhuma análise foi criada!' + #13#10 + 'Não será possível marcar!');
      Abort;
    End
    Else If TOrdProIndustrial.fExisteAnaliseAberto(DataSet.FieldByName('AUTOINCREM').AsString, strAnalisesAberto) Then
    Begin
      pMensagemOk('Existem análises de amostra em aberto para esta ordem de produção!' + #13#10 + strAnalisesAberto + #13#10 + 'Não será possível marcar!');
      Abort;
    End;
  End;
  cdsOrdProIndBeforePost(DataSet);
end;

end.
