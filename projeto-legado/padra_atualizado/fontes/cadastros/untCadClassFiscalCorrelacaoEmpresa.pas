unit untCadClassFiscalCorrelacaoEmpresa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiEdit, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGrid, System.StrUtils, Uni, untZClient,
  untTypesSistema;

type
  TfrmCadClassFiscalCorrelacaoEmpresa = class(TfrmPaiEdit)
    cxClaFis: TcxGrid;
    cxTblClaFis: TcxGridDBTableView;
    cxEMPRESA: TcxGridDBColumn;
    cxCLASUB: TcxGridDBColumn;
    cxCLAENT: TcxGridDBColumn;
    cxClaFisLvl: TcxGridLevel;
    btnConfirmar: TBitBtnLocked;
    dtsClaFis: TDataSource;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cxTblClaFisEditKeyPress(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Char);
    procedure FormDestroy(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure cxTblClaFisKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    FCodCfop: String;
    qryDados: TZClient;
    qryConCfo: TUniQuery;

    procedure pValidaCampo(const strCampo: String);
    procedure pGravarRegistros;
    procedure pInserir;
    procedure pAtualizar;

    function fSQLInsert: String;
    function fSQLUpdate: String;
    function fTrataVazio(strValue: string): Variant;
    function fRetornaFiltroClaFisKeyPress: String;
    function fPermiteEditarDadosTblClaFis: Boolean;
    function fFocuEstaNosCamposDeCfop: Boolean;
    function fObedeceRegrasDeCfopsParaEntradaDeMercadorias(const strCampo: String): Boolean;
    function fObedeceRegraCfopComecadasComCinco(const strCampo: String): Boolean;
    function fObedeceRegraCfopComecadasComSeis(const strCampo: String): Boolean;
    function fObedeceRegraCfopComecadasComSete(const strCampo: String): Boolean;
  protected
    procedure OnBeforePost(DataSet: TDataSet);
  public
    { Public declarations }
    procedure pHabilitaEdicao(blnHabilita: Boolean);
    procedure pSetCodCfop(const strCodCfop: String);
    procedure pCarregaDados;
  end;

var
  frmCadClassFiscalCorrelacaoEmpresa: TfrmCadClassFiscalCorrelacaoEmpresa;

implementation

{$R *.dfm}

{ TfrmCadClassFiscalCorrelacaoEmpresa }

uses untFuncoesSimples, untConsultas, untGravando;

procedure TfrmCadClassFiscalCorrelacaoEmpresa.btnConfirmarClick(
  Sender: TObject);
begin
  inherited;
  TfrmGravando.fExecutarModalA(pGravarRegistros, 'Aguarde atualizando registros...', '');
  fMensagem('Atenção', 'Registro(s) atualizado(s) com sucesso!', ['&OK']);
  Close;
end;

procedure TfrmCadClassFiscalCorrelacaoEmpresa.cxTblClaFisEditKeyPress(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Char);
Var
    arrSel : TConsultasArray;
    strFiltro : String;
begin


  If Not (qryDados.State = dsEdit) Then
    qryDados.Edit;

  strFiltro := fRetornaFiltroClaFisKeyPress;

  If fEntraCons(Key) Then
  Begin
    If AItem.Index = cxCLASUB.Index Then
    Begin
      If fPesqCFOP(Self, Nil, Nil, qryConCfo, Key, arrSel, True, strFiltro) Then
      Begin
        qryDados.FieldByName('CLASUB').AsString := qryConCfo.FieldByName('CFO_CODCFO').AsString;
        qryDados.Post;
      End;
    End
    Else If Aitem.Index = cxCLAENT.Index Then
    Begin
      If fPesqCFOP(Self, Nil, Nil, qryConCfo, Key, arrSel, True, strFiltro) Then
      Begin
        qryDados.FieldByName('CLAENT').AsString := qryConCfo.FieldByName('CFO_CODCFO').AsString;
        qryDados.Post;
      End;
    End;
    Key := #0;
  End;
end;

procedure TfrmCadClassFiscalCorrelacaoEmpresa.cxTblClaFisKeyPress(
  Sender: TObject; var Key: Char);
Var
    arrSel : TConsultasArray;
    strFiltro : String;
begin


  If fPermiteEditarDadosTblClaFis Then
    qryDados.Edit;

  strFiltro := fRetornaFiltroClaFisKeyPress;

  If fEntraCons(Key) Then
  Begin
    If cxCLASUB.Focused Then
    Begin
      If fPesqCFOP(Self, Nil, Nil, qryConCfo, Key, arrSel, True, strFiltro) Then
      Begin
        qryDados.FieldByName('CLASUB').AsString := qryConCfo.FieldByName('CFO_CODCFO').AsString;
        qryDados.Post;
      End;
    End
    Else If cxCLAENT.Focused Then
    Begin
      If fPesqCFOP(Self, Nil, Nil, qryConCfo, Key, arrSel, True, strFiltro) Then
      Begin
        qryDados.FieldByName('CLAENT').AsString := qryConCfo.FieldByName('CFO_CODCFO').AsString;
        qryDados.Post;
      End;
    End;
    Key := #0;
  End;
end;

function TfrmCadClassFiscalCorrelacaoEmpresa.fFocuEstaNosCamposDeCfop: Boolean;
begin
  Result := True;

  If (cxCLASUB.Focused) Then
    Exit;

  If (cxCLAENT.Focused) Then
    Exit;

  Result := False;
end;

function TfrmCadClassFiscalCorrelacaoEmpresa.fObedeceRegraCfopComecadasComCinco(
  const strCampo: String): Boolean;
begin
  Result := False;

  If (LeftStr(FCodCfop, 1) <> '5') Then
    Exit;

  If (LeftStr(qryDados.FieldByName(strCampo).NewValue, 1) = '1') Then
    Exit;

  Result := True;
end;

function TfrmCadClassFiscalCorrelacaoEmpresa.fObedeceRegraCfopComecadasComSeis(
  const strCampo: String): Boolean;
begin
  Result := False;

  If (LeftStr(FCodCfop, 1) <> '6') Then
    Exit;

  If (LeftStr(qryDados.FieldByName(strCampo).NewValue, 1) = '2') Then
    Exit;

  Result := True;
end;

function TfrmCadClassFiscalCorrelacaoEmpresa.fObedeceRegraCfopComecadasComSete(
  const strCampo: String): Boolean;
begin
  Result := False;

  If (LeftStr(FCodCfop, 1) <> '7') Then
    Exit;

  If (LeftStr(qryDados.FieldByName(strCampo).NewValue, 1) = '3') Then
    Exit;

  Result := True;
end;

function TfrmCadClassFiscalCorrelacaoEmpresa.fObedeceRegrasDeCfopsParaEntradaDeMercadorias(
  const strCampo: String): Boolean;
begin
  Result := True;

  If fObedeceRegraCfopComecadasComCinco(strCampo) Then
    Exit;

  If fObedeceRegraCfopComecadasComSeis(strCampo) Then
    Exit;

  If fObedeceRegraCfopComecadasComSete(strCampo) Then
    Exit;

  Result := False;
end;

procedure TfrmCadClassFiscalCorrelacaoEmpresa.FormCreate(Sender: TObject);
begin
  inherited;
  qryDados  := TZClient.Create(Self, '');
  qryConCfo := fCriaQuery(Self);
  dtsClaFis.DataSet := qryDados;
  cxTblClaFis.OptionsData.Editing := False;
  btnConfirmar.Enabled := False;
end;

procedure TfrmCadClassFiscalCorrelacaoEmpresa.FormDestroy(Sender: TObject);
begin
  FreeAndNil(qryDados);
  FreeAndNil(qryConCfo);
  inherited;
end;

procedure TfrmCadClassFiscalCorrelacaoEmpresa.FormShow(Sender: TObject);
begin
  inherited;
  pCarregaDados;
end;

function TfrmCadClassFiscalCorrelacaoEmpresa.fPermiteEditarDadosTblClaFis: Boolean;
begin
  Result := False;

  If (qryDados.State = dsEdit) Then
    Exit;

  If Not fFocuEstaNosCamposDeCfop Then
    Exit;

  Result := True;
end;

function TfrmCadClassFiscalCorrelacaoEmpresa.fRetornaFiltroClaFisKeyPress: String;
begin
  Result := 'LEFT(CFO_CODCFO, 1) = ';

  If (LeftStr(FCodCfop, 1) = '5') Then
    Result := Result + ' "1" '

  Else If (LeftStr(FCodCfop, 1) = '6') Then
    Result := Result + ' "2" '

  Else If (LeftStr(FCodCfop, 1) = '7') Then
    Result := Result + ' "3" '

  Else  Result := '';
end;

function TfrmCadClassFiscalCorrelacaoEmpresa.fSQLInsert: String;
begin
  Result := '';
  Result := Result + 'INSERT INTO CFOCEM (AUTOINCREM, CEM_CODCFO, CEM_CODEMP, CEM_CLASUB, CEM_CLAENT) ';
  Result := Result + '             VALUES (:AUTINC, :CODCFO, :CODEMP, :CLASUB, :CLAENT)';
end;

function TfrmCadClassFiscalCorrelacaoEmpresa.fSQLUpdate: String;
begin
  Result := '';
  Result := Result + 'UPDATE CFOCEM ';
  Result := Result + '   SET CEM_CLASUB = :CLASUB, ';
  Result := Result + '       CEM_CLAENT = :CLAENT  ';
  Result := Result + ' WHERE CEM_CODCFO = :CODCFO  ';
  Result := Result + '   AND CEM_CODEMP = :CODEMP  ';
end;

function TfrmCadClassFiscalCorrelacaoEmpresa.fTrataVazio(strValue: string): Variant;
begin
  Result := Null;

  If fEmptyStr(strValue) Then
    Exit;

  Result := strValue;
end;

procedure TfrmCadClassFiscalCorrelacaoEmpresa.OnBeforePost(DataSet: TDataSet);
begin
  pValidaCampo('CLASUB');
  pValidaCampo('CLAENT');
end;

procedure TfrmCadClassFiscalCorrelacaoEmpresa.pAtualizar;
var
  qryUpt: TUniQuery;
begin
  qryUpt := fCriaQuery(Nil);
  qryDados.DisableControls;
  Try
    qryDados.First;
    While Not qryDados.Eof Do
    Begin
      If fEmptyStr(qryDados.FieldByName('AUTINC').AsString) Then
      Begin
        qryDados.Next;
        Continue;
      End;

      Try
        qryUpt.Close;
        qryUpt.SQL.Clear;
        qryUpt.SQL.Add(fSQLUpdate);
        qryUpt.ParamByName('CLASUB').Value := fTrataVazio(qryDados.FieldByName('CLASUB').AsString);
        qryUpt.ParamByName('CLAENT').Value := fTrataVazio(qryDados.FieldByName('CLAENT').AsString);
        qryUpt.ParamByName('CODCFO').AsString := FCodCfop;
        qryUpt.ParamByName('CODEMP').AsString := qryDados.FieldByName('CODEMP').AsString;
        qryUpt.ExecSQL;
      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '[TfrmCadClassFiscalCorrelacaoEmpresa.pInserir]');
        End;
      End;

      qryDados.Next;
    End;
  Finally
    FreeAndNil(qryUpt);
    qryDados.First;
    qryDados.EnableControls;
  End;
end;

procedure TfrmCadClassFiscalCorrelacaoEmpresa.pCarregaDados;
begin
  qryDados.qryQuery.SQL.Clear;

  qryDados.qryQuery.SQL.Add('SELECT ');
  qryDados.qryQuery.SQL.Add('  CFOCEM.AUTOINCREM AS AUTINC, ');
  qryDados.qryQuery.SQL.Add('  CEM_CLASUB AS CLASUB, ');
  qryDados.qryQuery.SQL.Add('  CEM_CLAENT AS CLAENT, ');
  qryDados.qryQuery.SQL.Add('  EMP_CODEMP AS CODEMP, ');
  qryDados.qryQuery.SQL.Add('  CONCAT(EMP_CODEMP, " - ", EMP_NOMEMP) AS EMPRESA ');
  qryDados.qryQuery.SQL.Add('FROM ');
  qryDados.qryQuery.SQL.Add('  CADEMP');
  qryDados.qryQuery.SQL.Add('LEFT JOIN CFOCEM ON CEM_CODEMP = EMP_CODEMP ');
  qryDados.qryQuery.SQL.Add('                AND CEM_CODCFO = ' + QuotedStr(FCodCfop));
  qryDados.qryQuery.SQL.Add(' ORDER BY EMP_CODEMP ');

  qryDados.fAbreClient(True, 'TfrmCadClassFiscalCorrelacaoEmpresa.pCarregaDados');

  qryDados.BeforePost := OnBeforePost;
end;

procedure TfrmCadClassFiscalCorrelacaoEmpresa.pGravarRegistros;
begin
  pInserir;
  pAtualizar;
end;

procedure TfrmCadClassFiscalCorrelacaoEmpresa.pHabilitaEdicao(
  blnHabilita: Boolean);
begin
  cxTblClaFis.OptionsData.Editing := blnHabilita;
  btnConfirmar.Enabled := blnHabilita;
end;

procedure TfrmCadClassFiscalCorrelacaoEmpresa.pInserir;
var
  qryIns: TUniQuery;
begin
  qryIns := fCriaQuery(Nil);
  qryDados.DisableControls;
  Try
    qryDados.First;
    While Not qryDados.Eof Do
    Begin
      If Not fEmptyStr(qryDados.FieldByName('AUTINC').AsString) Then
      Begin
        qryDados.Next;
        Continue;
      End;

      Try
        qryIns.Close;
        qryIns.SQL.Clear;
        qryIns.SQL.Add(fSQLInsert);
        qryIns.ParamByName('AUTINC').AsString := fRetAutoIncrem('CFOCEM', VS_strCodEmp);
        qryIns.ParamByName('CODCFO').AsString := FCodCfop;
        qryIns.ParamByName('CODEMP').AsString := qryDados.FieldByName('CODEMP').AsString;
        qryIns.ParamByName('CLASUB').Value := fTrataVazio(qryDados.FieldByName('CLASUB').AsString);
        qryIns.ParamByName('CLAENT').Value := fTrataVazio(qryDados.FieldByName('CLAENT').AsString);
        qryIns.ExecSQL;
      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '[TfrmCadClassFiscalCorrelacaoEmpresa.pInserir]');
        End;
      End;

      qryDados.Next;
    End;
  Finally
    FreeAndNil(qryIns);
    qryDados.EnableControls;
  End;
end;

procedure TfrmCadClassFiscalCorrelacaoEmpresa.pSetCodCfop(
  const strCodCfop: String);
begin
  FCodCfop := strCodCfop;
end;

procedure TfrmCadClassFiscalCorrelacaoEmpresa.pValidaCampo(
  const strCampo: String);
begin
  If qryDados.FieldByName(strCampo).NewValue <> qryDados.FieldByName(strCampo).OldValue Then
  Begin
    qryDados.FieldByName(strCampo).AsString := fPadL(qryDados.FieldByName(strCampo).AsString, 4,'0');

    If fEmptyStr(fCampoTabela('CFO_CODCFO', 'CADCFO',  ['CFO_CODCFO'], [qryDados.FieldByName(strCampo).NewValue])) Then
    Begin
      fMensagem('Atenção', 'Classificação não encontrada!', ['&OK']);
      qryDados.FieldByName(strCampo).AsString := '';
      pSetFocus(cxClaFis);
    End Else
    Begin

      If LeftStr(qryDados.FieldByName(strCampo).NewValue, 1) >= '5' Then
      Begin
        fMensagem('Atenção', 'Correlação de CFOP para Entrada de Mercadorias deve ser uma Classificação de entrada!', ['&OK']);
        qryDados.FieldByName(strCampo).AsString := '';
      End

      Else If fObedeceRegrasDeCfopsParaEntradaDeMercadorias(strCampo) Then
      Begin
        fMensagem('Atenção', 'Para CFOPs começadas com 5, 6 e 7 as Classicações para a Entrada de Mercadorias devem começar respectivamente com 1, 2 e 3!', ['&OK']);
        qryDados.FieldByName(strCampo).AsString := '';
      End;

    End;
  End;
end;

end.
