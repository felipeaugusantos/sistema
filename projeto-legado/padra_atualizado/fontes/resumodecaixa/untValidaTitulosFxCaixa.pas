unit untValidaTitulosFxCaixa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass, untZClient, DB, strUtils,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, DBGridCitel, Uni;

type
  TfrmValidaTitulosFxCaixa = class(TfrmPai)
    dbgDados: TDBGridCitel;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    cdsDados : TZClient;
    strTableName: String;

    function fGetSQL : String;
    procedure pCreateTable;
  public
    class function fValidar : Boolean;
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples;

{ TfrmValidaTitulosFxCaixa }

function TfrmValidaTitulosFxCaixa.fGetSQL: String;
begin
  Result := '';
  Result := Result + ' SELECT                                                ';
  Result := Result + '   T.*                                                 ';
  Result := Result + ' FROM                                                  ';
  Result := Result + '   ' + strTableName + ' T ';
  Result := Result + '   INNER JOIN MOVGER G ON T.CTR_NUMDUP = G.GER_NUMDOC  ';
  Result := Result + '                      AND T.CTR_ESPDOC = G.GER_ESPDOC  ';
  Result := Result + '                      AND T.CTR_CODCLI = G.GER_CODCLI  ';
  Result := Result + '                      AND T.CTR_CODEMP = G.GER_CODEMP  ';

  Result := Result + ' UNION ALL ';

  Result := Result + ' SELECT                                                ';
  Result := Result + '   T.*                                                 ';
  Result := Result + ' FROM                                                  ';
  Result := Result + '   ' + strTableName + ' T ';
  Result := Result + '   INNER JOIN FATGOR G ON T.CTR_NUMDUP = G.FGO_NUMDOC  ';
  Result := Result + '                       AND T.CTR_ESPDOC = G.FGO_ESPDOC ';
  Result := Result + '                       AND T.CTR_CODCLI = G.FGO_CODCLI ';
  Result := Result + '                       AND T.CTR_CODEMP = G.FGO_CODEMP ';

  Result := Result + ' UNION ALL ';

  Result := Result + ' SELECT                                                ';
  Result := Result + '   T.*                                                 ';
  Result := Result + ' FROM                                                  ';
  Result := Result + '   ' + strTableName + ' T ';
  Result := Result + '   INNER JOIN NOTGER  G ON T.CTR_NUMDUP = G.GER_NUMDOC ';
  Result := Result + '                       AND T.CTR_ESPDOC = G.GER_ESPDOC ';
  Result := Result + '                       AND T.CTR_CODCLI = G.GER_CODCLI ';
  Result := Result + '                       AND T.CTR_CODEMP = G.GER_CODEMP ';

  Result := Result + ' ORDER BY CTR_DTACAD, CLI_NOMCLI ';
end;

procedure TfrmValidaTitulosFxCaixa.FormCreate(Sender: TObject);
begin
  inherited;
  strTableName := fGetMemoryTableName('CADREC');
  cdsDados := TZClient.Create(Self, fGetSQL);
  dbgDados.DataSource := cdsDados.dtsSource;
end;

procedure TfrmValidaTitulosFxCaixa.FormDestroy(Sender: TObject);
begin
  FreeAndNil(cdsDados);
  inherited;
end;

procedure TfrmValidaTitulosFxCaixa.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(btnSair);
end;

class function TfrmValidaTitulosFxCaixa.fValidar: Boolean;
  var
    frmValida: TfrmValidaTitulosFxCaixa;
begin
  If fCfgSis('CRANFX', varBoolean) Then
  Begin
    Result := True;
    Exit;
  End;

  pCriarFormularios(TfrmValidaTitulosFxCaixa, frmValida);
  With frmValida Do
  Begin
    If fTabelaExiste(strTableName) Then
      fDropTable(strTableName);

    pCreateTable;

    cdsDados.fAbreClient(True, 'TfrmValidaTitulosFxCaixa.fValidar');
    TFloatField(cdsDados.FieldByName('CTR_VALDUP')).DisplayFormat := '#,##0.00';

    if cdsDados.IsEmpty Then
      Result := True
    Else
    Begin
      Result := False;
      ShowModal;
    End;

    fDropTable(strTableName);
  End;
  FreeAndNil(frmValida);

end;

procedure TfrmValidaTitulosFxCaixa.pCreateTable;
  Var
    strSQL   : String;
begin

  Try
    strSQL := '';
    strSQL := strSQL + ' CREATE TABLE ' + strTableName + ' ( ';
    strSQL := strSQL + '   CTR_DTACAD DATE, ';
    strSQL := strSQL + '   CTR_DOCUME VARCHAR(20), ';
    strSQL := strSQL + '   CTR_NUMDUP VARCHAR(12), ';
    strSQL := strSQL + '   CTR_ESPDOC VARCHAR(02), ';
    strSQL := strSQL + '   CTR_CODCLI VARCHAR(08), ';
    strSQL := strSQL + '   CTR_CODEMP CHAR(03), ';
    strSQL := strSQL + '   CLI_NOMCLI VARCHAR(60), ';
    strSQL := strSQL + '   CTR_CLIENT VARCHAR(80), ';
    strSQL := strSQL + '   CTR_DTAVEN DATE, ';
    strSQL := strSQL + '   CTR_VALDUP DECIMAL(12,2), ';
    strSQL := strSQL + '   KEY IDX_' + strTableName + '_01 (CTR_NUMDUP, CTR_ESPDOC, CTR_CODCLI, CTR_CODEMP) ';
    strSQL := strSQL + ' ) ENGINE = MEMORY DEFAULT CHARSET=LATIN1 ';

    fExecutaSQL(strSQL);

    strSQL := 'INSERT INTO ' + strTableName;
    strSQL := strSQL + ' SELECT R.CTR_DTACAD,                             ';
    strSQL := strSQL + '        CONCAT(R.CTR_NUMDUP,                      ';
    strSQL := strSQL + '               R.CTR_PARCEL,                      ';
    strSQL := strSQL + '               R.CTR_ESPDOC) AS CTR_DOCUME,       ';
    strSQL := strSQL + '        R.CTR_NUMDUP,                             ';
    strSQL := strSQL + '        R.CTR_ESPDOC,                             ';
    strSQL := strSQL + '        R.CTR_CODCLI,                             ';
    strSQL := strSQL + '        R.CTR_CODEMP,                             ';
    strSQL := strSQL + '        C.CLI_NOMCLI,                             ';
    strSQL := strSQL + '        CONCAT(R.CTR_CODCLI," - ",                ';
    strSQL := strSQL + '               C.CLI_NOMCLI) AS CTR_CLIENT,       ';
    strSQL := strSQL + '        R.CTR_DTAVEN,                             ';
    strSQL := strSQL + '        R.CTR_VALDUP                              ';
    strSQL := strSQL + ' FROM CADREC R                                    ';
    strSQL := strSQL + '   INNER JOIN CADCLI C ON C.CLI_CODCLI = R.CTR_CODCLI  ';
    strSQL := strSQL + '   LEFT JOIN LOGCTR L ON L.CTR_NUMDUP = R.CTR_NUMDUP   ';
    strSQL := strSQL + '                     AND L.CTR_PARCEL = R.CTR_PARCEL   ';
    strSQL := strSQL + '                     AND L.CTR_ESPDOC = R.CTR_ESPDOC   ';
    strSQL := strSQL + '                     AND L.CTR_CODEMP = R.CTR_CODEMP   ';
    strSQL := strSQL + '                     AND L.CTR_CODCLI = R.CTR_CODCLI   ';
    strSQL := strSQL + '                     AND L.CTR_SEQBAI = R.CTR_SEQBAI   ';
    strSQL := strSQL + '                     AND L.CTR_DESCRI LIKE "INCLUSÃO%" ';
    strSQL := strSQL + ' WHERE R.CTR_DTACAD = R.CTR_DTAVEN           ';
    strSQL := strSQL + '   AND L.CTR_DTACAD = L.CTR_DTAVEN           ';
    strSQL := strSQL + '   AND R.CTR_VALDUP > 0                      ';
    strSQL := strSQL + '   AND R.CTR_CODEMP = "' + VS_strCodEmp + '" ';
    strSQL := strSQL + ' ORDER BY R.CTR_DTACAD, C.CLI_NOMCLI         ';

    fExecutaSQL(strSQL);

  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[pCriaTabelaTemporia]');
  End;

end;

end.
