unit untImportCadEstruturaConfirma;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Data.DB, untZClient, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData, cxGridLevel, cxClasses, cxGridCustomView, Uni,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, cxGridCitel, cxCurrencyEdit, cxContainer, cxProgressBar;

type
  TAcaoImpCadEstrutura = (tpSem, tpInserir,  tpAtualizar);


  TfrmImportCadEstruturaConfirma = class(TfrmPaiConfirma)
    dtsGerMat: TDataSource;
    dtsDetMat: TDataSource;
    cxGrid1: TcxGridCitel;
    cxGrid1DBTableView1: TcxGridDBTableViewCitel;
    cxGrid1DBTableView2: TcxGridDBTableViewCitel;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1Level2: TcxGridLevel;
    cxGrid1DBTableView1Column1: TcxGridDBColumn;
    cxGrid1DBTableView1Column2: TcxGridDBColumn;
    cxGrid1DBTableView1Column3: TcxGridDBColumn;
    cxGrid1DBTableView1Column4: TcxGridDBColumn;
    cxGrid1DBTableView1Column5: TcxGridDBColumn;
    cxGrid1DBTableView1Column6: TcxGridDBColumn;
    cxGrid1DBTableView1Column7: TcxGridDBColumn;
    cxgDetDMT_ITESUB: TcxGridDBColumn;
    cxgDetITE_DESITE: TcxGridDBColumn;
    cxgDetITE_REFERE: TcxGridDBColumn;
    cxgDetMat_ACAO: TcxGridDBColumn;
    GroupBox1: TGroupBox;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    cxgDetDMT_QTDITE: TcxGridDBColumn;
    cxgDetDMT_SEQUEN: TcxGridDBColumn;
    cxGrid1DBTableView1Column8: TcxGridDBColumn;
    cxgDetDMT_APAREL: TcxGridDBColumn;
    cxgDetDMT_ACUMOP: TcxGridDBColumn;
    cxgDetDMT_BENEFI: TcxGridDBColumn;
    cxgDetDMT_COMPEC: TcxGridDBColumn;
    cxgDetDMT_ESPPEC: TcxGridDBColumn;
    cxgDetDMT_LARPEC: TcxGridDBColumn;
    cxgDetDMT_PERAPA: TcxGridDBColumn;
    cxgDetDMT_PERBEN: TcxGridDBColumn;
    cxgDetDMT_QTDPEC: TcxGridDBColumn;
    procedure FormShow(Sender: TObject);
    procedure cxGrid1DBTableView2CustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cxGrid1DBTableView1Column8GetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
  private
    qryExec: TUniQuery;
    { Private declarations }
  protected
    function  fInsereProdutos(pgbProgresso: TcxProgressBar): Boolean;
    procedure pGravaGerMat(var strSeqGer: String);
    procedure pGravaDetMat(pgbProgresso: TcxProgressBar; strSeqGer: string);
    procedure pPreparaSQLInserirDetMat(var strAutoIncrem: String);
    procedure pPreparaSQLAtualizarDetMat;

    function fTrataVazio(strValor: Variant; ValorDef: Variant ): Variant;

  public
    cdsGerMat,
    cdsDetMat: TZClient;
    blnOk: Boolean;
    { Public declarations }
  end;

  function AcaoImpCadEstruturaToInt(ATAcaoImpCadEstrutura: TAcaoImpCadEstrutura): integer;
  function IntToAcaoImpCadEstrutura(AAcaoInt: Integer): TAcaoImpCadEstrutura;


var
  frmImportCadEstruturaConfirma: TfrmImportCadEstruturaConfirma;

implementation

uses
  untGravando, untFuncoesSimples;


function AcaoImpCadEstruturaToInt(ATAcaoImpCadEstrutura: TAcaoImpCadEstrutura): integer;
Begin
  Result := 0;
  case ATAcaoImpCadEstrutura of
   tpSem: Result := 0;
   tpInserir: Result := 1;
   tpAtualizar: Result := 2;
  end;

End;

function IntToAcaoImpCadEstrutura(AAcaoInt: Integer): TAcaoImpCadEstrutura;
begin
  Result := tpSem;
  case AAcaoInt of
   0: Result := tpSem;
   1: Result := tpInserir;
   2: Result := tpAtualizar;
  end;
End;



{$R *.dfm}

procedure TfrmImportCadEstruturaConfirma.btnConfirmaClick(Sender: TObject);
var  frmIns: TfrmGravando;
begin
  inherited;
  If cdsGerMat.RecordCount > 0 then
  Begin
    pCriarFormularios(TfrmGravando, frmIns);
    Try
      frmIns.fExecutarAcao := fInsereProdutos;
      frmIns.lblGravando.Caption := 'Aguarde... Gravando Estruturas.';
      frmIns.Showmodal;
      If blnOk Then
        pMensagemOk('Estruturas incluídas com sucesso!');
    Finally
      pFreeAndNil(frmIns);
    End;
  End;
end;

procedure TfrmImportCadEstruturaConfirma.cxGrid1DBTableView1Column8GetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;
  If AText = '' Then
    AText := 'Quantidade';
  If UpperCase(AText) = 'P' Then
    AText := 'Porcentagem';
  If UpperCase(AText) = 'Q' Then
    AText := 'Quantidade';
end;

procedure TfrmImportCadEstruturaConfirma.cxGrid1DBTableView2CustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  var
    intAcao: Integer;
    AcaoImpCadEstrutura : TAcaoImpCadEstrutura;
begin
  inherited;
  If cdsDetMat.RecordCount = 0 Then
    Exit;
  intAcao := Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgDetMat_ACAO.Index];

  AcaoImpCadEstrutura :=  IntToAcaoImpCadEstrutura(intAcao);
  ACanvas.Font.Color := clBlack;

  Case AcaoImpCadEstrutura Of
    tpInserir:  ACanvas.Brush.Color := clAqua;
    tpAtualizar: ACanvas.Brush.Color := clYellow;
    Else
      ACanvas.Brush.Color := clMoneyGreen;
  End;


end;

function TfrmImportCadEstruturaConfirma.fInsereProdutos(pgbProgresso: TcxProgressBar): Boolean;
var strSeqGer: String;
begin
  Result := False;
  pgbProgresso.Properties.Max := cdsDetMat.RecordCount;
  cdsGerMat.First;
  cdsDetMat.DisableControls;
  cdsGerMat.DisableControls;
  fStartTransaction;
  blnOk := False;
  Try
    Try
      While not cdsGerMat.Eof Do
      Begin
        pGravaGerMat(strSeqGer);
        pGravaDetMat(pgbProgresso, strSeqGer);
        cdsGerMat.Next;
      End;
      fCommit;
      blnOk := True;
      Result := True;
    Except
      On e: Exception do
      Begin
        fRollBack;
        pMensagensErro(e.Message, '[TfrmImportCadEstruturaConfirma.fInsereProdutos]');
      End;
    End

  Finally
    cdsDetMat.EnableControls;
    cdsGerMat.EnableControls;
  End;
end;

procedure TfrmImportCadEstruturaConfirma.FormCreate(Sender: TObject);
begin
  inherited;
  qryExec := fCriaQuery;
  blnOk := False;
end;

procedure TfrmImportCadEstruturaConfirma.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryExec);
end;

procedure TfrmImportCadEstruturaConfirma.FormShow(Sender: TObject);
begin
  inherited;
  dtsGerMat.DataSet := cdsGerMat;
  dtsDetMat.DataSet := cdsDetMat;
end;

procedure TfrmImportCadEstruturaConfirma.pGravaGerMat(var strSeqGer: String);
var blnInclusao: Boolean;
  const
    cFieldsIns =  'AUTOINCREM,GMT_CODEMP ,GMT_CODITE ,GMT_REFERE ,GMT_OBS001,GMT_OBS002 ,GMT_OBS003 ,GMT_OBS004 ,GMT_QTDETI ,GMT_ULTALT ,GMT_TIPQTD ,GMT_LAYORD';
    cParamnsIns = ':AUTOINCREM, :GMT_CODEMP , :GMT_CODITE , :GMT_REFERE ,:GMT_OBS001,:GMT_OBS002 ,:GMT_OBS003 ,:GMT_OBS004 ,:GMT_QTDETI ,:GMT_ULTALT ,:GMT_TIPQTD ,:GMT_LAYORD';

    cUpdate  = ' GMT_CODEMP = :GMT_CODEMP, ' +
               ' GMT_CODITE = :GMT_CODITE,' +
               ' GMT_REFERE = :GMT_REFERE,' +
               ' GMT_OBS001 = :GMT_OBS001,' +
               ' GMT_OBS002 = :GMT_OBS002,' +
               ' GMT_OBS003 = :GMT_OBS003,' +
               ' GMT_OBS004 = :GMT_OBS004,' +
               ' GMT_QTDETI = :GMT_QTDETI,' +
               ' GMT_ULTALT = :GMT_ULTALT,' +
               ' GMT_TIPQTD = :GMT_TIPQTD,' +
               ' GMT_LAYORD = :GMT_LAYORD ';

begin
  blnInclusao := (Length(cdsGerMat.FieldByName('AUTOINCREM').AsString) < 20);
  qryExec.SQL.Clear;
  If blnInclusao Then
  Begin
    qryExec.SQL.Add('INSERT GERMAT (' + cFieldsIns + ') VALUES ('+cParamnsIns+')');
    strSeqGer := fRetAutoIncrem('GERMAT', VS_StrCodEmp);
  End
  Else
  Begin
    strSeqGer := cdsGerMat.FieldByName('AUTOINCREM').AsString;
    qryExec.SQL.Add('UPDATE GERMAT SET ' + cUpdate);
    qryExec.SQL.Add(' WHERE AUTOINCREM = :AUTOINCREM');
  End;

  qryExec.ParamByName('AUTOINCREM').AsString := strSeqGer;
  qryExec.ParamByName('GMT_CODEMP').AsString :=  cdsGerMat.FieldByName('GMT_CODEMP').AsString;
  qryExec.ParamByName('GMT_CODITE').AsString :=  cdsGerMat.FieldByName('GMT_CODITE').AsString;
  qryExec.ParamByName('GMT_REFERE').AsString :=  cdsGerMat.FieldByName('ITE_REFERE').AsString;
  qryExec.ParamByName('GMT_OBS001').AsString :=  cdsGerMat.FieldByName('GMT_OBS001').AsString;
  qryExec.ParamByName('GMT_OBS002').AsString :=  cdsGerMat.FieldByName('GMT_OBS002').AsString;
  qryExec.ParamByName('GMT_OBS003').AsString :=  cdsGerMat.FieldByName('GMT_OBS003').AsString;
  qryExec.ParamByName('GMT_OBS004').AsString :=  cdsGerMat.FieldByName('GMT_OBS004').AsString;
  qryExec.ParamByName('GMT_QTDETI').AsString :=  cdsGerMat.FieldByName('GMT_QTDETI').AsString;
  qryExec.ParamByName('GMT_ULTALT').AsDate   :=  cdsGerMat.FieldByName('GMT_ULTALT').AsDateTime;
  qryExec.ParamByName('GMT_TIPQTD').AsString :=  fTrataVazio(cdsGerMat.FieldByName('GMT_TIPQTD').Value, 'Q');
  qryExec.ParamByName('GMT_LAYORD').Value :=  fTrataVazio(cdsGerMat.FieldByName('GMT_LAYORD').AsString, null);

  qryExec.ExecSQL;
end;

procedure TfrmImportCadEstruturaConfirma.pPreparaSQLAtualizarDetMat;
begin
  qryExec.sql.Clear;
  qryExec.sql.Add('UPDATE DETMAT SET ');
  qryExec.sql.Add('DMT_SEQGER = :DMT_SEQGER,');
  qryExec.sql.Add('DMT_SEQUEN = :DMT_SEQUEN,');
  qryExec.sql.Add('DMT_CODEMP = :DMT_CODEMP,');
  qryExec.sql.Add('DMT_ITESUB = :DMT_ITESUB,');
  qryExec.sql.Add('DMT_DESCRI = :DMT_DESCRI,');
  qryExec.sql.Add('DMT_REFERE = :DMT_REFERE,');
  qryExec.sql.Add('DMT_QTDITE = :DMT_QTDITE,');
  qryExec.sql.Add('DMT_CUSITE = :DMT_CUSITE,');
  qryExec.sql.Add('DMT_DESPCA = :DMT_DESPCA,');
  qryExec.sql.Add('DMT_APAREL = :DMT_APAREL,');
  qryExec.sql.Add('DMT_ACUMOP = :DMT_ACUMOP,');
  qryExec.sql.Add('DMT_BENEFI = :DMT_BENEFI,');
  qryExec.sql.Add('DMT_COMPEC = :DMT_COMPEC,');
  qryExec.sql.Add('DMT_ESPPEC = :DMT_ESPPEC,');
  qryExec.sql.Add('DMT_LARPEC = :DMT_LARPEC,');
  qryExec.sql.Add('DMT_PERAPA = :DMT_PERAPA,');
  qryExec.sql.Add('DMT_PERBEN = :DMT_PERBEN,');
  qryExec.sql.Add('DMT_QTDPEC = :DMT_QTDPEC,');
  qryExec.sql.Add('DMT_ULTALT = :DMT_ULTALT');
  qryExec.sql.Add('WHERE AUTOINCREM = :AUTOINCREM');
end;

procedure TfrmImportCadEstruturaConfirma.pPreparaSQLInserirDetMat(var strAutoIncrem: String);
begin
  qryExec.sql.Clear;
  qryExec.sql.Add('INSERT INTO DETMAT (');
  qryExec.sql.Add('DMT_SEQGER,');
  qryExec.sql.Add('DMT_SEQUEN,');
  qryExec.sql.Add('AUTOINCREM,');
  qryExec.sql.Add('DMT_CODEMP,');
  qryExec.sql.Add('DMT_ITESUB,');
  qryExec.sql.Add('DMT_DESCRI,');
  qryExec.sql.Add('DMT_REFERE,');
  qryExec.sql.Add('DMT_QTDITE,');
  qryExec.sql.Add('DMT_CUSITE,');
  qryExec.sql.Add('DMT_DESPCA,');
  qryExec.sql.Add('DMT_APAREL,');
  qryExec.sql.Add('DMT_ACUMOP,');
  qryExec.sql.Add('DMT_BENEFI,');
  qryExec.sql.Add('DMT_COMPEC,');
  qryExec.sql.Add('DMT_ESPPEC,');
  qryExec.sql.Add('DMT_LARPEC,');
  qryExec.sql.Add('DMT_PERAPA,');
  qryExec.sql.Add('DMT_PERBEN,');
  qryExec.sql.Add('DMT_QTDPEC,');
  qryExec.sql.Add('DMT_ULTALT');
  qryExec.sql.Add(')VALUES(');
  qryExec.sql.Add(':DMT_SEQGER,');
  qryExec.sql.Add(':DMT_SEQUEN,');
  qryExec.sql.Add(':AUTOINCREM,');
  qryExec.sql.Add(':DMT_CODEMP,');
  qryExec.sql.Add(':DMT_ITESUB,');
  qryExec.sql.Add(':DMT_DESCRI,');
  qryExec.sql.Add(':DMT_REFERE,');
  qryExec.sql.Add(':DMT_QTDITE,');
  qryExec.sql.Add(':DMT_CUSITE,');
  qryExec.sql.Add(':DMT_DESPCA,');
  qryExec.sql.Add(':DMT_APAREL,');
  qryExec.sql.Add(':DMT_ACUMOP,');
  qryExec.sql.Add(':DMT_BENEFI,');
  qryExec.sql.Add(':DMT_COMPEC,');
  qryExec.sql.Add(':DMT_ESPPEC,');
  qryExec.sql.Add(':DMT_LARPEC,');
  qryExec.sql.Add(':DMT_PERAPA,');
  qryExec.sql.Add(':DMT_PERBEN,');
  qryExec.sql.Add(':DMT_QTDPEC,');
  qryExec.sql.Add(':DMT_ULTALT)');

  strAutoIncrem := fRetAutoIncrem('DETMAT', VS_StrCodEmp);


end;

procedure TfrmImportCadEstruturaConfirma.pGravaDetMat(pgbProgresso: TcxProgressBar; strSeqGer: string);
var strAutoIncrem: String;
begin
  cdsDetMat.Filtered := false;
  cdsDetMat.Filter := 'DMT_SEQGER = ' + QuotedStr(cdsGerMat.FieldByName('AUTOINCREM').AsString);
  cdsDetMat.Filtered := True;

  while not cdsDetMat.Eof Do
  Begin
    strAutoIncrem := cdsDetMat.FieldByName('AUTOINCREM').AsString;
    If IntToAcaoImpCadEstrutura(cdsDetMat.FieldByName('ACAO').AsInteger) <> tpSem Then
    Begin
      case IntToAcaoImpCadEstrutura(cdsDetMat.FieldByName('ACAO').AsInteger) Of
         tpInserir  : pPreparaSQLInserirDetMat(strAutoIncrem);
         tpAtualizar: pPreparaSQLAtualizarDetMat;
      End;

      qryExec.ParamByName('DMT_SEQGER').Value:= strSeqGer;
      qryExec.ParamByName('DMT_SEQUEN').Value := fTrataVazio(cdsDetMat.FieldByName('DMT_SEQUEN').Value, 1);
      qryExec.ParamByName('AUTOINCREM').Value := strAutoIncrem;
      qryExec.ParamByName('DMT_CODEMP').Value := fTrataVazio(cdsDetMat.FieldByName('DMT_CODEMP').Value, null);
      qryExec.ParamByName('DMT_ITESUB').Value := fTrataVazio(cdsDetMat.FieldByName('DMT_ITESUB').Value, null);
      qryExec.ParamByName('DMT_DESCRI').Value := fTrataVazio(cdsDetMat.FieldByName('DMT_DESCRI').Value, null);
      qryExec.ParamByName('DMT_REFERE').Value := fTrataVazio(cdsDetMat.FieldByName('ITE_REFERE').Value, null);
      qryExec.ParamByName('DMT_QTDITE').Value := fTrataVazio(cdsDetMat.FieldByName('DMT_QTDITE').Value, null);
      qryExec.ParamByName('DMT_CUSITE').Value := fTrataVazio(cdsDetMat.FieldByName('DMT_CUSITE').Value, null);
      qryExec.ParamByName('DMT_DESPCA').Value := fTrataVazio(cdsDetMat.FieldByName('DMT_DESPCA').Value, null);
      qryExec.ParamByName('DMT_APAREL').Value := fTrataVazio(cdsDetMat.FieldByName('DMT_APAREL').Value, null);
      qryExec.ParamByName('DMT_ACUMOP').Value := fTrataVazio(cdsDetMat.FieldByName('DMT_ACUMOP').Value, null);
      qryExec.ParamByName('DMT_BENEFI').Value := fTrataVazio(cdsDetMat.FieldByName('DMT_BENEFI').Value, null);
      qryExec.ParamByName('DMT_COMPEC').Value := fTrataVazio(cdsDetMat.FieldByName('DMT_COMPEC').Value, null);
      qryExec.ParamByName('DMT_ESPPEC').Value := fTrataVazio(cdsDetMat.FieldByName('DMT_ESPPEC').Value, null);
      qryExec.ParamByName('DMT_LARPEC').Value := fTrataVazio(cdsDetMat.FieldByName('DMT_LARPEC').Value, null);
      qryExec.ParamByName('DMT_PERAPA').Value := fTrataVazio(cdsDetMat.FieldByName('DMT_PERAPA').Value, null);
      qryExec.ParamByName('DMT_PERBEN').Value := fTrataVazio(cdsDetMat.FieldByName('DMT_PERBEN').Value, null);
      qryExec.ParamByName('DMT_QTDPEC').Value := fTrataVazio(cdsDetMat.FieldByName('DMT_QTDPEC').Value, null);
      qryExec.ParamByName('DMT_ULTALT').AsDate:= fTrataVazio(cdsDetMat.FieldByName('DMT_ULTALT').Value, VS_Date);

      qryExec.ExecSQL;

      pgbProgresso.Position := pgbProgresso.Position + 1;
      Application.ProcessMessages;
    End;
    cdsDetMat.Next;
  End;


end;


function TfrmImportCadEstruturaConfirma.fTrataVazio(strValor: Variant; ValorDef: Variant): Variant;
begin
  If strValor = null Then
    Exit(ValorDef);

  If VarToStrDef(strValor, '') = '' Then
    Result := ValorDef
  Else
     Result := strValor;
end;



end.





