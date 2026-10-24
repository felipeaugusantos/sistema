unit untConfirmaImportacaoVendedorMarca;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Data.DB, UniClientDataSet, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData, cxGridLevel, cxClasses, cxGridCustomView, Uni,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, cxGridCitel, cxCurrencyEdit, cxContainer, cxProgressBar,
  cxCheckBox, System.StrUtils, Vcl.ComCtrls, cxTextEdit;

type
  TfrmConfirmaImportacaoVendedorMarca = class(TfrmPaiConfirma)
    dtsDados: TDataSource;
    pgcDados: TPageControl;
    tbsDados: TTabSheet;
    tbsErros: TTabSheet;
    cxgDados: TcxGridCitel;
    cxgDadosTbv: TcxGridDBTableView;
    cxgDadosTbvCODCLI: TcxGridDBColumn;
    cxgDadosTbvNOMCLI: TcxGridDBColumn;
    cxgDadosTbvCODVEN: TcxGridDBColumn;
    cxgDadosTbvCODMAR: TcxGridDBColumn;
    cxgDadosTbvVALIDO: TcxGridDBColumn;
    cxgDadosLevel: TcxGridLevel;
    dtsErros: TDataSource;
    cxgDadosTbvDESMAR: TcxGridDBColumn;
    cxgDadosTbvOPERAC: TcxGridDBColumn;
    cxgErros: TcxGridCitel;
    cxgErrosTbv: TcxGridDBTableView;
    cxgErrosTbvMENSAG: TcxGridDBColumn;
    cxgErrosTbvLINHA: TcxGridDBColumn;
    cxgErrosTbvCOLUNA: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    const
      OP_INCLUIR = 'I';
      OP_EXCLUIR = 'E';
  protected
    function fConfirma(pgbProgresso: TcxProgressBar): Boolean;
  public
    { Public declarations }
    cdsDados: TUniClientDataSet;
    cdsErros: TUniClientDataSet;
    blnOk: Boolean;
  end;

implementation

uses
  untGravando,
  untFuncoesSimples;

{$R *.dfm}

procedure TfrmConfirmaImportacaoVendedorMarca.btnConfirmaClick(Sender: TObject);
  Var
    frmGravando : TfrmGravando;
begin
  If cdsDados.IsEmpty Then
  Begin
    pMensagemOk('Não há nenhum registro válido para processamento!');
    Exit;
  End;

  pCriarFormularios(TfrmGravando, frmGravando);
  Try
    frmGravando.fExecutarAcao := fConfirma;
    frmGravando.lblGravando.Caption := 'Aguarde... Processando registros...';
    frmGravando.Showmodal;

    If blnOk Then
    Begin
      pMensagemOk('Processo concluído com êxito!');
      inherited;
    End;
  Finally
    pFreeAndNil(frmGravando);
  End;
end;

function TfrmConfirmaImportacaoVendedorMarca.fConfirma(pgbProgresso: TcxProgressBar): Boolean;
  Var
    qryExec : TUniQuery;
    qryLog : TUniQuery;
begin
  pgbProgresso.Properties.Max := cdsDados.RecordCount;

  blnOk := False;

  qryExec := fCriaQuery;
  Try
    qryLog := fCriaQuery;
    Try
      cdsDados.DisableControls;
      Try
        qryLog.SQL.Clear;
        qryLog.SQL.Add('INSERT INTO LOGVMC(AUTOINCREM, LOG_DTAALT, LOG_HORALT, LOG_CODOPE, LOG_CODCLI, LOG_CODVEN, LOG_CODMAR, LOG_OPERAC)');
        qryLog.SQL.Add('VALUES (:AUTINC, :DTAALT, :HORALT, :CODOPE, :CODCLI, :CODVEN, :CODMAR, :OPERAC)');

        fStartTransaction;
        Try
          cdsDados.First;
          While Not cdsDados.Eof Do
          Begin
            If cdsDados.FieldByName('OPERAC').AsString = OP_INCLUIR Then
            Begin
              qryExec.SQL.Clear;
              qryExec.SQL.Add('INSERT INTO CLIVEN(AUTOINCREM, CVE_CODCLI, CVE_CODMAR, CVE_CODVEN)');
              qryExec.SQL.Add('VALUES (:AUTINC, :CODCLI, :CODMAR, :CODVEN)');

              qryExec.ParamByName('AUTINC').AsString := fRetAutoIncrem('CLIVEN', VS_strCodEmp);
            End
            Else If cdsDados.FieldByName('OPERAC').AsString = OP_EXCLUIR Then
            Begin
              qryExec.SQL.Clear;
              qryExec.SQL.Add('DELETE FROM CLIVEN');
              qryExec.SQL.Add('WHERE CVE_CODCLI = :CODCLI');
              qryExec.SQL.Add('  AND CVE_CODMAR = :CODMAR');
              qryExec.SQL.Add('  AND CVE_CODVEN = :CODVEN');
            End;

            qryExec.ParamByName('CODCLI').AsString := cdsDados.FieldByName('CODCLI').AsString;
            qryExec.ParamByName('CODMAR').AsString := cdsDados.FieldByName('CODMAR').AsString;
            qryExec.ParamByName('CODVEN').AsString := cdsDados.FieldByName('CODVEN').AsString;
            qryExec.ExecSQL;

            qryLog.ParamByName('AUTINC').AsString := fRetAutoIncrem('LOGVMC', VS_strCodEmp);
            qryLog.ParamByName('DTAALT').AsDateTime := fNow;
            qryLog.ParamByName('HORALT').AsDateTime := fNow;
            qryLog.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
            qryLog.ParamByName('CODCLI').AsString := cdsDados.FieldByName('CODCLI').AsString;
            qryLog.ParamByName('CODVEN').AsString := cdsDados.FieldByName('CODVEN').AsString;
            qryLog.ParamByName('CODMAR').AsString := cdsDados.FieldByName('CODMAR').AsString;
            qryLog.ParamByName('OPERAC').AsString := cdsDados.FieldByName('OPERAC').AsString;
            qryLog.ExecSQL;

            cdsDados.Next;
          End;

          fCommit;
          blnOk := True;
          Result := True;
          fMensagem('', 'Cadastros atualizados com sucesso!', ['&O k']);
        Except
          On E: Exception Do
          Begin
            fRollBack;
            Result := False;
            pMensagensErro(E.Message, '[TfrmConfirmaImportacaoVendedorMarca.fConfirmar]');
          End;
        End;
      Finally
        cdsDados.EnableControls;
      End;
    Finally
      FreeAndNil(qryLog);
    End;
  Finally
    FreeAndNil(qryExec);
  End;
end;

procedure TfrmConfirmaImportacaoVendedorMarca.FormCreate(Sender: TObject);
begin
  inherited;
  blnOk := False;
  pgcDados.ActivePage := tbsDados;
end;

procedure TfrmConfirmaImportacaoVendedorMarca.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(dtsErros);
  FreeAndNil(dtsDados);
end;

procedure TfrmConfirmaImportacaoVendedorMarca.FormShow(Sender: TObject);
begin
  inherited;
  cdsErros.IndexFieldNames := 'LINHA';

  dtsDados.DataSet := cdsDados;
  dtsErros.DataSet := cdsErros;
end;

end.
