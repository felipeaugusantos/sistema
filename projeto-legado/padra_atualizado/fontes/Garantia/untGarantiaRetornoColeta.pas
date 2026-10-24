unit untGarantiaRetornoColeta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, Datasnap.DBClient, Uni,
  untGarantiaColetalibtypes, untGarantiaColetaClassesRetornoColeta, cxContainer, cxProgressBar, UniClientDataSet,
  untExcel,
  untGeraExcel, Vcl.ComCtrls;

type
  TfrmGarantiaRetornoColeta = class(TfrmPai)
    pnlGrid: TPanel;
    dbgridColeta: TcxGridCitel;
    dbgridColetaDBTableViewCitel1: TcxGridDBTableViewCitel;
    dbgridColetaLevel1: TcxGridLevel;
    dtsDados: TDataSource;
    dbgridColetaDBTableViewCitel1FGO_DTAENT: TcxGridDBColumn;
    dbgridColetaDBTableViewCitel1FDO_QTDITE: TcxGridDBColumn;
    dbgridColetaDBTableViewCitel1PEDIDO: TcxGridDBColumn;
    dbgridColetaDBTableViewCitel1DOCDEVOLUCAO: TcxGridDBColumn;
    dbgridColetaDBTableViewCitel1CLIENTE: TcxGridDBColumn;
    dbgridColetaDBTableViewCitel1PRODUTO: TcxGridDBColumn;
    dbgridColetaDBTableViewCitel1UN: TcxGridDBColumn;
    dbgridColetaDBTableViewCitel1QTDAVARIA: TcxGridDBColumn;
    dbgridColetaDBTableViewCitel1QTDSEMAVARIA: TcxGridDBColumn;
    dbgridColetaDBTableViewCitel1GARANTIA: TcxGridDBColumn;
    btnProcessar: TBitBtnLocked;
    pnlCabecalho: TPanel;
    rgGarantia: TRadioGroup;
    cdsDados: TUniClientDataSet;
    cdsDadosAUTOINCREM: TStringField;
    cdsDadosFGO_DTAENT: TDateTimeField;
    cdsDadosFGO_NUMDOC: TStringField;
    cdsDadosFGO_ESPDOC: TStringField;
    cdsDadosFGO_CODEMP: TStringField;
    cdsDadosFGO_CODCLI: TStringField;
    cdsDadosCLI_NOMCLI: TStringField;
    cdsDadosFDO_CODITE: TStringField;
    cdsDadosFDO_UNIDAD: TStringField;
    cdsDadosUNI_SIGUNI: TStringField;
    cdsDadosFDO_QTDITE: TFloatField;
    cdsDadosITE_DESITE: TStringField;
    cdsDadosGER_NUMDOC: TStringField;
    cdsDadosGER_ESPDOC: TStringField;
    cdsDadosGER_CODEMP: TStringField;
    cdsDadosINCGOR: TStringField;
    cdsDadosINCDET: TStringField;
    cdsDadosPEDIDO: TStringField;
    cdsDadosDOCDEVOLUCAO: TStringField;
    cdsDadosCLIENTE: TStringField;
    cdsDadosPRODUTO: TStringField;
    cdsDadosQTDAVARIA: TFloatField;
    cdsDadosQTDSEMAVARIA: TFloatField;
    cdsDadosGARANTIA: TStringField;
    cdsDadosITE_CODFOR: TStringField;
    cdsDadosVALITEUNITARIO: TFloatField;
    cdsDadosITE_PRECUS: TFloatField;
    cdsDadosCLI_CODCID: TStringField;
    cdsDadosDET_TABPRE: TStringField;
    cdsDadosDET_NUMLOT: TStringField;
    cdsDadosINCGER: TStringField;
    cdsDadosINCORI: TStringField;
	cdsDadosDET_TOTFRE: TFloatField;
    cdsDadosDET_VLRCON: TFloatField;
    btnExcel: TBitBtnLocked;
    pbProgresso: TProgressBar;
    procedure FormShow(Sender: TObject);
    procedure btnProcessarClick(Sender: TObject);
    procedure cdsDadosQTDAVARIAValidate(Sender: TField);
    procedure cdsDadosGARANTIAGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure dbgridColetaDBTableViewCitel1QTDSEMAVARIACustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure dbgridColetaDBTableViewCitel1QTDAVARIACustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure dbgridColetaDBTableViewCitel1GARANTIACustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cdsDadosQTDSEMAVARIAValidate(Sender: TField);
    procedure btnExcelClick(Sender: TObject);
  private
    procedure pCarregarItens;
    procedure  pReiniciaDados;
    procedure pConfiguracoes;
    function fConfirmar: Boolean;
    function fConfirmarPrg(prgProgresso : TcxProgressbar): Boolean;
    function fConfirmarColeta: Boolean;
    function fEhPositivo(const fltNumero: Double; blnConsideraZeroPositivo: Boolean = false):Boolean;
    procedure pExibirMensagemNumeroNegativo(const strNomCampo: String);
    procedure pExibirMensagemQtdExcedida;
    function fValidarQtdSelecionada(const fltQtdAvaria, fltQtdSemAvaria, fltQtdColeta: Double): Boolean;
    function fValidarField(const Sender: TField):Boolean;
    function fObterOpcaoGarantiaProdutoAvariado: TTipoGarantia;
    function fObterListaPedidosParaRetorno: TListaRetornosColeta;
    procedure pMensagemSemDados;
    procedure pMensagemFaltaRetornosSelecionados;
    procedure pProcessarRetornoColeta(RetornoColeta: TRetornoColeta);
    procedure pMensagemNaoPermitirGarantia(RetornoColeta: TRetornoColeta);
    function fPermitirUsarDocumentoRetornoColeta(objRetornoColeta: TRetornoColeta; objListaRetornos: TListaRetornosColeta): Boolean;


    { Private declarations }
  public
    strPortad: String;
    { Public declarations }
  end;

CONST
  COR_VERMELHO_CLARO = $006169FF;
  COR_VERDE_CLARO =  $00B6ECBD;

var
  frmGarantiaRetornoColeta: TfrmGarantiaRetornoColeta;

implementation


uses
  system.StrUtils,
  untFuncoesSimples,
  untGarantiaColetaClassesGarantiaColeta,
  untGarantiaColetaLibfuncoes,
  untGravando,
  untGarantiaLibDiversos, System.Math;

{$R *.dfm}


{ TfrmGarantiaRetornoColeta }

procedure TfrmGarantiaRetornoColeta.btnExcelClick(Sender: TObject);
var
  intContador: Integer;
  objExcel : TGeraExcel;
  objColumn: TcxGridDBColumn;
begin
  inherited;
  If fMensagem('', 'Confirma exportação para Excel?', ['&Sim', '&Não']) = 2 Then
    Exit;

  objExcel  := TGeraExcel.Create(cdsDados, pbProgresso);
  Try
    objExcel.strNomRel := 'EXPORTAÇÃO RETORNO DE COLETA DE PRODUTOS EM GARANTIA';

    For intContador := 0 To dbgridColetaDBTableViewCitel1.ColumnCount -1 Do
    Begin
      objColumn := dbgridColetaDBTableViewCitel1.Columns[intContador];
      objExcel.AddCampo(objColumn.DataBinding.FieldName, objColumn.Caption);
    End;

    If objExcel.fGerarRelatorio Then
      fMensagem('','Arquivo gerado com sucesso!',['&OK']);
  Except
    On E: Exception Do
			pMensagensErro(E.Message,'[TfrmGarantiaEnvFornecedor.btnExcelClick]');
  End;
  FreeAndNil(objExcel);
end;

procedure TfrmGarantiaRetornoColeta.btnProcessarClick(Sender: TObject);
begin
  if cdsDados.IsEmpty then
  begin
    pMensagemSemDados;
    Exit;
  end;

  if fConfirmarColeta then
  begin
    If fConfirmar Then
      pReiniciaDados;
  end;

end;

procedure TfrmGarantiaRetornoColeta.cdsDadosGARANTIAGetText(Sender: TField; var Text: string; DisplayText: Boolean);
Var
  enuOpcao: TTipoGarantia;
begin
  inherited;
  enuOpcao := TTipoGarantia(ord(Strtointdef(sender.Asstring,0)));
  Text := enuOpcao.GetEnumName;
end;

procedure TfrmGarantiaRetornoColeta.cdsDadosQTDAVARIAValidate(Sender: TField);
begin
  if Not fValidarField(Sender) then
    Abort;
end;

procedure TfrmGarantiaRetornoColeta.cdsDadosQTDSEMAVARIAValidate(Sender: TField);
begin
  if Not fValidarField(Sender) then
    Abort;
end;

procedure TfrmGarantiaRetornoColeta.dbgridColetaDBTableViewCitel1GARANTIACustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  ACanvas.Brush.Color := COR_VERMELHO_CLARO;
end;

procedure TfrmGarantiaRetornoColeta.dbgridColetaDBTableViewCitel1QTDAVARIACustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  ACanvas.Brush.Color := COR_VERMELHO_CLARO;
end;

procedure TfrmGarantiaRetornoColeta.dbgridColetaDBTableViewCitel1QTDSEMAVARIACustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);

begin
  inherited;
  ACanvas.Brush.Color := COR_VERDE_CLARO;
end;

function TfrmGarantiaRetornoColeta.fConfirmarColeta: Boolean;

const
  ALTURA_MSG: Integer = 230;
  LARGURA_MSG: Integer = 570;
  LARGURA_BTN: Integer = 230;
  MSG: String = 'A quantidade informada na coluna QTD SEM AVARIA será liberada  para o estoque bom e '+slineBreak+
                'será gerado crédito para o cliente neste momento. '+sLineBreak+
                'A quantidade informada na coluna QTD COM AVARIA será incluída na rotina de '+slineBreak+
                'Garantia > Recebimento de Cliente, obedecendo o que foi definido na coluna GARANTIA '+slineBreak+
                'Deseja continuar? ';

begin
  Result := fMensagem('Atenção!',       //strTitulo: String;
                      MSG,              //strTexto: String;
                      ['&Sim','&Não'],  //arrOpcoes: Array Of String;
                      2,                //intFocoBotao: Integer = 1;
                      false,            //blnSaiComEsc: Boolean = False;
                      1,                //intEstFon: Integer = 1;
                      LARGURA_BTN,      //intWidBut: Integer = 0;
                      False,            //blnAutosize: Boolean = False;
                      0,                //intSomarTop: Integer=0;
                      false,            //blnObrigaEsc: Boolean = False;
                      false,            //blnOcultPainelBtn: Boolean = False;
                      True,             //blnBtnSemImg : Boolean = False;
                      0,                //intHeightOpc: Integer = 0;
                      LARGURA_MSG) = 1; //intFormWidth: Integer = 0;

end;

function TfrmGarantiaRetornoColeta.fEhPositivo(const fltNumero: Double; blnConsideraZeroPositivo: Boolean = false): Boolean;
begin
  Result := fltNumero > 0;
  if Not Result then
  begin
    if blnConsideraZeroPositivo then
    begin
      Result := fltNumero = 0;
    end;
  end;
end;

function TfrmGarantiaRetornoColeta.fObterListaPedidosParaRetorno: TListaRetornosColeta;
Var
  strIncGor: String;
  ListaRetornos: TListaRetornosColeta;
  RetornoColeta: TRetornoColeta;
  ItemRetornoColeta: TItemRetornoColeta;
  blnQuebra: Boolean;
  blnContinua: Boolean;

begin
  if cdsDados.IsEmpty then
    Exit(Nil);

  ListaRetornos := Nil;
  Try
    ListaRetornos := TListaRetornosColeta.Create;
    strIncGor := EmptyStr;
    cdsDados.DisableControls;
    cdsDados.First;
    while Not cdsDados.EOF do
    begin
      RetornoColeta := Nil;
      blnContinua := True;
      while blnContinua do
      begin
        if strIncGor <> cdsDadosINCGOR.AsString then
        begin
          {$Region 'Criando objRetorno'}
          strIncGor := cdsDadosINCGOR.AsString;
          RetornoColeta := TRetornoColeta.Create;
          RetornoColeta.strIncGer := cdsDadosINCGER.AsString;
          Retornocoleta.strIncGor := strIncGor;
          RetornoColeta.strIncGer := cdsDadosINCGER.AsString;
          RetornoColeta.strNumDoc := cdsDadosGER_NUMDOC.AsString;
          RetornoColeta.strEspDoc := cdsDadosGER_ESPDOC.AsString;
          RetornoColeta.strEmpDoc := cdsDadosGER_CODEMP.AsString;
          RetornoColeta.strCodOpe := strLoginUsuarioLogado;
          RetornoColeta.strCodCli := cdsDadosFGO_CODCLI.asstring;
          RetornoColeta.strCodCid := cdsDadosCLI_CODCID.AsString;
          RetornoColeta.strNumFgo := cdsDadosFGO_NUMDOC.AsString;
          RetornoColeta.strEspFgo := cdsDadosFGO_ESPDOC.AsString;
          RetornoColeta.strEmpFgo := cdsDadosFGO_CODEMP.AsString;
          {$EndRegion }
        end;
        {$Region 'Inserindo item'}
        ItemRetornoColeta := TItemRetornoColeta.Create;
        ItemRetornoColeta.strCodIte       := cdsDadosFDO_CODITE.asstring;
        ItemRetornoColeta.strGarFil       := fCampoTabela('ITE_GARFIL', 'ITEGER', ['ITE_CODITE', 'ITE_CODEMP'], [cdsDadosFDO_CODITE.asstring, VS_strCodEmp]);
        ItemRetornoColeta.strDesIte       := cdsDadosITE_DESITE.AsString;
        ItemRetornoColeta.strIncDor       := cdsDadosAUTOINCREM.AsString;
        ItemREtornoColeta.strIncDet       := cdsDadosINCDET.AsString;
        ItemRetornoColeta.strIncOri       := cdsDadosINCORI.AsString;
        ItemRetornoColeta.fltQtdColeta    := cdsDadosFDO_QTDITE.AsFloat;
        ItemRetornoColeta.fltQtdAvaria    := cdsDadosQTDAVARIA.AsFloat;
        ItemRetornoColeta.fltQtdSemAvaria := cdsDadosQTDSEMAVARIA.AsFloat;
        ItemRetornoColeta.fltUnitar       := fFormataFloat((cdsDadosDET_VLRCON.AsFloat / ItemRetornoColeta.fltQtdColeta), 04)  ;
        ItemRetornoColeta.fltValIte       := cdsDadosVALITEUNITARIO.AsFloat * cdsDadosFDO_QTDITE.AsFloat;
        ItemRetornoColeta.fltPreCus       := cdsDadosITE_PRECUS.AsFloat;
        ItemRetornoColeta.strNumLot       := cdsDadosDET_NUMLOT.asstring;
        ItemRetornoColeta.strCodFor       := cdsDadosITE_CODFOR.AsString;
        ItemRetornoColeta.strTabPre       := cdsDadosDET_TABPRE.AsString;
        ItemRetornoColeta.fltTotFre       := cdsDadosDET_TOTFRE.AsFloat;
        ItemRetornoColeta.Garantia        := ItemRetornoColeta.Garantia.GetFromString(cdsDadosGARANTIA.AsString);

        if ItemRetornoColeta.fRevalidarSaldoPedido then
          RetornoColeta.pAdicionarItem(ItemRetornoColeta)
        else
          ItemRetornoColeta.Free;

        {$Endregion}
        cdsDados.Next;
        blnQuebra := strIncGor <> cdsDadosIncGor.AsString;
        blnContinua := Not (cdsDados.Eof or blnQuebra);

        if Not blnContinua then
        begin
          if fPermitirUsarDocumentoRetornoColeta(RetornoColeta, ListaRetornos) and RetornoColeta.fFGorTemItemSelecionado then
            ListaRetornos.Add(RetornoColeta)
          else
            RetornoColeta.Free;
        end;
      end;
    end;
  Finally
    cdsDados.EnableControls;
    Result := ListaRetornos
  End;
end;

function TfrmGarantiaRetornoColeta.fObterOpcaoGarantiaProdutoAvariado: TTipoGarantia;
Const
  LARGURA_BTN: Integer = 250;
  LARGURA_MSG: integer = 800;
Var
  intRet: Integer;
begin
  intRet :=   fMensagem('Pergunta',
                       'Qual ação será tomada em relação a garantia?',
                       ['&Aguardar retorno do fornec.',
                        '&Crédito para cliente',
                        '&Reposição da mercadoria'],
                        1,
                        false,            //blnSaiComEsc: Boolean = False;
                        1,                //intEstFon: Integer = 1;
                        LARGURA_BTN,      //intWidBut: Integer = 0;
                        False,            //blnAutosize: Boolean = False;
                        0,                //intSomarTop: Integer=0;
                        false,            //blnObrigaEsc: Boolean = False;
                        false,            //blnOcultPainelBtn: Boolean = False;
                        True,             //blnBtnSemImg : Boolean = False;
                        0,                //intHeightOpc: Integer = 0;
                        LARGURA_MSG); //intFormWidth: Integer = 0;
  Result := TTipoGarantia(ord(intRet));
end;

procedure TfrmGarantiaRetornoColeta.FormCreate(Sender: TObject);
begin
  inherited;
  pConfiguracoes;
  cdsdados.CreateDataSet;
end;

procedure TfrmGarantiaRetornoColeta.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = VK_F10 then
    btnProcessar.Click;
  if Key = VK_F6 then
    btnExcel.Click;
end;

procedure TfrmGarantiaRetornoColeta.FormShow(Sender: TObject);
begin
  inherited;
  pCarregarItens;
end;

function TfrmGarantiaRetornoColeta.fPermitirUsarDocumentoRetornoColeta(
  objRetornoColeta: TRetornoColeta; objListaRetornos: TListaRetornosColeta): Boolean;
begin
  Result := objRetornoColeta.fTravarPedido;

  if Not Result then
  begin
    if objListaRetornos.fPermitirIgnorarTrava(objRetornoColeta.fRetLckPedido) then
      Result := True
    else
      objRetornoColeta.pExibirMensagemDocumentoTravado;
  end;
end;

function TfrmGarantiaRetornoColeta.fValidarField(const Sender: TField): Boolean;
Const
 CAMPO_COM_AVARIA: String = 'QTDAVARIA';
 CAMPO_SEM_AVARIA: String = 'QTDSEMAVARIA';
 iCAMPO_COM_AVARIA = 0;   //usado para substituir IFs em razão do sonar acusar complexidade ciclomática
 iCAMPO_SEM_AVARIA = 1;
Var
  enuOpcao: TTipoGarantia;
  intCampo: Integer; //usado para substituir IFs em razão do sonar acusar complexidade ciclomática
begin
  intCampo := indexstr(Sender.FieldName,[CAMPO_COM_AVARIA,CAMPO_SEM_AVARIA]);
  case intCampo of
    iCAMPO_COM_AVARIA..iCAMPO_SEM_AVARIA:  Result := True;
    Else
      Exit(False);
  end;

  if Not fEhPositivo(Sender.AsFloat,true) then
  begin
    pExibirMensagemNumeroNegativo(Sender.DisplayName);
    Exit(False);
  end;

  case intCampo of
    iCAMPO_COM_AVARIA:
      begin
        Result := fValidarQtdSelecionada(Sender.AsFloat, cdsDadosQTDSEMAVARIA.AsFloat, cdsDadosFDO_QTDITE.AsFloat);
        if Result then
        begin
          if Sender.AsFloat = 0 then
          begin
            enuOpcao := TTipoGarantia.Nenhum;
          end
          else
          begin
            enuOpcao := TTipoGarantia(ord(rgGarantia.itemIndex));
            if enuOpcao = TTipoGarantia.Nenhum then
            begin
              enuOpcao := fObterOpcaoGarantiaProdutoAvariado;
            end;
          end;
          cdsDadosGarantia.AsString := enuOpcao.GetIndexAsString;
        end;
      end;
    iCAMPO_SEM_AVARIA:
      begin
        Result := fValidarQtdSelecionada(cdsDadosQtdAvaria.AsFloat, Sender.AsFloat,  cdsDadosFDO_QTDITE.AsFloat);
      end;
  end;

  if Not Result then
  begin
    pExibirMensagemQtdExcedida;
  end;

end;

function TfrmGarantiaRetornoColeta.fValidarQtdSelecionada(const fltQtdAvaria, fltQtdSemAvaria, fltQtdColeta: Double): Boolean;
begin
  Result := (fltQtdAvaria + fltQtdSemAvaria) <= fltQtdColeta;
end;

procedure TfrmGarantiaRetornoColeta.pCarregarItens;
Var
  QryDados: TUniQuery;
begin
  QryDados := Nil;

  Try
    if Not fObterQryDataSetPedidos(VS_strCodEmp, QryDados) then
    begin
      Exit;
    end;
    cdsDadosQTDAVARIA.OnValidate := Nil;
    cdsDadosQTDSEMAVARIA.OnValidate := Nil;

    if Not QryDados.IsEmpty then
    begin
      QryDados.First;
      while Not QryDados.Eof do
      begin
        cdsDados.Append;
        cdsDadosAUTOINCREM.AsString     := QryDados.FieldByName('AUTOINCREM').AsString;
        cdsDadosINCGOR.AsString         := QryDados.FieldByName('INCGOR').AsString;
        cdsDadosINCDET.AsString         := QryDados.FieldByName('INCDET').AsString;
        cdsDadosINCGER.AsString         := QryDados.FieldByName('INCGER').AsString;
        cdsDadosINCORI.AsString         := QryDados.FieldByName('INCORI').AsString;
        cdsDadosFGO_DTAENT.AsDateTime   := QryDados.FieldByName('FGO_DTAENT').AsDateTime;
        cdsDadosFGO_NUMDOC.AsString     := QryDados.FieldByName('FGO_NUMDOC').AsString;
        cdsDadosFGO_ESPDOC.AsString     := QryDados.FieldByName('FGO_ESPDOC').AsString;
        cdsDadosFGO_CODEMP.AsString     := QryDados.FieldByName('FGO_CODEMP').AsString;
        cdsDadosFGO_CODCLI.AsString     := QryDados.FieldByName('FGO_CODCLI').AsString;
        cdsDadosCLI_NOMCLI.AsString     := QryDados.FieldByName('CLI_NOMCLI').AsString;
        cdsDadosFDO_CODITE.AsString     := QryDados.FieldByName('FDO_CODITE').AsString;
        cdsDadosFDO_UNIDAD.AsString     := QryDados.FieldByName('FDO_UNIDAD').AsString;
        cdsDadosDET_VLRCON.AsFloat      := QryDados.FieldByName('DET_VLRCON').AsFloat;
        cdsDadosUNI_SIGUNI.AsString     := QryDados.FieldByName('UNI_SIGUNI').AsString;
        cdsDadosFDO_QTDITE.AsString     := QryDados.FieldByName('FDO_QTDITE').AsString;
        cdsDadosITE_DESITE.AsString     := QryDados.FieldByName('ITE_DESITE').AsString;
        cdsDadosGER_NUMDOC.AsString     := QryDados.FieldByName('GER_NUMDOC').AsString;
        cdsDadosGER_ESPDOC.AsString     := QryDados.FieldByName('GER_ESPDOC').AsString;
        cdsDadosGER_CODEMP.AsString     := QryDados.FieldByName('GER_CODEMP').AsString;
        cdsDadosITE_CODFOR.AsString     := QryDados.FieldByName('ITE_CODFOR').AsString;
        cdsDadosVALITEUNITARIO.AsFloat  := QryDados.FieldByName('VALITEUNITARIO').AsFloat;
        cdsDadosITE_PRECUS.AsFloat      := QryDados.FieldByName('ITE_PRECUS').AsFloat;
        cdsDadosCLI_CODCID.AsString     := QryDados.FieldByName('CLI_CODCID').AsString;
        cdsDadosDET_TABPRE.AsString     := QryDados.FieldByName('DET_TABPRE').AsString;
        cdsDadosDET_NUMLOT.AsString     := QryDados.FieldByName('DET_NUMLOT').AsString;
        cdsDadosDET_TOTFRE.AsFloat      := QryDados.FieldByName('DET_TOTFRE').AsFloat;

        cdsDadosPEDIDO.AsString         := fConcatenar([cdsDadosFGO_NUMDOC.AsString,
                                                        cdsDadosFGO_ESPDOC.AsString,
                                                        cdsDadosFGO_CODEMP.AsString],
                                                        '-');

        cdsDadosDOCDEVOLUCAO.AsString   := fConcatenar([cdsDadosGER_NUMDOC.AsString,
                                                        cdsDadosGER_ESPDOC.AsString,
                                                        cdsDadosGER_CODEMP.AsString],
                                                        '-');

        cdsDadosCLIENTE.AsString        := fConcatenar([cdsDadosFGO_CODCLI.AsString,
                                                        cdsDadosCLI_NOMCLI.AsString],
                                                        '-');

        cdsDadosPRODUTO.AsString        := fConcatenar([cdsDadosFDO_CODITE.AsString,
                                                        cdsDadosITE_DESITE.AsString],
                                                        '-');

        cdsDadosQTDAVARIA.AsFloat       := 0;
        cdsDadosQTDSEMAVARIA.AsFloat    := 0;
        cdsDados.Post;
        QryDados.Next;
      end;
    end;

  Finally
    cdsDadosQTDAVARIA.OnValidate := cdsDadosQTDAVARIAValidate;
    cdsDadosQTDSEMAVARIA.OnValidate := cdsDadosQTDSEMAVARIAValidate;

    if Assigned(QryDados) then
      FreeAndNil(QryDados);
  End;
end;

procedure TfrmGarantiaRetornoColeta.pConfiguracoes;
begin
  strPortad := fCfgSis('PORGAR', varString);
end;

function  TfrmGarantiaRetornoColeta.fConfirmar: Boolean;
var frmGravando : TFrmGravando;
begin
  pCriarFormularios(TfrmGravando, frmGravando);
  Try
    frmGravando.lblGravando.Caption := 'Gravando Informações!';
    frmGravando.pgbStatus.Visible := False;
    frmGravando.fExecutarAcao := fConfirmarPrg;
    frmGravando.ShowModal;
    Result := frmGravando.blnConfirma;
  Finally
    FreeAndNil(frmGravando);
  End;
end;

function TfrmGarantiaRetornoColeta.fConfirmarPrg(prgProgresso : TcxProgressbar): Boolean;
Var
  ListaRetornos: TListaRetornosColeta;
  RetornoColeta: TRetornoColeta;
  i : integer;
begin
  Result := False;
  ListaRetornos := fObterListaPedidosParaRetorno;
  Try
    prgProgresso.Properties.Max :=  ListaRetornos.Count -1;
    if Not Assigned(ListaRetornos) then
    begin
      pMensagemFaltaRetornosSelecionados;
      Exit;
    end;
    i := 0;
    for RetornoColeta in ListaRetornos do
    begin
      pProcessarRetornoColeta(RetornoColeta);
      inc(i);
      prgProgresso.Position := i;
      Application.ProcessMessages;
    end;

    Result := True;
  Finally
    if Assigned(ListaRetornos) then
    begin
      FreeAndNil(listaRetornos);
    end;
  End;
end;

procedure TfrmGarantiaRetornoColeta.pExibirMensagemNumeroNegativo(const strNomCampo: String);
Const
  MSG: String = 'O valor de %s não pode ser negativo.';
  MSG_PADRAO: String = 'O valor não pode ser negativo.';
Var
  strMsg: String;
begin
  if fEmptyStr(strNomCampo) then
  begin
    strMsg := MSG_PADRAO
  end
  else
  begin
    strMsg := Format(MSG,[strNomCampo]);
  end;
  fMensagem('Atenção',strMsg, ['&Ok']);
end;

procedure TfrmGarantiaRetornoColeta.pExibirMensagemQtdExcedida;
begin
  fMensagem('Atenção',' A soma de QTD COM AVARIA + QTD SEM AVARIA não pode ser maior que a QTD COLETA.',['&Ok']);
end;

procedure TfrmGarantiaRetornoColeta.pMensagemFaltaRetornosSelecionados;
begin
  fMensagem('Atenção!','Não há documento com retorno selecionado.',['&Ok']);
end;

procedure TfrmGarantiaRetornoColeta.pMensagemNaoPermitirGarantia(RetornoColeta: TRetornoColeta);
const
   MSG: String = 'Retorno parcial não permitido. '+slinebreak+
                 'Não foi possível inserir garantia para pedido: '+slineBreak+
                 ' %s '+slineBreak+
                 'O retorno do pedido deve ser total.';
Var
  strDocFgo: String;
  strMsg: String;
begin
  strDocFgo := fConcatenar([RetornoColeta.strNumFgo,
                            RetornoColeta.strEspFgo,
                            RetornoColeta.strEmpFgo],
                            '-');

  strMsg := Format(MSG,[strDocFgo]);

  fMensagem('Atenção!',strMsg,['&Ok']);

end;

procedure TfrmGarantiaRetornoColeta.pMensagemSemDados;
begin
  fMensagem('Atenção!','Não há dados para continuar.',['&Ok']);
end;

procedure TfrmGarantiaRetornoColeta.pProcessarRetornoColeta(RetornoColeta: TRetornoColeta);
Var
  Garantia: TGarantiaColeta;
  blnResult: boolean;
begin
  Garantia := Nil;
  Try
    if  Not RetornoColeta.fPermiteProcessarGarantia then
    begin
      pMensagemNaoPermitirGarantia(RetornoColeta);
      Exit;
    end;

    Garantia := TGarantiaColeta.Create(RetornoColeta);
    Garantia.strNomFrm := Self.Name;
    RetornoColeta.dtaDtaEnt := Garantia.dtaDtaEnt;

    blnResult :=  Garantia.fExecutar;
    if blnResult then
    begin
      RetornoColeta.fExecutar;
    end;

  Finally
    RetornoColeta.pDestravarPedido;
    if Assigned(Garantia) then
      FreeAndNil(Garantia);
  End;

end;

procedure TfrmGarantiaRetornoColeta.pReiniciaDados;
begin
  cdsDados.EmptyDataSet;
  pCarregarItens
end;

end.
