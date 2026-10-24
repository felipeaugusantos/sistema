unit untFatHerancaTransfEstoque;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiOrdena, DB, UniClientDataSet, UniDataSetProvider, 
  Uni, AppEvnts, Menus, StdCtrls, EditFocus, Mask,
  MaskEditFocus, Grids, DBGridCitel, DBGrids, Buttons, ExtCtrls, DBCtrls, DBEditFocus,
  BitBtnLockedIncrem, ComCtrls, MemDS, DBAccess, Provider, Datasnap.DBClient,
  frxClass, frxExportCSVTestabilidade, untTypesSistema;

Type
  TfrmFatHerancaTransfEstoque = class(TfrmPaiOrdena)
    btnMarca: TBitBtnLocked;
    btnDesmarca: TBitBtnLocked;
    Label1: TLabel;
    btnItens: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
    pgbGravando: TProgressBar;
    procedure FormShow(Sender: TObject);
    procedure btnMarcaClick(Sender: TObject);
    procedure btnDesmarcaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnGravarClick(Sender: TObject);
    procedure btnItensClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    strCliFil: String;
    qryMovDet: TUniQuery;
    procedure pAbreMovDet(strTabela: String);
    function fProcessaDocsSelecionados: Boolean;
    function fExecutaInclusaoItensDocumento: Boolean;
  protected
    function fGetSql(blnLike: Boolean): String; Override;
  public
    { Public declarations }
    fIncluiItem: TfIncluiItem;
  end;

var
  frmFatHerancaTransfEstoque: TfrmFatHerancaTransfEstoque;

implementation

{$R *.dfm}

uses untFuncoesSimples, untPai, StrUtils,
      untFuncoesRel, untFuncoesRel2;

function TfrmFatHerancaTransfEstoque.fGetSql(blnLike: Boolean): String;
begin

  Result := '';

  {**************}
  {* DOCUMENTOS *}
  {**************}
  Result := Result + ' SELECT SQL_NO_CACHE                                        ';
  Result := Result + ' 		"MOVGER" AS TABELA,                                     ';
  Result := Result + ' 		G.AUTOINCREM,                                           ';
  Result := Result + ' 		CONCAT(GER_NUMDOC," - ",GER_ESPDOC) AS GER_DOCUME,      ';
  Result := Result + ' 		GER_DTAENT,                                             ';
  Result := Result + ' 		GER_HORENT,                                             ';
  Result := Result + ' 		GER_CODEMP,                                             ';
  Result := Result + '    EMP_NOMEMP,                                             ';
  Result := Result + ' 		GER_VLRCON                                              ';
  Result := Result + ' 	FROM                                                      ';
  Result := Result + ' 		MOVGER G                                                ';
  Result := Result + '    INNER JOIN CADEMP ON EMP_CODEMP = GER_CODEMP            ';
  If fCfgSis('CPDORI', varBoolean) Then
  Begin
    Result := Result + ' INNER JOIN PCMGER ON PCG_ORIGND = GER_NUMDOC ';
    Result := Result + '                  AND PCG_ORIGES = GER_ESPDOC ';
    Result := Result + '                  AND PCG_ORIGEP = GER_CODEMP ';
    Result := Result + '                  AND PCG_BAIXAD = 1 ';
  end
  else
  begin
    Result := Result + '    INNER JOIN (SELECT ';
    Result := Result + '                  PCG_CODFOR, ';
    Result := Result + '                  PCG_NUMPED, ';
    Result := Result + '                  PCG_CODEMP, ';
    Result := Result + '                  SUBSTRING(PCG_DOCORI,1,' + IntToStr(fTamDocCadRec) + ')        AS ORI_NUMDOC, ';
    Result := Result + '                  SUBSTRING(PCG_DOCORI,' + IntToStr(Succ(fTamDocCadRec)) + ', 2) AS ORI_ESPDOC, ';
    Result := Result + '                  SUBSTRING(PCG_DOCORI,' + IntToStr(fTamDocCadRec + 3) + ', 3)   AS ORI_CODEMP  ';
    Result := Result + '                FROM ';
    Result := Result + '                  PCMGER ';
    Result := Result + '                WHERE ';
    Result := Result + '                  PCG_BAIXAD AND ';
    Result := Result + '                  IFNULL(PCG_DOCORI, "") <> "") AS TMP ON ORI_NUMDOC = GER_NUMDOC AND ';
    Result := Result + '                                                          ORI_ESPDOC = GER_ESPDOC AND ';
    Result := Result + '                                                          ORI_CODEMP = GER_CODEMP ';
  End;
  Result := Result + ' 	WHERE                                                     ';
  Result := Result + ' 		GER_CODCLI = '+ strCliFil + ' AND                       ';
  Result := Result + ' 		(GER_ESPDOC = "NF" OR GER_ESPDOC = "EL" OR GER_ESPDOC = "TE") AND ';
  Result := Result + '  ' + fCurrentDate + ' <= CAST(DATE_ADD( GER_DTAENT, INTERVAL 30 DAY) AS DATE) ';

  {***********}
  {* PEDIDOS *}
  {***********}
  {Result := Result + ' UNION ALL ';

  Result := Result + ' SELECT                                                     ';
  Result := Result + ' 		"FATGOR" AS TABELA,                                     ';
  Result := Result + ' 		F.AUTOINCREM,                                           ';
  Result := Result + ' 		CONCAT(FGO_NUMDOC," - ",FGO_ESPDOC) AS GER_DOCUME,      ';
  Result := Result + ' 		FGO_DTAENT AS GER_DTAENT,                               ';
  Result := Result + ' 		FGO_HORENT AS GER_HORENT,                               ';
  Result := Result + ' 		FGO_CODEMP AS GER_CODEMP,                               ';
  Result := Result + '    EMP_NOMEMP,                                             ';
  Result := Result + ' 		FGO_VLRCON AS GER_VLRCON                                ';
  Result := Result + ' 	FROM                                                      ';
  Result := Result + ' 		FATGOR F                                                ';
  Result := Result + '    INNER JOIN CADEMP ON EMP_CODEMP = FGO_CODEMP            ';
  Result := Result + ' 	WHERE                                                     ';
  Result := Result + ' 		FGO_CODCLI = '+ strCliFil + ' AND                       ';
  Result := Result + ' 		(FGO_ESPDOC = "PD") AND ';
  Result := Result + '  ' + fCurrentDate + ' <= CAST(DATE_ADD(FGO_DTAENT, INTERVAL 30 DAY) AS DATE) ';}

  Result := Result + ' 	ORDER BY  ';
  Result := Result + ' 		4 DESC, ';
  Result := Result + ' 		5 DESC  ';
end;

procedure TfrmFatHerancaTransfEstoque.FormShow(Sender: TObject);
begin
  inherited;
  blnSempreRelerBanco := False;
  blnQuoteLista       := False;
  fAbreConsulta(True);
end;

procedure TfrmFatHerancaTransfEstoque.btnMarcaClick(Sender: TObject);
begin
  inherited;
  stlListSelecao.Clear;
  With cdsConsulta Do
  Begin
    DisableControls;
    First;
    While Not Eof Do
    Begin
      pAddListaQuery;
      Next;
    End;
    EnableControls;
  End;
  dbgConsulta.Repaint;
end;

procedure TfrmFatHerancaTransfEstoque.btnDesmarcaClick(Sender: TObject);
begin
  inherited;
  stlListSelecao.Clear;
  dbgConsulta.Repaint;
  cdsConsulta.First;
end;

procedure TfrmFatHerancaTransfEstoque.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F6 : btnItens.Click;
    VK_F7 : btnMarca.Click;
    VK_F8 : btnDesmarca.Click;
    VK_F10: btnGravar.Click;
  End;
end;

procedure TfrmFatHerancaTransfEstoque.btnGravarClick(Sender: TObject);
  var
    blnConfirma: Boolean;
begin
  inherited;

  Try
    blnConfirma := True;

    Self.Enabled := False;

    If blnConfirma And (Not cdsConsulta.Active) Or (cdsConsulta.IsEmpty) Or (Not Assigned(fIncluiItem)) Then
      blnConfirma := False;

    If blnConfirma And (stlListSelecao.Count = 0) Then
    Begin
      fMensagem('', 'Selecione ao menos um documento!', ['&Ok']);
      blnConfirma := False;
    End;

    If blnConfirma And (fMensagem('', 'Confirma Inclusão dos Itens?', ['&Sim', '&Não']) = 2) Then
    Begin
      blnConfirma := False;
    End;

    If blnConfirma And fProcessaDocsSelecionados Then
    Begin
      fMensagem('', 'Inclusão dos itens concluída com sucesso!', ['&Ok']);
      Close;
    End;

  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;

  Self.Enabled := True;

end;

{************************************************}
{* MOSTRA OS ITENS DO REGISTRO SELECIONADO      *}
{*********************************************LA*}
procedure TfrmFatHerancaTransfEstoque.btnItensClick(Sender: TObject);
begin
  inherited;

  If cdsConsulta.IsEmpty Or (Not cdsConsulta.Active) Then
    Exit;

  If Assigned(prcExecutaRelatorio) Then
  begin
      prcExecutaRelatorio(114, 5886, [],
                          ['SEQGER','OPCREL'],
                          [cdsConsulta.FieldByName('AUTOINCREM').AsString,
                          IfThen(SameText(cdsConsulta.FieldByName('TABELA').AsString,'MOVGER'),'1','2')],
                          Sender,
                          nil,
                          True);
  End;

end;

Function TfrmFatHerancaTransfEstoque.fProcessaDocsSelecionados: Boolean;
  Var
    intIndice: Integer;
Begin
  pgbGravando.Visible := True;
  pnlInfo.Caption := 'INCLUINDO ITENS...';

  Result := False;
  For intIndice := 0 To stlListSelecao.Count - 1 Do
    If cdsConsulta.Locate('AUTOINCREM', stlListSelecao[intIndice], []) And
       (Not fExecutaInclusaoItensDocumento) Then
      Exit;
  Result := True;

  pgbGravando.Visible := False;
  pnlInfo.Caption := '';
End;

Procedure TfrmFatHerancaTransfEstoque.pAbreMovDet(strTabela: String);
  Var
    strSQL: String;
Begin

  If SameText(strTabela, 'MOVDET') Then
  Begin
    strSQL := '';
    strSQL := strSQL + ' SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '   DET_CODITE, ';
    strSQL := strSQL + '   DET_NUMLOT, ';
    strSQL := strSQL + '   DET_QTDITE, ';
    strSQL := strSQL + '   DET_UNITAR  ';
    strSQL := strSQL + ' FROM          ';
    strSQL := strSQL + '   ' + strTabela;
    strSQL := strSQL + ' WHERE         ';
    strSQL := strSQL + '   DET_SEQGER = :SEQGER AND ';
    strSql := strSql + '   DET_PROEMB = "N"         ';
  End
  Else
  Begin
    strSQL := '';
    strSQL := strSQL + ' SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '   FDO_CODITE AS DET_CODITE, ';
    strSQL := strSQL + '   FDO_NUMLOT AS DET_NUMLOT, ';
    strSQL := strSQL + '   FDO_QTDITE AS DET_QTDITE, ';
    strSQL := strSQL + '   FDO_UNITAR AS DET_UNITAR  ';
    strSQL := strSQL + ' FROM          ';
    strSQL := strSQL + '   ' + strTabela;
    strSQL := strSQL + ' WHERE         ';
    strSQL := strSQL + '   FDO_SEQGER = :SEQGER AND ';
    strSql := strSql + '   FDO_PROEMB = "N"         ';
  End;

  With qryMovDet, SQL Do
  Begin
    Close;
    Clear;
    Add(strSQL);
    ParamByName('SEQGER').AsString := cdsConsulta.FieldByName('AUTOINCREM').AsString;
    Open;
  End;

End;


Function TfrmFatHerancaTransfEstoque.fExecutaInclusaoItensDocumento: Boolean;
  Var
    strNomTab: String;
Begin
  If SameText(cdsConsulta.FieldByName('TABELA').AsString, 'MOVGER') Then
    strNomTab := 'MOVDET'
  Else
    strNomTab := 'FATDOR';

  pAbreMovDet(strNomTab);

  With qryMovDet Do
  Begin
    First;
    pgbGravando.Max := RecordCount;
    pgbGravando.Position := 0;

    While (Not Eof) Do
    Begin
      pgbGravando.Position := RecNo;
      Application.ProcessMessages;

      fIncluiItem(FieldByName('DET_CODITE').AsString,
                  FieldByName('DET_NUMLOT').AsString,
                  FieldByName('DET_QTDITE').AsFloat,
                  FieldByName('DET_UNITAR').AsFloat);
      Next;
    End;
  End;

  Result := True;
End;

procedure TfrmFatHerancaTransfEstoque.FormCreate(Sender: TObject);
begin
  inherited;
  qryMovDet := fCriaQuery(Self);

  strCliFil := fCampoTabela('EMP_CLIFIL','CADEMP',['EMP_CODEMP'],[VS_strCodEmp], False);

  If fEmptyStr(strCliFil) Then
    fMensagem('', 'A empresa não possui "Cliente Filial" cadastrado !', ['&Ok']);

end;

end.
