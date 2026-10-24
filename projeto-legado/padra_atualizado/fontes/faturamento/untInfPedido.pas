unit untInfPedido;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons, ExtCtrls,
  DBCtrls, DB, UniClientDataSet, Uni, strUtils, BitBtnLockedIncrem,
  Datasnap.DBClient, frxClass, frxExportCSVTestabilidade, Vcl.Grids, Vcl.DBGrids, DBGridCitel;

type
  TfrmInfPedido = class(TfrmPaiSimples)
    pnlFundo: TPanel;
    lbl1: TLabel;
    lblMen001: TDBText;
    lblMen002: TDBText;
    lbl4: TLabel;
    lblObs001: TDBText;
    lblObs002: TDBText;
    lblObs003: TDBText;
    lblObs004: TDBText;
    lblObsExp: TDBText;
    lbl10: TLabel;
    lblTransp: TDBText;
    lbl12: TLabel;
    lblPedCmp: TDBText;
    lbl14: TLabel;
    lblRegist: TDBText;
    lblBloqueio: TLabel;
    dtsInfo: TDataSource;
    cdsInfo: TUniClientDataSet;
    cdsInfoMEN001: TStringField;
    cdsInfoMEN002: TStringField;
    cdsInfoMENEXP: TStringField;
    cdsInfoMENEX2: TStringField;
    cdsInfoMENEX3: TStringField;
    cdsInfoMENEX4: TStringField;
    cdsInfoNOMTRA: TStringField;
    cdsInfoNUMREG: TStringField;
    cdsInfoOBSEXP: TStringField;
    cdsInfoCONFER: TStringField;
    cdsInfoSEPARA: TStringField;
    cdsInfoNUMCMP: TStringField;
    dbgItensPedCmp: TDBGridCitel;
    cdsRastroPed: TUniClientDataSet;
    cdsRastroPedAUTOINCREM: TStringField;
    cdsRastroPedRTM_CODEMP: TStringField;
    cdsRastroPedRTM_NUMDOC: TStringField;
    cdsRastroPedRTM_NUMFAT: TStringField;
    cdsRastroPedRTM_NUMREG: TStringField;
    dtsRastroPed: TDataSource;
    cdsInfoREGCON: TStringField;
    cdsRastroPedRTM_TIPFAT: TStringField;
    cdsRastroPedRTM_EMPFAT: TStringField;
    gpbVenda: TGroupBox;
    lblSepara: TDBText;
    Label2: TLabel;
    lblConfer: TDBText;
    Label1: TLabel;
    gpPedido: TGroupBox;
    lblSeparaPD: TDBText;
    lblSeparador: TLabel;
    lblConferPD: TDBText;
    lblConferente: TLabel;
    cdsInfoCONFER_PD: TStringField;
    cdsInfoSEPARA_PD: TStringField;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    qryInfo: TUniQuery;

    function fSqlConsulta: String;
    procedure pAbreConsulta;

    procedure pRetSeparadorConferente(Var strCodCnf, strCodSep: String; strNumDoc, strEspDoc, strCodEmp: String);
    procedure pRetSeparadorConferente_PD(Var strCodCnf, strCodSep: String; strNumDoc, strEspDoc, strCodEmp: String);

    function fRetNumsPedidosCompra(strNumDoc, strEspDoc, strCodEmp, strCodCli: String): String;
    procedure pCarregarRegistroRastreamento;

  public
    { Public declarations }
    strNumDoc: String;
    strEspDoc: String;
    strCodEmp: String;
    strCodCli: String;

    strNumOri: String;
    strEspOri: String;
    strEmpOri: String;

  end;


implementation

uses untFuncoesSimples;

{$R *.dfm}

{ TfrmInfPedido }

procedure TfrmInfPedido.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  cdsRastroPed.Close;
  FreeAndNil(qryInfo);
end;

procedure TfrmInfPedido.FormCreate(Sender: TObject);
begin
  inherited;
  cdsRastroPed.CreateDataSet;
  qryInfo := fCriaQuery(Self);
end;

procedure TfrmInfPedido.FormShow(Sender: TObject);
begin
  inherited;
  pAbreConsulta;
  If Not fEmptyStr( fGetHostLock('FATGOR' + strNumDoc + strEspDoc + strCodEmp) ) Then
  Begin
    lblBloqueio.Caption := 'O Pedido está sendo utilizado por ' +
                           fGetHostLock('FATGOR' + strNumDoc + strEspDoc + strCodEmp);
    lblBloqueio.Visible := True;
  End;
  pCarregarRegistroRastreamento;
  pSetFocus(btnSair);
end;

function TfrmInfPedido.fRetNumsPedidosCompra(strNumDoc, strEspDoc, strCodEmp,
  strCodCli: String): String;
  Var
    qryTmp : TUniQuery;
begin
  Result := '';
  qryTmp := fCriaQuery(Self);

  Try
    qryTmp.SQL.Add(' SELECT                     ');
    qryTmp.SQL.Add('   CMP_NUMCMP               ');
    qryTmp.SQL.Add(' FROM                       ');
    qryTmp.SQL.Add('   NUMCMP                   ');
    qryTmp.SQL.Add(' WHERE CMP_NUMDOC = :NUMDOC ');
    qryTmp.SQL.Add('   AND CMP_ESPDOC = :ESPDOC ');
    qryTmp.SQL.Add('   AND CMP_CODCLI = :CODCLI ');
    qryTmp.SQL.Add('   AND CMP_CODEMP = :CODEMP ');
    qryTmp.ParamByName('NUMDOC').AsString := strNumDoc;
    qryTmp.ParamByName('ESPDOC').AsString := strEspDoc;
    qryTmp.ParamByName('CODCLI').AsString := strCodCli;
    qryTmp.ParamByName('CODEMP').AsString := strCodEmp;
    qryTmp.Open;

    If qryTmp.RecordCount > 0 Then
    Begin
      qryTmp.First;
      While Not qryTmp.Eof Do
      Begin

        Result := Result + qryTmp.FieldByName('CMP_NUMCMP').AsString;
      
        qryTmp.Next;

        If (qryTmp.Eof) Then
          Result := Result + ' '
        Else
          Result := Result + ', ';
      End;
    End;

    qryTmp.Close;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[fRetNumsPedidosCompra]');
  End;

  FreeAndNil(qryTmp);

end;

function TfrmInfPedido.fSqlConsulta: String;
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE     ';

  strSQL := strSQL + '  FGO_NUMDOC AS NUMDOC, ';
  strSQL := strSQL + '  FGO_ESPDOC AS ESPDOC, ';
  strSQL := strSQL + '  FGO_CODEMP AS CODEMP, ';
  strSQL := strSQL + '  FGO_CODCLI AS CODCLI, ';

  strSQL := strSQL + '  FGO_NUMCMP AS NUMCMP, ';
  strSQL := strSQL + '  FGO_NUMREG AS NUMREG, ';

  strSQL := strSQL + '  FGO_MEN001 AS MEN001, ';
  strSQL := strSQL + '  FGO_MEN002 AS MEN002, ';

  strSQL := strSQL + '  FGO_MENEXP AS MENEXP, ';
  strSQL := strSQL + '  FGO_MENEX2 AS MENEX2, ';
  strSQL := strSQL + '  FGO_MENEX3 AS MENEX3, ';
  strSQL := strSQL + '  FGO_MENEX4 AS MENEX4, ';
  strSQL := strSQL + '  FGO_OBSEXP AS OBSEXP, ';

  strSQL := strSQL + '  FGO_NUMFAT AS NUMFAT, ';
  strSQL := strSQL + '  FGO_TIPFAT AS TIPFAT, ';
  strSQL := strSQL + '  FGO_EMPFAT AS EMPFAT, ';

  strSQL := strSQL + '  CONCAT(FGO_CODTRA, "-", TRA_NOMTRA) AS NOMTRA, ';

  strSQL := strSQL + '  FGO_REGCON AS REGCON ';

  strSQL := strSQL + 'FROM          ';

  strSQL := strSQL + '  FATGOR      ';

  strSQL := strSQL + 'LEFT JOIN EXTGOR   ON   FGO_SEQFGO = FATGOR.AUTOINCREM ';
  strSQL := strSQL + 'LEFT JOIN CADTRA   ON   TRA_CODTRA = FGO_CODTRA        ';
  strSQL := strSQL + 'LEFT JOIN CADOPE C ON C.OPE_CODOPE = FGO_OPEEXP        ';
  strSQL := strSQL + 'LEFT JOIN CADOPE S ON S.OPE_CODOPE = FGO_SEPEXP        ';

  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  FGO_NUMDOC = :NUMDOC AND ';
  strSQL := strSQL + '  FGO_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '  FGO_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '  FGO_CODCLI = :CODCLI     ';

  Result := strSQL;
end;

procedure TfrmInfPedido.pAbreConsulta;
Var
  strConfer: String;
  strSepara: String;

  strConfer_PD: String;
  strSepara_PD: String;

begin
  With qryInfo Do
  Begin
    Close;
    SQL.text := fSqlConsulta;

    ParamByName('NUMDOC').AsString := strNumDoc;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('CODEMP').AsString := strCodEmp;
    ParamByName('CODCLI').AsString := strCodCli;

    Open;

    pRetSeparadorConferente_PD(strConfer_PD,
                               strSepara_PD,
                               strNumDoc,
                               strEspDoc,
                               strCodEmp);

    pRetSeparadorConferente(strConfer,
                            strSepara,
                            strNumOri,
                            strEspOri,
                            strEmpOri);
  End;

  With cdsInfo Do
  Begin
    CreateDataSet;
    Append;
    FieldByName('MEN001').AsString := qryInfo.FieldByName('MEN001').AsString;
    FieldByName('MEN002').AsString := qryInfo.FieldByName('MEN002').AsString;
    FieldByName('MENEXP').AsString := qryInfo.FieldByName('MENEXP').AsString;
    FieldByName('MENEX2').AsString := qryInfo.FieldByName('MENEX2').AsString;
    FieldByName('MENEX3').AsString := qryInfo.FieldByName('MENEX3').AsString;
    FieldByName('MENEX4').AsString := qryInfo.FieldByName('MENEX4').AsString;
    FieldByName('OBSEXP').AsString := qryInfo.FieldByName('OBSEXP').AsString;
    FieldByName('NUMCMP').AsString := fRetNumsPedidosCompra(strNumDoc, strEspDoc, strCodEmp, strCodCli);
    FieldByName('NUMREG').AsString := qryInfo.FieldByName('NUMREG').AsString;
    FieldByName('NOMTRA').AsString := qryInfo.FieldByName('NOMTRA').AsString;
    FieldByName('CONFER').AsString := strConfer;
    FieldByName('SEPARA').AsString := strSepara;

    FieldByName('CONFER_PD').AsString := strConfer_PD;
    FieldByName('SEPARA_PD').AsString := strSepara_PD;

    FieldByName('REGCON').AsString := qryInfo.FieldByName('REGCON').AsString;
    Post;
  End;
end;

procedure TfrmInfPedido.pRetSeparadorConferente(var strCodCnf,
  strCodSep: String; strNumDoc, strEspDoc, strCodEmp: String);
Var
  strSQL   : String;
  strSQLTmp: String;
  qryDoc: TUniQuery;
begin

  Try
    strSQLTmp := '';
    strSQLTmp := strSQLTmp + 'SELECT  ';
    strSQLTmp := strSQLTmp + '  *     ';
    strSQLTmp := strSQLTmp + 'FROM    ';
    strSQLTmp := strSQLTmp + '(       ';

    strSQL := '';
    strSQL := strSQL + 'SELECT        ';
    strSQL := strSQL + '  CONCAT(GER_OPEEXP, "-", C.OPE_NOMOPE) AS CONFER, ';
    strSQL := strSQL + '  CONCAT(GER_SEPEXP, "-", S.OPE_NOMOPE) AS SEPARA  ';
    strSQL := strSQL + 'FROM          ';
    strSQL := strSQL + '  MOVGER      ';
    strSQL := strSQL + '  LEFT JOIN CADOPE C ON C.OPE_CODOPE = GER_OPEEXP  ';
    strSQL := strSQL + '  LEFT JOIN CADOPE S ON S.OPE_CODOPE = GER_SEPEXP  ';
    strSQL := strSQL + 'WHERE         ';
    strSQL := strSQL + '  GER_NUMDOC = :NUMDOC AND ';
    strSQL := strSQL + '  GER_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '  GER_CODEMP = :CODEMP     ';
    strSQL := strSQLTmp + strSQL + ') AS TAB ';

    qryDoc := fCriaQuery(Self);

    With qryDoc Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDOC').AsString := strNumDoc;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODEMP').AsString := strCodEmp;
      Open;

      strCodCnf := FieldByName('CONFER').AsString;
      strCodSep := FieldByName('SEPARA').AsString;

    End;
  Finally
    FreeAndNil(qryDoc);
  End;

end;

procedure TfrmInfPedido.pRetSeparadorConferente_PD(var strCodCnf, strCodSep: String; strNumDoc, strEspDoc, strCodEmp: String);
Var
  strSQL   : String;
  strSQLTmp: String;
  qryDoc: TUniQuery;
begin

  Try
    strSQLTmp := '';
    strSQLTmp := strSQLTmp + 'SELECT  ';
    strSQLTmp := strSQLTmp + '  *     ';
    strSQLTmp := strSQLTmp + 'FROM    ';
    strSQLTmp := strSQLTmp + '(       ';

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  CONCAT(FGO_OPEEXP, "-", C.OPE_NOMOPE) AS CONFER, ';
    strSQL := strSQL + '  CONCAT(FGO_SEPEXP, "-", S.OPE_NOMOPE) AS SEPARA  ';
    strSQL := strSQL + 'FROM                                               ';
    strSQL := strSQL + '  FATGOR                                           ';
    strSQL := strSQL + '  INNER JOIN EXTGOR   ON (EXTGOR.FGO_SEQFGO = FATGOR.AUTOINCREM) ';
    strSQL := strSQL + '  LEFT  JOIN CADOPE C ON (C.OPE_CODOPE = FGO_OPEEXP) ';
    strSQL := strSQL + '  LEFT  JOIN CADOPE S ON (S.OPE_CODOPE = FGO_SEPEXP) ';
    strSQL := strSQL + 'WHERE                      ';
    strSQL := strSQL + '  FGO_NUMDOC = :NUMDOC AND ';
    strSQL := strSQL + '  FGO_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '  FGO_CODEMP = :CODEMP     ';
    strSQL := strSQLTmp + strSQL + ') AS TAB       ';

    qryDoc := fCriaQuery(Self);

    With qryDoc Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDOC').AsString := strNumDoc;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODEMP').AsString := strCodEmp;
      Open;

      strCodCnf := FieldByName('CONFER').AsString;
      strCodSep := FieldByName('SEPARA').AsString;

    End;
  Finally
    FreeAndNil(qryDoc);
  End;

end;

procedure TfrmInfPedido.pCarregarRegistroRastreamento;
  Var
    qryTmp : TUniQuery;
begin
  cdsRastroPed.EmptyDataSet;

  qryTmp := fCriaQuery(Self);

  Try

    qryTmp.SQL.Add(' SELECT ');
    qryTmp.SQL.Add('   AUTOINCREM AS AUTINC, ');
    qryTmp.SQL.Add('   RTM_CODEMP AS CODEMP, ');
    qryTmp.SQL.Add('   RTM_NUMDOC AS NUMDOC, ');
    qryTmp.SQL.Add('   RTM_NUMFAT AS NUMFAT, ');
    qryTmp.SQL.Add('   RTM_TIPFAT AS TIPFAT, ');
    qryTmp.SQL.Add('   RTM_EMPFAT AS EMPFAT, ');
    qryTmp.SQL.Add('   RTM_NUMREG AS NUMREG ');
    qryTmp.SQL.Add(' FROM                        ');
    qryTmp.SQL.Add('   FATRTM                    ');
    qryTmp.SQL.Add(' WHERE RTM_CODEMP = :CODEMP  ');
    qryTmp.SQL.Add('   AND RTM_NUMDOC = :NUMDOC  ');
    qryTmp.ParambyName('CODEMP').AsString := VS_strCodEmp;
    qryTmp.ParambyName('NUMDOC').AsString := strNumDoc;
    qryTmp.Open;

    If (Not qryTmp.isEmpty) Then
    Begin
      While Not qryTmp.Eof do
      Begin
        cdsRastroPed.Append;
        cdsRastroPedAUTOINCREM.asString := qryTmp.FieldByName('AUTINC').asString;
        cdsRastroPedRTM_CODEMP.asString := qryTmp.FieldByName('CODEMP').asString;
        cdsRastroPedRTM_NUMDOC.asString := qryTmp.FieldByName('NUMDOC').asString;
        cdsRastroPedRTM_NUMFAT.asString := qryTmp.FieldByName('NUMFAT').asString;
        cdsRastroPedRTM_TIPFAT.asString := qryTmp.FieldByName('TIPFAT').asString;
        cdsRastroPedRTM_EMPFAT.asString := qryTmp.FieldByName('EMPFAT').asString;
        cdsRastroPedRTM_NUMREG.asString := qryTmp.FieldByName('NUMREG').asString;
        cdsRastroPed.Post;
        qryTmp.Next;
      End;
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmDigPedCmp.pCarregarRegistroRastreamento]');
    End;
  End;

  qryTmp.Close;
  FreeAndNiL(qryTmp);

end;

end.
