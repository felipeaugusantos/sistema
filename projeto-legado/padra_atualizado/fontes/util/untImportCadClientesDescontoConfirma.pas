unit untImportCadClientesDescontoConfirma;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Uni, UniClientDataSet,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGrid, cxProgressBar, cxCheckBox;

type
  TfrmImportCadClientesDescontoConfirma = class(TfrmPaiConfirma)
    dtsRegistros: TDataSource;
    cxgRegistros: TcxGrid;
    cxgRegistrosDBTv: TcxGridDBTableView;
    cxgRegistrosDBCODCLI: TcxGridDBColumn;
    cxgRegistrosDBCODFOR: TcxGridDBColumn;
    cxgRegistrosDBPERDESC: TcxGridDBColumn;
    cxgRegistrosDBPERCOM: TcxGridDBColumn;
    cxgRegistrosLv: TcxGridLevel;
    cxgRegistrosDBNOMCLI: TcxGridDBColumn;
    cxgRegistrosDBNOMFOR: TcxGridDBColumn;
    cxgRegistrosDBCADASTRADO: TcxGridDBColumn;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
  private
    { Private declarations }
    qryExec: TUniQuery;
    function fValidaRegistro(cdsRegistro: TUniClientDataSet): Boolean;

    const cNAO_ENCONTRADO = 'NÃO ENCONTRADO';
  protected
    procedure pGravaDados;
    function fInsereDados(pgbProgresso: TcxProgressBar): Boolean;
  public
    { Public declarations }
    cdsRegistros: TUniClientDataSet;
  end;

implementation

{$R *.dfm}

uses
  untFuncoesSimples,
  untGravando;

procedure TfrmImportCadClientesDescontoConfirma.btnConfirmaClick(
  Sender: TObject);
  Var
    frmGravando : TfrmGravando;
begin
  inherited;

  If cdsRegistros.RecordCount > 0 then
  Begin
    pCriarFormularios(TfrmGravando, frmGravando);
    Try
      frmGravando.fExecutarAcao := fInsereDados;
      frmGravando.lblGravando.Caption := 'Aguarde... Processando dados...';
      frmGravando.Showmodal;

      If frmGravando.blnConfirma Then
        pMensagemOk('Processo concluído!');
    Finally
      pFreeAndNil(frmGravando);
    End;
  End;
end;

function TfrmImportCadClientesDescontoConfirma.fValidaRegistro(cdsRegistro : TUniClientDataSet): Boolean;
begin
  Result := False;

  If (cdsRegistro.FieldByName('FOR_NOMFOR').AsString = cNAO_ENCONTRADO) Then
    Exit;

  If (cdsRegistro.FieldByName('CLI_NOMCLI').AsString = cNAO_ENCONTRADO) Then
    Exit;

  If (cdsRegistro.FieldByName('CADASTRADO').AsBoolean) Then
    Exit;

  Result := True;
end;

function TfrmImportCadClientesDescontoConfirma.fInsereDados(
  pgbProgresso: TcxProgressBar): Boolean;
  Var
    intInseridos : Integer;
begin
  intInseridos := 0;
  Result := False;
  pgbProgresso.Properties.Max := cdsRegistros.RecordCount;

  cdsRegistros.First;
  cdsRegistros.DisableControls;
  Try
    fStartTransaction;
    Try
      While Not cdsRegistros.Eof Do
      Begin
        If (fValidaRegistro(cdsRegistros)) Then
        Begin
          pGravaDados;
          Inc(intInseridos);
        End;

        cdsRegistros.Next;
      End;
      fCommit;

      Result := True;
    Except
      On E: Exception do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[TfrmImportCadClientesDescontoConfirma.fInsereDados]');
      End;
    End
  Finally
    cdsRegistros.EnableControls;
  End;

  pMensagemOK('Total registros: '+IntToStr(cdsRegistros.RecordCount)+sLineBreak+
              'Registros inseridos: '+IntToStr(intInseridos)+sLineBreak+
              'Não inseridos: '+IntToStr(cdsRegistros.RecordCount-intInseridos));
end;

procedure TfrmImportCadClientesDescontoConfirma.FormCreate(Sender: TObject);
begin
  inherited;
  qryExec := fCriaQuery;
end;

procedure TfrmImportCadClientesDescontoConfirma.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryExec);
end;

procedure TfrmImportCadClientesDescontoConfirma.FormShow(Sender: TObject);
begin
  inherited;
  dtsRegistros.DataSet := cdsRegistros;
end;

procedure TfrmImportCadClientesDescontoConfirma.pGravaDados;
  Const
    cFields  =  'AUTOINCREM, CDS_CODCLI, CDS_CODFOR, CDS_PERDES, CDS_PERCOM, CDS_CODEMP';
    cParamns = ':AUTOINCREM, :CDS_CODCLI, :CDS_CODFOR, :CDS_PERDES, :CDS_PERCOM, :CDS_CODEMP';
begin
  qryExec.Close;
  qryExec.SQL.Clear;
  qryExec.SQL.Add('INSERT CLIDES (' + cFields + ') VALUES (' + cParamns + ')');
  qryExec.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('CLIDES', VS_StrCodEmp);
  qryExec.ParamByName('CDS_CODCLI').AsString := cdsRegistros.FieldByName('CDS_CODCLI').AsString;
  qryExec.ParamByName('CDS_CODFOR').AsString := cdsRegistros.FieldByName('CDS_CODFOR').AsString;
  qryExec.ParamByName('CDS_PERDES').AsFloat  := cdsRegistros.FieldByName('CDS_PERDES').AsFloat;
  qryExec.ParamByName('CDS_PERCOM').AsFloat  := cdsRegistros.FieldByName('CDS_PERCOM').AsFloat;
  qryExec.ParamByName('CDS_CODEMP').AsString := VS_StrCodEmp;
  qryExec.ExecSQL;
end;

end.
