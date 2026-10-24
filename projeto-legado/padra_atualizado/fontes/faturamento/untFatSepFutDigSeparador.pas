unit untFatSepFutDigSeparador;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RLFilters, RLDraftFilter, Menus, StdCtrls,
  EditFocus, QColorLabel, Buttons, ExtCtrls, Mask, MaskEditFocus, Uni,
  StrUtils, AppEvnts, DB, UniClientDataSet, untPaiSimples, Grids, DBGridCitel, DBGrids, ComCtrls,
  UniDataSetProvider, DBCtrls, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, Datasnap.DBClient, untLiberacao;

type
  TfrmFatSepFutDigSeparador = class(TfrmPaiSimples)
    dbgConsulta: TDBGridCitel;
    cdsGrid: TUniClientDataSet;
    dsGrid: TDataSource;
    pnl1: TPanel;
    lblSemSal: TLabel;
    shpSemSal: TShape;
    lbl1: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgConsultaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgConsultaDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    objLiberacao : TLiberacao;
    procedure pCarregaDocumentos;
    procedure pInformaSeparador;
    procedure pRemoveSeparador;
    procedure pAtualizaSeparador(strCodSep: String);
  public
    { Public declarations }
  end;


implementation

uses untFuncoesSimples, untPai, untFuncFat, System.UITypes, untTypesSistema;

{$R *.dfm}

{ TfrmConsEntPendentes }

procedure TfrmFatSepFutDigSeparador.pCarregaDocumentos;
Var
  strSQL: String;
  qryGen: TUniQuery;
  cdsGen: TUniClientDataSet;
  cpvGen: TUniDataSetProvider;
Begin

  Try
    qryGen := fCriaQuery;

    cdsGen := TUniClientDataSet.Create(Self);
    cpvGen := TUniDataSetProvider.Create(Self);
    cpvGen.DataSet := qryGen;

    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   "MOVGER"   AS TABGER, ';
    strSQL := strSQL + '   "MOVDET"   AS TABDET, ';        
    strSQL := strSQL + '   "SEPFUT"   AS TABSEP, ';
    strSQL := strSQL + '   SEP_DTAIMP AS DTAIMP, ';
    strSQL := strSQL + '   SEP_HORIMP AS HORIMP, ';
    strSQL := strSQL + '   GER_DTAENT AS DTAENT, ';
    strSQL := strSQL + '   GER_HORENT AS HORENT, ';
    strSQL := strSQL + '   GER_NUMDOC AS NUMDOC, ';
    strSQL := strSQL + '   GER_ESPDOC AS ESPDOC, ';
    strSQL := strSQL + '   GER_CODEMP AS CODEMP, ';
    strSQL := strSQL + '   GER_NUMDOC AS CODCLI, ';
    strSQL := strSQL + '   CONCAT(GER_CODCLI, "-", IF(CLI_NOMCLI LIKE "%CONSUMIDOR%", GER_NOMCON, CLI_NOMCLI)) AS NOMCLI, ';
    strSQL := strSQL + '   SEP_CODSEP AS CODSEP, ';
    strSQL := strSQL + '   CONCAT(IFNULL(OPE_CODOPE,""), "-", IFNULL(OPE_NOMOPE,"")) AS NOMSEP, ';
    strSQL := strSQL + '   MOVGER.AUTOINCREM AS AUTINC ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   MOVGER ';
    strSQL := strSQL + '   INNER JOIN MOVDET ON DET_SEQGER = MOVGER.AUTOINCREM ';
    strSQL := strSQL + '   INNER JOIN SEPFUT ON SEP_SEQGER = MOVDET.AUTOINCREM ';
    strSQL := strSQL + '   INNER JOIN CADCLI ON CLI_CODCLI = GER_CODCLI ';
    strSQL := strSQL + '   LEFT  JOIN CADOPE ON OPE_CODOPE = SEP_CODSEP ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   GER_ENTFUT = "S" AND ';
    strSQL := strSQL + '   (DET_ESPDOC NOT IN ("ML", "PR", "TM")) AND ';
    strSQL := strSQL + '   DET_PROEMB <> "S" AND                      ';
    strSQL := strSQL + '   DET_EFBAIX = "N" AND                       ';
    strSQL := strSQL + '   ROUND(DET_QTDITE - IFNULL(DET_QTDENT,0),4) > 0 ';
    strSQL := strSQL + ' GROUP BY  ';
    strSQL := strSQL + '   DET_SEQGER, DET_CODEMP ';

    strSQL :=  ' SELECT  ' +
               '   *     ' +
               ' FROM    ' +
               '   ( ' + strSQL + ' ) AS TMP ' +
               ' WHERE    ' +
               '   TRUE   ' +
               ' ORDER BY ' +
               '   DTAIMP, HORIMP, DTAENT, HORENT, NUMDOC ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Open;

      pSetaClient(qryGen);

      cdsGen.Close;
      cdsGen.SetProvider(cpvGen);
      cdsGen.Open;

      pSetaClient(cdsGen);

    End;

    cdsGrid.Data := cdsGen.Data;
    cdsGrid.Open;
  Finally
    FreeAndNil(qryGen);
    FreeAndNil(cdsGen);    
  End;

end;

procedure TfrmFatSepFutDigSeparador.FormShow(Sender: TObject);
begin
  inherited;
  pCarregaDocumentos;
  pSetFocus(dbgConsulta);
end;

procedure TfrmFatSepFutDigSeparador.FormCreate(Sender: TObject);
begin
  inherited;
  objLiberacao := TLiberacao.Create;
end;

procedure TfrmFatSepFutDigSeparador.FormDestroy(Sender: TObject);
begin
  if assigned(objLiberacao) then
    FreeAndNil(objLiberacao);
  inherited;
end;

procedure TfrmFatSepFutDigSeparador.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If Key = VK_Escape Then
    Close
  Else If Key = VK_F5 Then
    pCarregaDocumentos;
end;

procedure TfrmFatSepFutDigSeparador.dbgConsultaDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  If cdsGrid.IsEmpty Then
    Exit;

  If Not fEmptyStr(cdsGrid.FieldByName('CODSEP').AsString) Then
  Begin
    If dbgConsulta.Canvas.Brush.Color = clHighLight Then
      dbgConsulta.Canvas.Font.Color := clLime
    Else
      dbgConsulta.Canvas.Font.Color := clBlue;
    dbgConsulta.DefaultDrawColumnCell(Rect,DataCol,Column,State);
  End;

end;

procedure TfrmFatSepFutDigSeparador.dbgConsultaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_RETURN) Then
  Begin
    If cdsGrid.Active And Not cdsGrid.IsEmpty Then
      If fEmptyStr(cdsGrid.FieldByName('CODSEP').AsString) Then
        pInformaSeparador
      Else
        pRemoveSeparador;
  End;
end;

procedure TfrmFatSepFutDigSeparador.pInformaSeparador;
  Var
    strSenha,
    strSeparador: String;
begin
  If ffrmSenha(strSenha) Then
    strSeparador := fRetCodVendedor(strSenha);

  If Not fEmptyStr(strSeparador) Then
    pAtualizaSeparador(strSeparador);
end;

procedure TfrmFatSepFutDigSeparador.pRemoveSeparador;
begin
  objLiberacao.Clear;
  objLiberacao.objMsgLibera.pAddTexto('Entrega Futura - Digitação do Separador - Limpar separador.');

  objLiberacao.strDirAce := 'LIMPSEPFUT';
  objLiberacao.strMsgSen := 'Digitação do Separador - Limpar separador.';
  objLiberacao.strCodOpe := strLoginUsuarioLogado;
  objLiberacao.strCodDig := strLoginUsuarioLogado;
  objLiberacao.blnUsarSenhaFixa := False;
  objLiberacao.blnSempreVariavelUsuario := True;


  If objLiberacao.fLibera Then
  Begin
    pAtualizaSeparador('');
  End;

end;

procedure TfrmFatSepFutDigSeparador.pAtualizaSeparador(strCodSep: String);
begin
  With fCriaQuery, SQL Do
  Begin
    Clear;

    Add('UPDATE');
    Add('  ' + cdsGrid.FieldByName('TABSEP').AsString + ',');
    Add('  ' + cdsGrid.FieldByName('TABDET').AsString + ' ');
    Add('SET SEP_CODSEP = :CODSEP');
    Add('WHERE SEP_SEQGER = AUTOINCREM');
    Add('    AND DET_SEQGER = :SEQGER');

    If fEmptyStr(strCodSep) Then
      ParamByName('CODSEP').Value := Null
    Else
      ParamByName('CODSEP').AsString := strCodSep;

    ParamByName('SEQGER').AsString := cdsGrid.FieldByName('AUTINC').AsString;

    ExecSQL;

    Destroy;
  End;

  cdsGrid.Edit;
  cdsGrid.FieldByName('CODSEP').AsString := strCodSep;
  cdsGrid.FieldByName('NOMSEP').AsString := strCodSep + '-' + fRetNomVendRep(strCodSep);
  cdsGrid.Post;

end;

End.
