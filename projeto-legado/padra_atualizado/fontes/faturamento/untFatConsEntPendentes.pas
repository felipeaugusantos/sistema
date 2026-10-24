unit untFatConsEntPendentes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,  RLFilters, RLDraftFilter, Menus, StdCtrls,
  EditFocus, QColorLabel, Buttons, ExtCtrls, Mask, MaskEditFocus, Uni,
  StrUtils, AppEvnts, DB, UniClientDataSet, untPaiSimples, Grids, DBGridCitel, DBGrids, ComCtrls,
  UniDataSetProvider, DBCtrls, BitBtnLockedIncrem, Datasnap.DBClient, frxClass,
  frxExportCSVTestabilidade, untFatGeraPdfEmail;


type
  TfrmFatConsEntPendentes = class(TfrmPaiSimples)
    dbgConsulta: TDBGridCitel;
    cdsGrid: TUniClientDataSet;
    dsGrid: TDataSource;
    pnlDescricoes: TPanel;
    pnlFiltros: TPanel;
    dbeCliente: TDBEdit;
    dbeTransp: TDBEdit;
    dbeVendedor: TDBEdit;
    edtCodEmp: TEditFocus;
    edtDesEmp: TEditFocus;
    lblEmpresa: TLabel;
    lblMarca: TLabel;
    lbl1: TLabel;
    pnl1: TPanel;
    lblSemSal: TLabel;
    shpSemSal: TShape;
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpExit(Sender: TObject);
    procedure dbgConsultaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure dbgConsultaCellClick(Column: TColumn);
    procedure dbgConsultaDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormActivate(Sender: TObject);
  private
    intConfirmando: Integer;
    procedure pCarregaConsulta;
    procedure pCarregaEmpresa;
    procedure pMostrarItens(strNumDoc, strEspDoc, strCodEmp, strCodCli: String);
  public
    { Public declarations }
  end;


implementation

uses untReimpressao, untFuncoesSimples, untPai, untFuncoesRel, untFuncoesRel2,
     untConsultas, untFuncoesConsulta, untTypesSistema;

{$R *.dfm}

{ TfrmConsEntPendentes }

procedure TfrmFatConsEntPendentes.pCarregaConsulta;
Var
  strSQL: String;
  strSQL1: String;
  qryGen: TUniQuery;
  cdsGen: TUniClientDataSet;
  cpvGen: TUniDataSetProvider;
Begin

  Try

    If (cdsGrid.Active) Then
      cdsGrid.EmptyDataSet;

    qryGen := fCriaQuery;

    cdsGen := TUniClientDataSet.Create(Self);
    cpvGen := TUniDataSetProvider.Create(Self);
    cpvGen.DataSet := qryGen;

    strSQL1 := '';
    strSQL1 := strSQL1 + ' SELECT ';
    strSQL1 := strSQL1 + '   "MOVGER"   AS TABELA, ';
    strSQL1 := strSQL1 + '   MOVGER.GER_DTAENT AS DTAENT, ';
    strSQL1 := strSQL1 + '   MOVGER.GER_HORENT AS HORENT, ';
    strSQL1 := strSQL1 + '   CONCAT(MOVGER.GER_NUMDOC, "-", MOVGER.GER_ESPDOC) AS NUMDOC, ';
    strSQL1 := strSQL1 + '   MOVGER.GER_NUMDOC AS GER_NUMDOC, ';
    strSQL1 := strSQL1 + '   MOVGER.GER_NUMDOC AS DOCORI, ';
    strSQL1 := strSQL1 + '   MOVGER.GER_ESPDOC AS GER_ESPDOC, ';
    strSQL1 := strSQL1 + '   MOVGER.GER_ORIDOC AS GER_ORIDOC, ';
    strSQL1 := strSQL1 + '   MOVGER.AUTOINCREM AS AUTINC, ';
    strSQL1 := strSQL1 + '   MOVGER.GER_NOTESP AS NOTESP, ';
    strSQL1 := strSQL1 + '   MOVGER.GER_CODEMP AS CODEMP, ';
    strSQL1 := strSQL1 + '   MOVGER.GER_CODCLI AS CODCLI, ';
    strSQL1 := strSQL1 + '   MOVGER.GER_TIP_FC AS TIP_FC, ';
    strSQL1 := strSQL1 + '   CONCAT(MOVGER.GER_CODCLI, "-", IF(CLI_NOMCLI LIKE "%CONSUMIDOR%", MOVGER.GER_NOMCON, CLI_NOMCLI)) AS CLIENTE, ';
    strSQL1 := strSQL1 + '   MOVGER.GER_CODTRA AS CODTRA, ';
    strSQL1 := strSQL1 + '   CONCAT(MOVGER.GER_CODTRA,"-", TRA_NOMTRA) AS TRANSP, ';
    strSQL1 := strSQL1 + '   MOVGER.GER_DESESP AS DESESP, ';
    strSQL1 := strSQL1 + '   MOVGER.GER_VLRCON AS VALOR, ';
    strSQL1 := strSQL1 + '   IF( HOUR(TIMEDIFF(CONCAT(CURRENT_DATE(), " ", CURRENT_TIME()), CONCAT(MOVGER.GER_DTAENT, " ", MOVGER.GER_HORENT) ) ) > 0, ';
    strSQL1 := strSQL1 + '       "S", ';
    strSQL1 := strSQL1 + '       IF( MINUTE(TIMEDIFF(CONCAT(CURRENT_DATE(), " ", CURRENT_TIME()), CONCAT(MOVGER.GER_DTAENT, " ", MOVGER.GER_HORENT) ) ) >= ' + fCfgSis('TMPSEN') + ', "S", "N")) AS EXCED, ';
    strSQL1 := strSQL1 + '   AUX_ENTURG AS ENTURG, ';
    strSQL1 := strSQL1 + '   OPE_CODOPE AS CODOPE, ';
    strSQL1 := strSQL1 + '   CONCAT(OPE_CODOPE, "-", OPE_NOMOPE) AS VENDEDOR, ';
    strSQL1 := strSQL1 + '   CONCAT(ROMGERX.GER_CODMOT, "-", CADMOT.MOT_NOMMOT) AS MOTORISTA ';
    strSQL1 := strSQL1 + ' FROM ';
    strSQL1 := strSQL1 + '   MOVGER ';
    strSQL1 := strSQL1 + '   JOIN CADCLI ON (CLI_CODCLI = MOVGER.GER_CODCLI) ';
    strSQL1 := strSQL1 + '   LEFT JOIN CADTRA ON (TRA_CODTRA = MOVGER.GER_CODTRA) ';
    strSQL1 := strSQL1 + '   LEFT JOIN CADOPE ON (OPE_CODOPE = MOVGER.GER_CODVEN) ';
    strSQL1 := strSQL1 + '   LEFT JOIN AUXMOV ON (AUX_SEQGER = MOVGER.AUTOINCREM) ';
    strSQL1 := strSQL1 + '   LEFT JOIN ROMGERX ON (ROMGERX.GER_NOMTAB = "MOVGER" AND ROMGERX.GER_AUTINC = MOVGER.AUTOINCREM) ';
    strSQL1 := strSQL1 + '   LEFT JOIN CADMOT  ON (MOT_CODMOT = ROMGERX.GER_CODMOT) ';
    strSQL1 := strSQL1 + ' WHERE ';
    strSQL1 := strSQL1 + '   MOVGER.GER_DTAENT = :DTADIA AND ';
    strSQL1 := strSQL1 + '  ((SELECT COUNT(*) FROM COMEND      ';
    strSQL1 := strSQL1 + '   WHERE END_NUMDOC = MOVGER.GER_NUMDOC AND  ';
    strSQL1 := strSQL1 + '         END_ESPDOC = MOVGER.GER_ESPDOC AND  ';
    strSQL1 := strSQL1 + '         END_CODEMP = MOVGER.GER_CODEMP AND  ';
    strSQL1 := strSQL1 + '         END_CODCLI = MOVGER.GER_CODCLI      ';
    strSQL1 := strSQL1 + '  ) = 0) AND ';

    If Not fEmptyStr(edtCodEmp.Text) then
      strSQL1 := strSQL1 + '  MOVGER.GER_CODEMP = :CODEMP AND ';

    strSQL1 := strSQL1 + '   IFNULL(MOVGER.GER_ENTFUT,"N") = "N" AND ';
    strSQL1 := strSQL1 + '   MOVGER.GER_ENTFAT = "S" AND ';
    strSQL1 := strSQL1 + '   MOVGER.GER_JAFATU = 0 AND ';
    strSQL1 := strSQL1 + '   MOVGER.GER_ESPDOC IN ("NF","EL","IF","IV","D1","BR","TR", "MI", "FF") ';

    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   * ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   ( ' + strSQL1 + ' ) AS TMP ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  TRUE ';
    strSQL := strSQL + 'ORDER BY ';
    strSQL := strSQL + '  DTAENT, HORENT ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      ParamByName('DTADIA').AsDate   := VS_DATE;
      If Not fEmptyStr(edtCodEmp.Text) then
        ParamByName('CODEMP').AsString := edtCodEmp.Text;

      cdsGen.Close;
      cdsGen.SetProvider(cpvGen);
      cdsGen.Open;
    End;

    If Not cdsGen.IsEmpty Then
    Begin

//      frmFatConsEntPendentes.Caption := 'Documentos Faturados sem Entrega a mais de ' + fCfgSis('TMPSEN') + ' minutos';
      cdsGrid.Data := cdsGen.Data;
      cdsGrid.Open;
      TFloatField(cdsGrid.FieldByName('VALOR')).DisplayFormat := '#,##0.00';

    End;

  Finally
    FreeAndNil(qryGen);
  End;

end;

procedure TfrmFatConsEntPendentes.FormShow(Sender: TObject);
begin
  inherited;
  edtCodEmp.Text := VS_strCodEmp;
  pCarregaEmpresa;
  pCarregaConsulta;
  pnlInfo.Caption := 'F5 - Atualiza Consulta';
  Application.ProcessMessages;
end;

procedure TfrmFatConsEntPendentes.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If Key = VK_Escape Then
    Close
  Else If Key = VK_F5 Then
    pCarregaConsulta;
end;

procedure TfrmFatConsEntPendentes.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtDesEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp, True) Then
    Begin
      pCarregaConsulta;
      SelectNext(ActiveControl, True, True);
    End;
  End;
End;

procedure TfrmFatConsEntPendentes.pCarregaEmpresa;
Begin
  If Not (fEmptyStr(edtCodEmp.Text)) Then
    edtDesEmp.Text := fRetNomeEmpresaSelec(edtCodEmp.Text)
  Else
    edtDesEmp.Text := 'TODOS';
End;

procedure TfrmFatConsEntPendentes.edtCodEmpExit(Sender: TObject);
  Var
    arrEmpresa : TConsultasArray;
begin
  inherited;
  pEdtCodSelectExit(edtCodEmp, edtDesEmp, arrEmpresa, fRetNomeEmpresa, Nil, 'da Empresa');
  pCarregaConsulta;
end;

procedure TfrmFatConsEntPendentes.pMostrarItens(strNumDoc, strEspDoc, strCodEmp, strCodCli: String);
begin

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(174, 7386, [],
                        ['NUMDOC','ESPDOC','CODEMP','CODCLI'],
                        [strNumDoc, strEspDoc, strCodEmp, strCodCli],
                        nil,
                        nil,
                        True);
  End;

end;

procedure TfrmFatConsEntPendentes.dbgConsultaCellClick(Column: TColumn);
begin
  inherited;
  //
end;

procedure TfrmFatConsEntPendentes.dbgConsultaDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  If cdsGrid.IsEmpty Then
    Exit;

  If cdsGrid.FieldByName('ENTURG').AsString = 'S' Then
  Begin
    dbgConsulta.Canvas.Font.Color := clRed;
    dbgConsulta.DefaultDrawColumnCell(Rect,DataCol,Column,State);
  End;
  
end;

procedure TfrmFatConsEntPendentes.dbgConsultaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
  Var
    reiReimpressao: TReimpressao;
    objPdfEma     : TPdfEma;
begin
  inherited;
  If (Key = VK_RETURN) Then
  Begin
    If Not cdsGrid.IsEmpty Then
      pMostrarItens(cdsGrid.FieldByName('GER_NUMDOC').AsString,
                    cdsGrid.FieldByName('GER_ESPDOC').AsString,
                    cdsGrid.FieldByName('CODEMP').AsString,
                    cdsGrid.FieldByName('CODCLI').AsString);
  End
  Else If (Key = VK_F10) Then
  Begin
    If (cdsGrid.IsEmpty) Then
      Exit;

    If InterlockedIncrement(intConfirmando) = 0 Then
    Begin
      Screen.Cursor := crHourGlass;

      Try
        reiReimpressao := TReimpressao.Create(cdsGrid.FieldByName('GER_NUMDOC').AsString,
                                              cdsGrid.FieldByName('GER_ESPDOC').AsString,
                                              cdsGrid.FieldByName('DTAENT').AsDateTime,
                                              cdsGrid.FieldByName('DTAENT').AsDateTime,
                                              cdsGrid.FieldByName('CODCLI').AsString,
                                              cdsGrid.FieldByName('CODEMP').AsString,
                                              cdsGrid.FieldByName('CODOPE').AsString,
                                              True,
                                              cdsGrid.FieldByName('TIP_FC').AsString,
                                              True,
                                              False,
                                              False,
                                              '',
                                              '',
                                              True,
                                              0,
                                              False,
                                              cdsGrid.FieldByName('GER_ORIDOC').AsString,
                                              True);

        objPdfEma := TPdfEma.Create(Self);

        If Not reiReimpressao.objDocumentos.cdsDocumentos.IsEmpty Then
        Begin

          objPdfEma.setEdtFst(opcEmail);
          objPdfEma.setNumDoc(cdsGrid.FieldByName('GER_NUMDOC').AsString);
          objPdfEma.setEspDoc(cdsGrid.FieldByName('GER_ESPDOC').AsString);
          objPdfEma.setCodEmp(cdsGrid.FieldByName('CODEMP').AsString);
          objPdfEma.setVeiF10(True);
          objPdfEma.setSoCons(False);
          objPdfEma.setVisual(True);
          objPdfEma.setPasPdf('Docs_Env_Reimp');

          objPdfEma.setReimpr(reiReimpressao);
          objPdfEma.fReimprimeDocumento;
        End;

      Finally
        FreeAndNil(reiReimpressao);
        FreeAndNil(objPdfEma);
      End;

      InterlockedDecrement(intConfirmando);
    End
    Else
    Begin
      InterlockedDecrement(intConfirmando);
      Key := 0;
    End;

    Screen.Cursor := crDefault;
  End;
end;

procedure TfrmFatConsEntPendentes.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(edtCodEmp);
end;

procedure TfrmFatConsEntPendentes.FormCreate(Sender: TObject);
begin
  inherited;
  intConfirmando := -1;
end;

End.
