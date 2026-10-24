unit untTransfLocFisGlobalWMSReservados;

interface

uses
  System.SysUtils, System.Classes, untZClient, frxClass, frxDBSet,
  Data.DB,Forms;

type
  TfrmTransfLocFisGlobalWMSReservados = class(TForm)
    frxReport: TfrxReport;
    frxRelatorio: TfrxDBDataset;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    cdsRelatorio : TZClient;
    function fGetSQL : String;
  public
    class procedure pExibeDocumentosReservados(strSeqLof : String);
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses untFuncoesSimples;

{$R *.dfm}

{ TfrmTransfLocFisGlobalWMSReservados }

procedure TfrmTransfLocFisGlobalWMSReservados.DataModuleCreate(Sender: TObject);
begin
  cdsRelatorio := TZClient.Create(Nil, fGetSQL);
end;

procedure TfrmTransfLocFisGlobalWMSReservados.DataModuleDestroy(
  Sender: TObject);
begin
  FreeAndNil(cdsRelatorio);
end;

function TfrmTransfLocFisGlobalWMSReservados.fGetSQL: String;
begin
  Result := '';
  Result := Result + ' SELECT LOF_DTACAD AS DTACAD,                   ';
  Result := Result + '        LOF_HRACAD AS HRACAD,                   ';
  Result := Result + '        LOF_CODOPE AS CODOPE,                   ';
  Result := Result + '        LOF_NUMLOT AS NUMLOT,                   ';
  Result := Result + '        LOF_CODITE AS CODITE,                   ';
  Result := Result + '        ITE_DESITE AS DESITE,                   ';
  Result := Result + '        MAR_DESMAR AS DESMAR,                   ';
  Result := Result + '        UNI_SIGUNI AS SIGUNI,                   ';
  Result := Result + '        LOF_LOCATU AS LOCATU,                   ';
  Result := Result + '        LOF_LOCNOV AS LOCNOV,                   ';
  Result := Result + '        LOF_DTAVAL AS DTAVAL,                   ';
  Result := Result + '        LOF_SALDOS AS SALDOS,                   ';
  Result := Result + '        LOF_QTDTRA AS QTDTRA,                   ';
  Result := Result + '        EMP_NOMEMP AS NOMEMP,                   ';
  Result := Result + '        NUMDOC,                                 ';
  Result := Result + '        ESPDOC,                                 ';
  Result := Result + '        CODEMP,                                 ';
  Result := Result + '        CODCLI,                                 ';
  Result := Result + '        SEPEXP,                                 ';
  Result := Result + '        OPE_NOMOPE AS NOMEXP,                   ';
  Result := Result + '        CLI_CODCLI AS CODCLI,                   ';
  Result := Result + '        CLI_NOMCLI AS NOMCLI,                   ';
  Result := Result + '        QTDPED,                                 ';
  Result := Result + '        CONCAT(                                 ';
  Result := Result + '        NUMDOC, "-",                            ';
  Result := Result + '        ESPDOC, "-",                            ';
  Result := Result + '        CODEMP) AS PEDIDO                       ';
  Result := Result + ' FROM TRALOF                                    ';
  Result := Result + '   INNER JOIN CADITE ON ITE_CODITE = LOF_CODITE ';
  Result := Result + '   INNER JOIN CADMAR ON MAR_CODMAR = ITE_CODMAR ';
  Result := Result + '   INNER JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI ';
  Result := Result + '   INNER JOIN CADEMP ON EMP_CODEMP = LOF_CODEMP ';
  Result := Result + '   INNER JOIN ( ' + fRetornaSQLSalResLotesDigSeparacao(VS_strCodEmp, True, VS_strCodEmp, False, True, True, True);
  Result := Result + '     ) AS A ON A.CODITE = LOF_CODITE            ';
  Result := Result + '           AND A.NUMLOT = LOF_NUMLOT            ';
  Result := Result + '   LEFT  JOIN CADOPE ON OPE_CODOPE = SEPEXP     ';
  Result := Result + '   INNER JOIN CADCLI ON CLI_CODCLI = CODCLI     ';
  Result := Result + ' WHERE LOF_SEQLOF = :SEQLOF                     ';
  Result := Result + ' ORDER BY NOMEXP, NUMDOC, ESPDOC,               ';
  Result := Result + '          CODEMP, CODITE, NUMLOT                ';
end;

class procedure TfrmTransfLocFisGlobalWMSReservados.pExibeDocumentosReservados(strSeqLof: String);
  var
    frmForm: TfrmTransfLocFisGlobalWMSReservados;

begin
  Try
    pCriarFormularios(TfrmTransfLocFisGlobalWMSReservados, frmForm);
    With frmForm, cdsRelatorio.qryQuery Do
    Begin
      ParamByName('EMPITE').AsString := VS_strCodEmp;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ParamByName('SEQLOF').AsString := strSeqLof;

      cdsRelatorio.fAbreClient(True, 'TfrmTransfLocFisGlobalWMSReservados.pExibeDocumentosReservados');

      If not cdsRelatorio.IsEmpty Then
      Begin
        frxRelatorio.DataSet := cdsRelatorio;
        TfrxMemoView(frxReport.FindObject('mmoZebra')).Highlight.Color := fCfgSis('CORZEB');
        pPreviewReport(frmForm.Name, 'Requerimento de transferência para pedidos reservados', frxReport);
      End;

    End;
  Finally
    FreeAndNil(frmForm);
  End;

end;

end.



