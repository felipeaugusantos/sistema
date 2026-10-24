unit untEntregasFuturasTintas;

interface

uses
  Windows, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  untPai, cxEdit, DB, Dialogs, untTypesSistema,
  cxGridCustomTableView, cxGridDBTableView, StdCtrls, 
  BitBtnLockedIncrem, Uni, untFuncoesSimples, untFuncFat,  StrUtils, 
  UniClientDataSet, UniDataSetProvider, ActnList, untCadLote, MaskUtils,
  cxProgressBar, cxEditRepositoryItems, Grids, DBGridCitel, DBGrids,
  Math,  AppEvnts, Menus, Buttons, ExtCtrls, cxClasses, MemDS, DBAccess,
  Provider, System.Actions, frxClass, frxExportCSVTestabilidade,
  Datasnap.DBClient;

type
  TfrmEntregasFuturasTintas = class(TfrmPai)
    btnMarcaTodos: TBitBtnLocked;
    btnDesmarcaTodos: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
    dtsConsulta: TDataSource;
    cdsConsulta: TUniClientDataSet;
    dpsConsulta: TUniDataSetProvider;
    qryConsulta: TUniQuery;
    actlstTela: TActionList;
    actConfirma: TAction;
    actMarcarTodos: TAction;
    actDesmarcarTodos: TAction;
    cerDados: TcxEditRepository;
    cercbiSelecionado: TcxEditRepositoryCheckBoxItem;
    dbgDados: TDBGridCitel;
    procedure FormShow(Sender: TObject);
    procedure dbgvEntregasFuturasKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnMarcaTodosClick(Sender: TObject);
    procedure btnDesmarcaTodosClick(Sender: TObject);
    procedure actConfirmaExecute(Sender: TObject);
    procedure actMarcarTodosExecute(Sender: TObject);
    procedure actDesmarcarTodosExecute(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure cdsConsultaAfterScroll(DataSet: TDataSet);
    procedure dbgDadosKeyPress(Sender: TObject; var Key: Char);
    procedure dbgDadosDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
    fatVenda : TFatVenda;
    blnMarcaTodos: Boolean;
    strTabela: string;
    arrMenDoc: array[1..2] of String;
    objCadLot: TCadLot;
    intRecNo: Integer;
    function fGetSql(): String;
    procedure pAbrirConsulta;
    procedure pCriaFatVenda;
    procedure pInicializaTemporaria;
    function fIncluiItens(pgbProgresso: TcxProgressBar): Boolean;
    function fGetItem(qryGenIte: TUniQuery; strCodIte: String): Boolean;
    function fTrocaLotePadrao(Var strNovoLote: String): Boolean;
    procedure pCarregarCliente(fatVenda: TFatVenda);
    procedure pProcessarTabelasPrecosTintas(const dicRetorno: TDicionario);
    function fRetornaEmpresaTE: Boolean;
    procedure pAssociarEftGor();
    function fGetQtdItensMarcados: Integer;
  public
    blnSepFut: Boolean;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    { Public declarations }
  end;

var
  frmEntregasFuturasTintas: TfrmEntregasFuturasTintas;

implementation

uses
  untDigCodigoLote, untGravando, untFuncTinta, untSelecionaEmpresaTE,
  untDDLFactory, untFuncoes,untFatVendasCalculadorWrapper, untFuncFatTypes, untMadeireira,
  untDuplicatas;

{$R *.dfm}

{ TfrmEntregasFuturasTintas }

procedure TfrmEntregasFuturasTintas.actConfirmaExecute(Sender: TObject);
begin
  btnGravar.Click;
end;

procedure TfrmEntregasFuturasTintas.actDesmarcarTodosExecute(Sender: TObject);
begin
  btnDesmarcaTodos.Click;
end;

procedure TfrmEntregasFuturasTintas.actMarcarTodosExecute(Sender: TObject);
begin
  btnMarcaTodos.Click;
end;

procedure TfrmEntregasFuturasTintas.btnDesmarcaTodosClick(Sender: TObject);
var
  strBookMark: TBookmark;
begin
  Try
    Try
      strBookMark := cdsConsulta.Bookmark;
      cdsConsulta.First;

      while not cdsConsulta.Eof do
      begin
        cdsConsulta.Edit;
        cdsConsulta.FieldByName('SELECIONADO').AsInteger := 0;
        cdsConsulta.Post;
        cdsConsulta.Next;
      end;  
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    cdsConsulta.Bookmark := strBookMark;
    pSetFocus(dbgDados);
  End;
end;

procedure TfrmEntregasFuturasTintas.btnGravarClick(Sender: TObject);
var
  blnConfirma: Boolean;
begin
  Try
    Try
      dbgDados.Enabled := False;
      blnConfirma      := False;

      cdsConsulta.DisableConstraints;
      cdsConsulta.DisableControls;
      
      if cdsConsulta.IsEmpty then
        Exit;

      if fGetQtdItensMarcados <= 0 then
      begin
        fMensagem('ATENÇÃO!', 'É necessário selecionar no mínimo um produto!', ['&O k']);
        Exit;
      end;

      pCriaFatVenda;
      fatVenda.strCodCli := fRetornaClienteFilial(VS_strCodEmp);
      If Not fRetornaEmpresaTE Then
      Begin
        fMensagem('ATENÇÃO!', 'É necessário informar a Empresa que irá atender' + #13#10 +
                  'este documento através de Transferência de Estoque!', ['&O k']);
        Exit;
      End;

      pCarregarCliente(fatVenda);
      pInicializaTemporaria;

      frmGravando := nil;
      Try
        Try
          frmGravando := TfrmGravando.Create(Self);
          frmGravando.strChave := '';
          frmGravando.fExecutarAcao := fIncluiItens;
          frmGravando.ShowModal;
          blnConfirma := frmGravando.blnConfirma;
        Except
          on E: Exception do
          begin
            raise;
          end;
        End;
      Finally
        if Assigned(frmGravando) then FreeAndNil(frmGravando);
      End;

      if blnConfirma then
      begin
        fatVenda.strEntreg := cdsConsulta.FieldByName('GER_CONENT').AsString;
        fatVenda.pCarregaAliquotasRetencao;
        fatVenda.pPreencheMatrizFechamento;
        fatVenda.pCalculaPesBruLiq;
        fatVenda.pCalculaTotGer(False, False);

        If fatVenda.fAplicaDescontoIcmsOrgaoPublicoNoDescontoEspecial Then
        Begin
          If (fatVenda.fltDesEsp <= 0.00) And (fatVenda.fltIcmOrg > 0) Then
            fatVenda.fltDesEsp := fatVenda.fltIcmOrg;
        End;

        fatVenda.pDestacaRetencoes;
        fatVenda.pRetemImpostosNoDescontoEspecial;

        fatVenda.pCalculaTotGer(False, False);
        fatVenda.pCalculaTotGer;
        fDigDuplic(fatVenda.arrDuplicata, fTiraCaracEspeciaisParenteses(fatVenda.strConPag), 0, fatVenda.fltTotGer,
                                                 FAlse, False, False, VS_Date, False);

        fatVenda.strDesCla := fRetDesCla(fatVenda.strClaFis);
        fatVenda.pCalculaTotalParaCadRec;
        fatVenda.pRateiaValores;
        fatVenda.dtaGraPed := VS_Date;

        frmGravando := nil;
        Try
          Try
            frmGravando := TfrmGravando.Create(Self);
            frmGravando.strChave := 'FATVENDAS';
            frmGravando.fExecutarAcao := fatVenda.fGravaArquivos;
            frmGravando.ShowModal;
            blnConfirma := frmGravando.blnConfirma;
          Except
            on E: Exception do
            begin
              raise;
            end;
          End;
        Finally
          if Assigned(frmGravando) then FreeAndNil(frmGravando);
        End;

        If blnConfirma Then
        Begin
          pAssociarEftGor;
          pMensagemOk(Format('Orçamento %s gravado com sucesso!', [fatVenda.strNumDoc]));
          pSetFocus(dbgDados);
        End;

        pInicializaTemporaria;
      end;

    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    pAbrirConsulta;
    pSetFocus(dbgDados);
  End;
end;

procedure TfrmEntregasFuturasTintas.btnMarcaTodosClick(Sender: TObject);
var
  strBookMark: TBookmark;
begin
  Try
    Try
      strBookMark := cdsConsulta.Bookmark;
      cdsConsulta.First;

      while not cdsConsulta.Eof do
      begin
        cdsConsulta.Edit;
        cdsConsulta.FieldByName('SELECIONADO').AsInteger := 1;
        cdsConsulta.Post;
        cdsConsulta.Next;
      end;  
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    cdsConsulta.Bookmark := strBookMark;
    pSetFocus(dbgDados);
  End;
end;

procedure TfrmEntregasFuturasTintas.cdsConsultaAfterScroll(DataSet: TDataSet);
begin
  inherited;
  intRecNo := DataSet.RecNo;
end;

constructor TfrmEntregasFuturasTintas.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Self.blnSepFut := False;
  Self.blnMarcaTodos := False;
  Self.strTabela := '';
  Self.cdsConsulta.SetProvider(Self.dpsConsulta);
  Self.objCadLot := TCadLot.Create(Self);
  pSetCdsVenda(nil);
end;

procedure TfrmEntregasFuturasTintas.dbgDadosDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  if not (cdsConsulta.IsEmpty) then
  begin
    if cdsConsulta.FieldByName('SELECIONADO').AsInteger = 1 then
    begin
      dbgDados.Canvas.Brush.Color:= clInfoBk;
      dbgDados.Canvas.Font.Color:= clBlue;
      dbgDados.Canvas.FillRect(Rect);
    end;

    If (intRecNo = cdsConsulta.RecNo) Then
    Begin
      dbgDados.Canvas.Font.Color  := clWhite;
      dbgDados.Canvas.Brush.Color := clNavy;
      dbgDados.Canvas.FillRect(Rect);
    End;
    dbgDados.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;
end;

procedure TfrmEntregasFuturasTintas.dbgDadosKeyPress(Sender: TObject; var Key: Char);
var
  intCont: Integer;
begin
  if Key = #13 then
  begin
    if (dbgDados.SelectedRows.Count = 0) and (cdsConsulta.RecordCount > 0) then
    begin
      cdsConsulta.Edit;
      cdsConsulta.FieldByName('SELECIONADO').AsInteger := IfThen(cdsConsulta.FieldByName('SELECIONADO').AsInteger = 1, 0, 1);
      cdsConsulta.Post;
    end
    else
    begin
      for intCont := 0 to dbgDados.SelectedRows.Count - 1 do
      begin
        if cdsConsulta.BookmarkValid(Pointer(dbgDados.SelectedRows[intCont])) then
        begin
          cdsConsulta.Bookmark := dbgDados.SelectedRows[intCont];
          cdsConsulta.Edit;
          cdsConsulta.FieldByName('SELECIONADO').AsInteger := IfThen(cdsConsulta.FieldByName('SELECIONADO').AsInteger = 1, 0, 1);
          cdsConsulta.Post;
        end;
      end;
    end;

  end;

end;

procedure TfrmEntregasFuturasTintas.dbgvEntregasFuturasKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE: begin
                 Close;
               end;
  end;
end;

destructor TfrmEntregasFuturasTintas.Destroy;
begin
  if Assigned(objCadLot) then FreeAndNil(objCadLot);
  pFreeCdsVenda;
  if Assigned(fatVenda) then
  begin
    fatVenda.cdsBaiEntFut := nil;
    FreeAndNil(fatVenda);
  end;

  inherited;
end;

function TfrmEntregasFuturasTintas.fGetItem(qryGenIte: TUniQuery; strCodIte: String): Boolean;
var
  strSQL: string;
begin
  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  I.ITE_PESOIT, ';
    strSQL := strSQL + '  I.ITE_PESLIQ, ';    
    strSQL := strSQL + '  I.ITE_DESITE, ';
    strSQL := strSQL + '  I.ITE_DESFAB, ';
    strSQL := strSQL + '  I.ITE_COMLUB, ';
    strSQL := strSQL + '  I.ITE_CLAIPI, ';
    strSQL := strSQL + '  I.ITE_EXCIPI, ';
    strSQL := strSQL + '  I.ITE_CODFAB, ';
    strSQL := strSQL + '  I.ITE_CODBAR, ';
    strSQL := strSQL + '  G.ITE_PRECOM, ';
    strSQL := strSQL + '  G.ITE_PREVE1, ';
    strSQL := strSQL + '  G.ITE_PREVE2, ';
    strSQL := strSQL + '  G.ITE_PREVE3, ';
    strSQL := strSQL + '  G.ITE_PREVE4, ';
    strSQL := strSQL + '  G.ITE_PREVE5, ';
    strSQL := strSQL + '  G.ITE_PREVE6, ';
    strSQL := strSQL + '  G.ITE_PREVE7, ';
    strSQL := strSQL + '  G.ITE_PREULT, ';
    strSQL := strSQL + '  G.ITE_IMPULT, ';
    strSQL := strSQL + '  G.ITE_QTDUCO, ';
    strSQL := strSQL + '  G.ITE_IPISAI, ';
    strSQL := strSQL + '  G.ITE_DESMAX, ';
    strSQL := strSQL + '  G.ITE_SALDOS, ';
    strSQL := strSQL + '  G.ITE_PREMED, ';
    strSQL := strSQL + '  G.ITE_COMVAR, ';
    strSQL := strSQL + '  G.ITE_COMATA, ';
    strSQL := strSQL + '  G.ITE_COMDIS, ';
    strSQL := strSQL + '  G.ITE_MARMIN, ';
    strSQL := strSQL + '  G.ITE_MARMSG, ';
    strSQL := strSQL + '  G.ITE_MARMGE, ';

    strSQL := strSQL + '  G.ITE_DESMVM, ';
    strSQL := strSQL + '  G.ITE_DESMSM, ';
    strSQL := strSQL + '  G.ITE_DESMGM, ';

    strSQL := strSQL + '  G.ITE_MARMMV, ';
    strSQL := strSQL + '  G.ITE_MARMMS, ';
    strSQL := strSQL + '  G.ITE_MARMMG, ';

    strSQL := strSQL + '  G.ITE_IPIENT, ';
    strSQL := strSQL + '  G.ITE_FREENT, ';
    strSQL := strSQL + '  G.ITE_QTPPRO, ';
    strSQL := strSQL + '  A.ABF_CODABF, ';
    strSQL := strSQL + '  M.MAR_DESMAR, ';
    strSQL := strSQL + '  I.ITE_OBRCPF,  ';

    If fCfgSis('IMPDIG') = '1' Then
      strSQL := strSQL + '  I.ITE_IMPDIR  '
    Else
      strSQL := strSQL + '  G.ITE_IMPDIR  ';
      
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADITE I, ';
    strSQL := strSQL + '  ITEGER G, ';
    strSQL := strSQL + '  ABFICM A, ';
    strSQL := strSQL + '  CADMAR M  ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  I.ITE_CODMAR = M.MAR_CODMAR AND ';
    strSQL := strSQL + '  I.ITE_CODITE = G.ITE_CODITE AND ';

    If fCfgSIs('TIPABF') = '1' Then
      strSQL := strSQL + '  I.ITE_CODABF = A.ABF_CODABF AND '
    Else
      strSQL := strSQL + '  G.ITE_CODABF = A.ABF_CODABF AND ';

    strSQL := strSQL + '  I.ITE_CODITE = :CODITE AND ';
    strSQL := strSQL + '  G.ITE_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  A.ABF_ESTADO = :ESTADO ';

    With qryGenIte Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ParamByName('ESTADO').AsString := fCadEmp('ESTADO');
      Open;
    End;

    Result := True;
  Except
    On E: Exception Do
    Begin
      Result := False;
			pMensagensErro(E.Message,'[TfrmEntregasFuturasTintas.fGetItem]');
    End;
  End;
end;

function TfrmEntregasFuturasTintas.fGetQtdItensMarcados: Integer;
var
  strBookMark: TBookmark;
begin
  Result := 0;
  Try
    Try
      cdsConsulta.DisableControls;
      cdsConsulta.DisableConstraints;
      strBookMark := cdsConsulta.Bookmark;
      cdsConsulta.First;

      while not cdsConsulta.Eof do
      begin
        Result := Result + cdsConsulta.FieldByName('SELECIONADO').AsInteger;        
        cdsConsulta.Next;
      end;  
      
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    cdsConsulta.Bookmark := strBookMark;
    cdsConsulta.EnableControls;
    cdsConsulta.EnableConstraints;
  End;
end;

function TfrmEntregasFuturasTintas.fGetSql(): String;

  function fGetFieldsMOVDET(strNomTab: String): String;
    Var
      qryGen: TUniQuery;
  Begin
    qryGen := fCriaQuery;

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('DESCRIBE ' + strNomTab);
      Open;

      Result := EmptyStr;
      While Not Eof Do
      Begin
        Result := Concat(Result, 'D.', FieldByName('Field').asString, ', ');
        Next;
      End;

    End;

    FreeAndNil(qryGen);
  End;

  function fGetSqlTab: String;
  Var
    strSQL,
    strMovDet,
    strMovGer,
    strMovMad,
    strSepFut,
    strAuxMov: String;
  Begin

    strMovGer := 'MOVGER';
    strMovDet := 'MOVDET';
    strMovMad := 'MOVMAD';
    strSepFut := 'SEPFUT';
    strAuxMov := 'AUXMOV';

    strSQL := '';
    strSQL := strSQL + ' SELECT                                ';
    strSQL := strSQL + '   "0" AS SELECIONADO,                   ';
    strSQL := strSQL + '   IFNULL(AUX_ENTGER, "") AS ENTGER,   ';
    strSQL := strSQL +     QuotedStr(strMovDet) + ' AS TABELA, ';

    If blnSepFut Then
      strSQL := strSQL + '   IFNULL(SEP_QTDITE, 0.0000) AS DET_QTDANT, '
    Else
      strSQL := strSQL + '   0.0000 AS DET_QTDANT,               ';

    strSQL := strSQL + '  (SELECT GROUP_CONCAT(CONCAT("-", BAR_CODBAR, "-")) FROM ';
    strSQL := strSQL + '   ITEBAR WHERE CADITE.ITE_CODITE = BAR_CODITE) AS BAREMB,';

    strSQL := strSQL + '   IF(D.DET_CODACA IS NOT NULL AND D.DET_CODACA <> "", ACA_CODBAR, CADITE.ITE_CODBAR) AS CODBAR, ';

    strSQL := strSQL + '   CADITE.ITE_EMBALA AS EMBALA, ';

    strSQL := strSQL + '   D.DET_CODITE AS CODITE,';

    strSQL := strSQL + '   I.ITE_PRECUS, ';

    If (fCfgSis('BEFTRG', VarBoolean)) Then
      strSQL := strSQL + '  ((I.ITE_SALDOS  * IF( IFNULL(ITE_CNV_ML,0) <= 0, 1, ITE_CNV_ML ))) AS ITE_SALDOS, '
    Else
      strSQL := strSQL + '  ((I.ITE_SALDOS  * IF( IFNULL(ITE_CNV_ML,0) <= 0, 1, ITE_CNV_ML )) + (' +
                             fGetSQLSomaCamposEntregaFutura('I') +
                             ' * IF( IFNULL(ITE_CNV_ML,0) <= 0, 1, ITE_CNV_ML ))) AS ITE_SALDOS, ';

    strSQL := strSQL + '   GER_DTAENT,         ';
    strSQL := strSQL + '   D.DET_DTAFUT,       ';
    strSQL := strSQL + '   D.DET_DTAFUT AS DTAFUT, ';    
    strSQL := strSQL + '   GER_NUMDOC,         ';
    strSQL := strSQL + '   GER_ESPDOC,         ';
    strSQL := strSQL + '   GER_CODEMP,         ';
    strSQL := strSQL + '   GER_CODCLI,         ';
    strSQL := strSQL + '   GER_SERIE_,         ';
    strSQL := strSQL + '   GER_CONENT,         ';
    strSQL := strSQL + '   GER_MEN001,         ';
    strSQL := strSQL + '   GER_MEN002,         ';

    {*******************************}
    {* INICIO DADOS DO CONSUMIDOR  *}
    {****************************JC*}
    strSql := strSql + '   GER_NOMCON, ';
    strSql := strSql + '   GER_ENDCON, ';
    strSql := strSql + '   GER_BAICON, ';
    strSql := strSql + '   GER_CEPCON, ';
    strSql := strSql + '   GER_CIDCON, ';
    strSql := strSql + '   GER_ESTCON, ';
    strSql := strSql + '   GER_TELCON, ';
    strSql := strSql + '   AUX_NASCON, ';
    strSql := strSql + '   GER_CGCCPF, ';
    strSql := strSql + '   GER_CGCCON, ';
    strSql := strSql + '   GER_IESCON, ';
    strSql := strSql + '   GER_R_GCON, ';
    strSql := strSql + '   GER_EMLCON, ';
    {****************************}
    {* FIM DADOS DO CONSUMIDOR  *}
    {*************************JC*}

    strSQL := strSQL + '   CADITE.ITE_CODGRU,  ';
    strSQL := strSQL + '   CADITE.ITE_DIAFOR,  ';
    strSQL := strSQL + '   D.DET_SEQGER,       ';

    strSQL := strSQL + fGetFieldsMOVDET('MOVDET');

    if not Assigned(fatVenda) then
      fatVenda := TFatVenda.Create(Nil);

    If fatVenda.fUtilizaVendaMadeiraOuVidroOuMetroLinear Then
    Begin
      strSQL := strSQL + '   DET_APAREL,         ';
      strSQL := strSQL + '   DET_PERAPA,         ';
      strSQL := strSQL + '   DET_BENEFI,         ';
      strSQL := strSQL + '   DET_PERBEN,         ';
      
      strSQL := strSQL + '   DET_QTDPEC,         ';
      strSQL := strSQL + '   DET_COMPEC,         ';
      strSQL := strSQL + '   DET_LARPEC,         ';
      strSQL := strSQL + '   DET_ESPPEC,         ';
    End;

    strSQL := strSQL + '   IFNULL(D.DET_QTDENT,0) AS DET_QTDENT, ';
    strSQL := strSQL + '   IFNULL(D.DET_QTDENT,0) AS QTDENT, ';
    strSQL := strSQL + '   "                    " AS DET_NOVLOT, ';

    strSQL := strSQL + ' (D.DET_QTDITE - IFNULL(D.DET_QTDENT,0)) AS DET_QTDPEN, ';

    strSQL := strSQL + '  SEP_CODSEP AS CODSEP, ';        

    If blnSepFut Then
    Begin
      strSQL := strSQL + '   IF(IFNULL(SEP_QTDITE, 0) > 0, "S", "N") AS SEPIMP, ';
      strSQL := strSQL + '   IFNULL(SEP_QTDITE, 0) AS DET_QTDAEN, ';
    End
    Else
    Begin
      If blnMarcaTodos Then
        strSQL := strSQL + '   CAMPODIF AS DET_QTDAEN, '
      Else
        strSQL := strSQL + '   0.0000      DET_QTDAEN, ';
    End;

    strSQL := strSQL + '   IF(IFNULL(D.DET_NUMLOT, "") = "", ITE_LOCFIS, LOT_LOCFIS) AS ITE_LOCFIS, ';
    strSQL := strSQL + '   MAR_DESMAR, ';
    strSQL := strSQL + '   UNI_SIGUNI  ';
    strSQL := strSQL + '   , IF(IFNULL(D.DET_VOLPRO, 0) = 0, UNI_SIGUNI, D.DET_VOLPRO) AS VOLPRO  ';
    strSQL := strSQL + '   , D.AUTOINCREM AS CHAVE  ';
    strSQL := strSQL + '   , T.*   ';
    strSQL := strSQL + '   , TD.*   ';

    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + strMovDet + ' D ';

    strSQL := strSQL + ' INNER JOIN ' + strMovGer + ' G ON ';
    strSQL := strSQL + '   G.AUTOINCREM = D.DET_SEQGER  ';
{    strSQL := strSQL + '   AND GER_ENTFUT = "S"                ';
    strSQL := strSQL + '   AND D.DET_IDEPRO <> "NOR"       ';

    If (fCfgSis('CONENT', varBoolean)) and (fCfgSis('COENFI', varBoolean)) Then
    Begin

      If ((fCfgSis('EMPGER', varBoolean))) Then
      Begin
        strSQL := strSQL + ' AND (GER_CODEMP = ' + QuotedStr(fCfgSis('EMPMAT')) + ' OR ';
        strSQL := strSQL + '      GER_CONENT = "S") ';
      End
      Else
      Begin
        strSQL := strSQL + ' AND GER_CONENT = "N" ';
        strSQL := strSQL + ' AND GER_CODEMP = ' + QuotedStr(VS_strCodEmp);
      End;

    End

    Else strSQL := strSQL + ' AND GER_CODEMP = ' + QuotedStr(VS_strCodEmp);}

    strSQL := strSQL + ' INNER JOIN CADITE ON CADITE.ITE_CODITE = D.DET_CODITE ';

    strSQL := strSQL + ' INNER JOIN ITEGER I ON ';
    strSQL := strSQL + '    I.ITE_CODITE = CADITE.ITE_CODITE AND ';
    strSQL := strSQL + '    I.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp);

    strSQL := strSQL + ' LEFT JOIN ' + strAuxMov + ' A ON A.AUX_SEQGER = G.AUTOINCREM ';

    If fatVenda.fUtilizaVendaMadeiraOuVidroOuMetroLinear Then
      strSQL := strSQL + ' LEFT JOIN ' + strMovMad + ' M ON M.DET_SEQGER = D.AUTOINCREM  ';

    strSQL := strSQL + ' LEFT JOIN CADACA ON ACA_CODACA = D.DET_CODACA AND ';
    strSQL := strSQL + '                     ACA_CODEMP = D.DET_EMPACA     ';

    strSQL := strSQL + ' LEFT JOIN ' + strSepFut + ' S ON S.SEP_SEQGER = D.AUTOINCREM  ';

    strSQL := strSQL + ' LEFT JOIN CADMAR ON ITE_CODMAR = MAR_CODMAR ';
    strSQL := strSQL + ' LEFT JOIN CADUNI ON D.DET_UNIDAD = UNI_CODUNI ';
    strSQL := strSQL + ' LEFT JOIN CADLOT ON LOT_NUMLOT = D.DET_NUMLOT AND LOT_CODITE = D.DET_CODITE AND LOT_CODEMP = D.DET_CODEMP ';
    strSQL := strSQL + ' LEFT JOIN FORTIN T ON D.DET_CODACA = FOR_CODACA AND D.DET_EMPACA = FOR_EMPACA ';
    strSQL := strSQL + ' LEFT JOIN TINDET TD ON D.DET_CODACA = TD.DET_CODACA AND D.DET_EMPACA = TD.DET_EMPACA ';
    strSQL := strSQL + ' LEFT JOIN EFTGOR EFT ON D.DET_CODACA = EFT.FGO_CODACA AND D.DET_EMPACA = EFT.FGO_EMPACA ';

    strSQL := strSQL + ' WHERE ';

    strSQL := strSQL + '       D.DET_ENTFUT = "S"          ';
    strSQL := strSQL + '   AND D.DET_EFBAIX = "N"          ';
    strSQL := strSQL + '   AND D.DET_IDEPRO <> "NOR"       ';
    strSQL := strSQL + '   AND D.DET_PROEMB <> "S"                                ';
    strSQL := strSQL + '   AND (D.DET_ESPDOC NOT IN ("ML", "PR", "TM"))           ';
    strSQL := strSQL + '   AND ROUND(D.DET_QTDITE - IFNULL(D.DET_QTDENT,0),4) > 0 ';
    strSQL := strSQL + '   AND EFT.FGO_NUMDOC IS NULL                             ';

    If (fCfgSis('CONENT', varBoolean)) and (fCfgSis('COENFI', varBoolean)) Then
    Begin

      If ((fCfgSis('EMPGER', varBoolean))) Then
      Begin
        strSQL := strSQL + ' AND (GER_CODEMP = ' + QuotedStr(fCfgSis('EMPMAT')) + ' OR ';
        strSQL := strSQL + '      GER_CONENT = "S") ';
      End
      Else
      Begin
        strSQL := strSQL + ' AND GER_CONENT = "N" ';
        strSQL := strSQL + ' AND GER_CODEMP = ' + QuotedStr(VS_strCodEmp);
      End;

    End

    Else strSQL := strSQL + ' AND D.DET_CODEMP = ' + QuotedStr(VS_strCodEmp);

    strSQL := strSQL + ' GROUP BY D.AUTOINCREM ';
    Result := strSQL;
  End;

Begin

  Result := fGetSqlTab;

  If blnMarcaTodos Then
    Result := AnsiReplaceStr(Result,'CAMPODIF','ROUND(D.DET_QTDITE - IFNULL(D.DET_QTDENT,0),4)');

end;

function TfrmEntregasFuturasTintas.fIncluiItens(pgbProgresso: TcxProgressBar): Boolean;
var
  qryGenIte: TUniQuery;
  intContador: Integer;
  strMen001: String;
  strMen002: String;
  strNoDoc: string;
  strQtdDoc: String;
  recForTin: TForTin;
  strNumLot: String;
  strLotAnt: String;
  strMsgEfu: String;
  recMadeira: TDadosMadeira;
  dicRetorno: TDicionario;
  fltPrvTin: Double;
  fltPrcTin: Double;
  fltUniTar: Double;
  strOpcPre: string;
  fltPreVen: Double;

  procedure RegistrarProgresso(const intInicio, intAtual, intFinal: Integer);
  begin
    pgbProgresso.Properties.Max := intFinal;
    pgbProgresso.Properties.Min := intInicio;
    pgbProgresso.Position := intAtual;
    Application.ProcessMessages;
  end;

  procedure RegistrarTexto(const strTexto: string);
  begin
    If Assigned(pgbProgresso) And (GetParentForm(pgbProgresso).FindComponent('lblGravando') <> Nil) Then
    Begin
      TLabel(GetParentForm(pgbProgresso).FindComponent('lblGravando')).Caption := strTexto;
      Application.ProcessMessages;
    End;
  end;  
begin
  Result := False;
  dicRetorno := nil;
  Try
    Try
      qryGenIte := fCriaQuery;
      strMsgEfu := fCfgSis('MSGEFU');

      intContador := 0;
      cdsConsulta.First;

      strNoDoc := '';
      strQtdDoc := '1';

      If cdsConsulta.FieldByName('DET_QTDITE').AsFloat > 0 Then
        strNoDoc := cdsConsulta.FieldByName('DET_NUMDOC').AsString;

      dicRetorno := TDicionario.Create;

      fatVenda.fltFat_TE := fRetClienteFilialFatorTE(IIF(fEmptyStr(fatVenda.strEmp_TE),VS_strCodEmp,fatVenda.strEmp_TE), fatVenda.strCodCli);
      fatVenda.fltFatTE2 := fRetClienteFilialFatorTE_ST(IIF(fEmptyStr(fatVenda.strEmp_TE),VS_strCodEmp,fatVenda.strEmp_TE), fatVenda.strCodCli);
      fatVenda.strTEPREV := fGetTEPREV(IIF(fEmptyStr(fatVenda.strEmp_TE),VS_strCodEmp,fatVenda.strEmp_TE), fatVenda.strCodCli);
      strOpcPre := fatVenda.strTEPREV;

      RegistrarTexto('Incluindo os Produtos no Orçamento');
      while not cdsConsulta.Eof do
      begin
        If cdsConsulta.FieldByName('SELECIONADO').AsInteger = 1 Then
        Begin
          inc(intContador);

          If (intContador = 1) Then
          Begin
            fatVenda.strCodVen := cdsConsulta.FieldByName('DET_CODVEN').AsString;
            fatVenda.strNomVen := fRetNomVendRep(fatVenda.strCodVen);
            fatVenda.FSepExp   := cdsConsulta.FieldByName('CODSEP').AsString;

            {*********************************************}
            {* CASO TENHA SELECIONADO CLIENTE CONSUMIDOR *}
            {******************************************JC*}
            If fClienteConsumidor(fRetNomCliente(cdsConsulta.FieldByName('GER_CODCLI').AsString)) Then
            Begin
              fatVenda.strCliNom := cdsConsulta.FieldByName('GER_NOMCON').AsString;
              fatVenda.strCliEnd := cdsConsulta.FieldByName('GER_ENDCON').AsString;
              fatVenda.strCliBai := cdsConsulta.FieldByName('GER_BAICON').AsString;
              fatVenda.strCliCep := cdsConsulta.FieldByName('GER_CEPCON').AsString;
              fatVenda.strCodCid := cdsConsulta.FieldByName('GER_CIDCON').AsString;
              fatVenda.strCliCid := fRetNomCidade(fatVenda.strCodCid);
              fatVenda.strCliEst := cdsConsulta.FieldByName('GER_ESTCON').AsString;
              fatVenda.strCliTel := cdsConsulta.FieldByName('GER_TELCON').AsString;
              fatVenda.dtaNasCon := cdsConsulta.FieldByName('AUX_NASCON').AsDateTime;
              fatVenda.intCgcCpf := cdsConsulta.FieldByName('GER_CGCCPF').AsInteger;
              fatVenda.strCliCgc := cdsConsulta.FieldByName('GER_CGCCON').AsString;
              fatVenda.strCliIes := cdsConsulta.FieldByName('GER_IESCON').AsString;
              fatVenda.strCli_Rg := cdsConsulta.FieldByName('GER_R_GCON').AsString;
              fatVenda.strCliEma := cdsConsulta.FieldByName('GER_EMLCON').AsString;
            End;

          End;

          fGetItem(qryGenIte,cdsConsulta.FieldByName('DET_CODITE').AsString);
          pProcessarTabelasPrecosTintas(dicRetorno);

          If Pos(cdsConsulta.FieldByName('DET_NUMDOC').AsString + '-' + cdsConsulta.FieldByName('DET_ESPDOC').AsString,fatVenda.strMen001) <= 0 Then
            fatVenda.strMen001 := fatVenda.strMen001 +
                                  cdsConsulta.FieldByName('DET_NUMDOC').AsString + '-' + cdsConsulta.FieldByName('DET_ESPDOC').AsString + ',';

          If Pos(cdsConsulta.FieldByName('DET_CODVEN').AsString + '-' + fRetNomVendRep(cdsConsulta.FieldByName('DET_CODVEN').AsString), fatVenda.strMen002) <= 0 Then
            fatVenda.strMen002 := fatVenda.strMen002 +
                                  cdsConsulta.FieldByName('DET_CODVEN').AsString + '-' + fRetNomVendRep(cdsConsulta.FieldByName('DET_CODVEN').AsString) + ', ';

          arrMenDoc[1] := fatVenda.strMen001;
          arrMenDoc[2] := fatVenda.strMen002;

          If (strMsgEfu = 'S') Then
          Begin
            strMen001 := cdsConsulta.FieldByName('GER_MEN001').AsString;
            strMen002 := cdsConsulta.FieldByName('GER_MEN002').AsString;
          End;

          strNumLot := cdsConsulta.FieldByName('DET_NUMLOT').AsString;
          strLotAnt := '';

          If SameText(strNumLot, 'A DEFINIR') Then
          Begin
            strLotAnt := 'A DEFINIR';
            If Not fTrocaLotePadrao(strNumLot) Then
            Begin
              fMensagem('','É obrigatório a informação de um ' + objCadLot.strTitLab + ' válido' + #13#10 +
                           'para este item desta baixa de Entrega Futura!', ['&Ok']);
              Result := False;
              Exit;
            End;
          End;

          fatVenda.strEntGer := cdsConsulta.FieldByName('ENTGER').AsString;

          FillChar(recMadeira, SizeOf(recMadeira), #0);

          If fatVenda.fUtilizaVendaMadeiraOuVidroOuMetroLinear Then
          Begin
            recMadeira.fltComPec := cdsConsulta.FieldByName('DET_COMPEC').AsFloat;
            recMadeira.fltLarPec := cdsConsulta.FieldByName('DET_LARPEC').AsFloat;
            recMadeira.fltEspPec := cdsConsulta.FieldByName('DET_ESPPEC').AsFloat;

            recMadeira.fltQtdPec := fCalculaQuantidadePecas(cdsConsulta.FieldByName('DET_QTDITE').AsFloat,
                                                            recMadeira.fltComPec,
                                                            recMadeira.fltLarPec,
                                                            recMadeira.fltEspPec,
                                                            fRetSiglaUnidade(cdsConsulta.FieldByName('DET_UNIDAD').AsString));

            recMadeira.strAparel := cdsConsulta.FieldByName('DET_APAREL').AsString;
            recMadeira.fltPerApa := cdsConsulta.FieldByName('DET_PERAPA').AsFloat;
            recMadeira.strBenefi := cdsConsulta.FieldByName('DET_BENEFI').AsString;
            recMadeira.fltPerBen := cdsConsulta.FieldByName('DET_PERBEN').AsFloat;
          End;

          fltPrvTin := IfNull(dicRetorno['preve' + fatVenda.strTabPre], 0.0);

          If strOpcPre = 'VE1' Then
            fltPrvTin := IfNull(dicRetorno['preve1'], 0.0)
          Else If strOpcPre = 'VE2' Then
            fltPrvTin := IfNull(dicRetorno['preve2'], 0.0)
          Else If strOpcPre = 'VE3' Then
            fltPrvTin := IfNull(dicRetorno['preve3'], 0.0)
          Else If strOpcPre = 'VE4' Then
            fltPrvTin := IfNull(dicRetorno['preve4'], 0.0)
          Else If strOpcPre = 'VE5' Then
            fltPrvTin := IfNull(dicRetorno['preve5'], 0.0)
          Else If strOpcPre = 'VE6' Then
            fltPrvTin := IfNull(dicRetorno['preve6'], 0.0)
          Else If strOpcPre = 'VE7' Then
            fltPrvTin := IfNull(dicRetorno['preve7'], 0.0)
          Else If strOpcPre = 'CUS' Then
            fltPrvTin := IfNull(dicRetorno['precus'], 0.0);

          If fatVenda.fltFat_TE > 0 Then
          Begin
            If (cdsConsulta.FieldByName('DET_PROMOC').AsString <> 'S') Then
              fltPrvTin := fltPrvTin * fatVenda.fltFat_TE;
          End;  

          fltPreVen := fltPrvTin;
          fatVenda.fltTaxJur := 0.00;

          If (fatVenda.fAplicaTaxaJuros) Then
          Begin
            If fAplicarTaxaJurosPrecoSugestao Then
            Begin
              fatVenda.fltTaxJur := fatVenda.fGetTaxVprItem(cdsConsulta.FieldByName('DET_CODITE').AsString);
              fltPreVen := fltPreVen + fFormataFloat(fltPreVen * (fatVenda.fGetTaxVprItem(cdsConsulta.FieldByName('DET_CODITE').AsString) / 100.0), 04);
            End;
          End;

          fatVenda.fltUniOri := fltPreVen;
          fatVenda.fltUniVis := fltPrvTin;

          fltPrcTin := IfNull(dicRetorno['precus'], 0.0);
          fltUniTar := fFormataFloat(fltPreVen, fCfgSis('DECUNI', varInteger));

          fatVenda.pAdicionaRegistroTemporaria(cdsVenda,
                                               Nil,
                                               cdsConsulta.FieldByName('DET_IDEPRO').AsString,
                                               cdsConsulta.FieldByName('ITE_CODGRU').AsString,
                                               cdsConsulta.FieldByName('DET_CODITE').AsString,
                                               cdsConsulta.FieldByName('DET_DESCRI').AsString,
                                               cdsConsulta.FieldByName('DET_DESCRI').AsString,
                                               qryGenIte.FieldByName('ITE_DESFAB').AsString,
                                               cdsConsulta.FieldByName('DET_UNIDAD').AsString,
                                               cdsConsulta.FieldByName('DET_UNIDAD').AsString,
                                               cdsConsulta.FieldByName('DET_CODMAR').AsString,
                                               cdsConsulta.FieldByName('DET_CODFOR').AsString,
                                               cdsConsulta.FieldByName('DET_REFERE').AsString,
                                               fatVenda.fltUniOri,
                                               fatVenda.fltUniVis,
                                               fltUniTar,
                                               0.0,
                                               cdsConsulta.FieldByName('DET_DESCON').AsFloat,
                                               cdsConsulta.FieldByName('DET_QTDITE').AsFloat,
                                               fltUniTar * cdsConsulta.FieldByName('DET_QTDITE').AsFloat,
                                               'S',
                                               fltPrcTin,
                                               fltPrcTin * cdsConsulta.FieldByName('DET_QTDITE').AsFloat,
                                               qryGenIte.FieldByName('ITE_COMLUB').AsString,
                                               qryGenIte.FieldByName('ITE_IPISAI').AsFloat,
                                               qryGenIte.FieldByName('ITE_DESMAX').AsFloat,
                                               IfNull(dicRetorno['preve1'], 0.0),
                                               IfNull(dicRetorno['preve2'], 0.0),
                                               IfNull(dicRetorno['preve3'], 0.0),
                                               IfNull(dicRetorno['preve4'], 0.0),
                                               IfNull(dicRetorno['preve5'], 0.0),
                                               IfNull(dicRetorno['preve6'], 0.0),
                                               IfNull(dicRetorno['preve7'], 0.0),
                                               fCalculaPrecoVenda(2, fFormataFloat(fltPrcTin * cdsConsulta.FieldByName('DET_QTDITE').AsFloat, 2), fltUniTar, 0, 0, 0, 0, 0),
                                               qryGenIte.FieldByName('ITE_SALDOS').AsFloat,
                                               cdsConsulta.FieldByName('DET_INCPIS').AsString,
                                               qryGenIte.FieldByName('ITE_COMVAR').AsFloat,
                                               qryGenIte.FieldByName('ITE_COMATA').AsFloat,
                                               qryGenIte.FieldByName('ITE_COMDIS').AsFloat,
                                               cdsConsulta.FieldByName('DET_DOCDEV').AsString,
                                               cdsConsulta.FieldByName('DET_ESPDEV').AsString,
                                               cdsConsulta.FieldByName('DET_EMPDEV').AsString,
                                               0,
                                               0,
                                               '',
                                               0,
                                               0,
                                               0,
                                               IfNull(dicRetorno['premed'], 0.0),
                                               qryGenIte.FieldByName('ITE_CLAIPI').AsString,
                                               cdsConsulta.FieldByName('DET_ITECHA').AsString,
                                               cdsConsulta.FieldByName('DET_ITETIN').AsString,
                                               cdsConsulta.FieldByName('DET_DESCOR').AsString,
                                               cdsConsulta.FieldByName('DET_TIPPRE').AsString,
                                               cdsConsulta.FieldByName('DET_LAZQUA').AsInteger,
                                               cdsConsulta.FieldByName('DET_TIPEMB').AsString,
                                               cdsConsulta.FieldByName('DET_QTDEMB').AsFloat,
                                               cdsConsulta.FieldByName('DET_PREEMB').AsFloat,
                                               fltPrvTin,
                                               fltPrcTin,
                                               fGetFatorML(cdsConsulta.FieldByName('DET_IDEPRO').AsString),
                                               'N',
                                               cdsConsulta.FieldByName('DET_ITEEMB').AsString,
                                               0,
                                               0,
                                               qryGenIte.FieldByName('ABF_CODABF').AsString,
                                               qryGenIte.FieldByName('ITE_PESOIT').AsFloat,
                                               qryGenIte.FieldByName('ITE_PESLIQ').AsFloat,
                                               cdsConsulta.FieldByName('DET_PROMOC').AsString,
                                               0,
                                               0,
                                               0,
                                               0,
                                               IIF(fEmptyStr(cdsConsulta.FieldByName('DET_SEQTIN').AsString), '', '2'),
                                               fatVenda.fRetPerComGrupo(cdsConsulta.FieldByName('ITE_CODGRU').AsString),
                                               qryGenIte.FieldByName('ITE_CODFAB').AsString,
                                               -1,
                                               0,
                                               '',
                                               '',
                                               '',
                                               qryGenIte.FieldByName('ITE_MARMIN').AsFloat,
                                               qryGenIte.FieldByName('ITE_MARMSG').AsFloat,
                                               qryGenIte.FieldByName('ITE_MARMGE').AsFloat,
                                               fRetNomMarca(cdsConsulta.FieldByName('DET_CODMAR').AsString),
                                               '',
                                               0,
                                               0,
                                               cdsConsulta.FieldByName('CHAVE').AsString,
                                               cdsConsulta.FieldByName('DET_CATALI').AsString,
                                               cdsConsulta.FieldByName('DET_LINLIN').AsString,
                                               cdsConsulta.FieldByName('EMBALA').AsFloat,
                                               cdsConsulta.FieldByName('DET_DESNES').AsString,
                                               '',
                                               '',                                               
                                               qryGenIte.FieldByName('ITE_PRECOM').AsFloat,
                                               fltPrvTin,
                                               qryGenIte.FieldByName('ITE_QTPPRO').AsFloat,
                                               '',
                                               '',
                                               qryGenIte.FieldByName('ITE_OBRCPF').AsString,
                                               cdsConsulta.FieldByName('DET_MONTAD').AsString,
                                               cdsConsulta.FieldByName('DET_A_N_O_').AsString,
                                               fRetSiglaUnidade(cdsConsulta.FieldByName('DET_UNIDAD').AsString),
                                               cdsConsulta.FieldByName('DET_VOLPRO').AsFloat,
                                               intContador,
                                               '',
                                               cdsConsulta.FieldByName('DET_CODACA').AsString,
                                               cdsConsulta.FieldByName('DET_EMPACA').AsString,
                                               cdsConsulta.FieldByName('DET_PROACA').AsString = 'S',
                                               cdsConsulta.FieldByName('DET_ESPDOC').AsString,
                                               cdsConsulta.FieldByName('DET_NUMDOC').AsString,
                                               cdsConsulta.FieldByName('DET_CODEMP').AsString,
                                               IfNull(dicRetorno['outval'], 0),
                                               0,
                                               IfNull(dicRetorno['desope'] / dicRetorno['preve' + fatVenda.strTabPre] * 100, 0),
                                               IfNull(dicRetorno['icmsai'] / dicRetorno['preve' + fatVenda.strTabPre] * 100, 0),
                                               IfNull(dicRetorno['impfed'] / dicRetorno['preve' + fatVenda.strTabPre] * 100, 0),
                                               0,
                                               '',
                                               '',
                                               '',
                                               cdsConsulta.FieldByName('DET_TABPRE').AsString,
                                               qryGenIte.FieldByName('ITE_IPIENT').AsFloat,
                                               qryGenIte.FieldByName('ITE_FREENT').AsFloat,
                                               cdsConsulta.FieldByName('DET_CODDIL').AsString,
                                               cdsConsulta.FieldByName('DET_PORDIL').AsFloat,
                                               cdsConsulta.FieldByName('DET_DILCON').AsString,
                                               cdsConsulta.FieldByName('DET_PORCAT').AsFloat,
                                               '',
                                               '',
                                               'N',
                                               cdsConsulta.FieldByName('DET_MOTFUT').AsString,
                                               cdsConsulta.FieldByName('DET_DTAENT').AsDateTime,
                                               cdsConsulta.FieldByName('DET_QTDITE').AsFloat,
                                               cdsConsulta.FieldByName('DET_DESESP').AsFloat,
                                               0,
                                               qryGenIte.FieldByName('ITE_IMPDIR').AsString,
                                               cdsConsulta.FieldByName('ITE_LOCFIS').AsString,
                                               IfNull(dicRetorno['precu2'], 0.0),
                                               IfNull(dicRetorno['precu2'], 0.0) * cdsConsulta.FieldByName('DET_QTDITE').AsFloat,
                                               0,
                                               0,
                                               0,
                                               0,
                                               0,
                                               0,
                                               recForTin,
                                               cdsConsulta.FieldByName('DET_KEY_EP').AsString,
                                               strLotAnt,
                                               strNumLot,
                                               cdsConsulta.FieldByName('DET_EMPPRD').AsString,
                                               '',
                                               False,
                                               cdsConsulta.FieldByName('DET_PIGBAS').AsString,
                                               'NOR',
                                               0,
                                               '',
                                               qryGenIte.FieldByName('ITE_CODBAR').AsString,
                                               '',
                                               0,
                                               0,
                                               0,
                                               '',
                                               1,
                                               True,
                                               '',
                                               '',
                                               '',
                                               0,
                                               fltPrcTin,
                                               '',
                                               cdsConsulta.FieldByName('DET_ORDPRO').AsString,
                                               recMadeira,
                                               0,
                                               0,
                                               fatVenda.fltTaxJur,
                                               '',
                                               0,
                                               '',
                                               '',
                                               0,
                                               0,
                                               '',
                                               '',
                                               0,
                                               '',
                                               'N',
                                               0,
                                               0,
                                               0,
                                               False,
                                               False,
                                               'N',
                                               '',
                                               0,
                                               0,
                                               '',
                                               'N',
                                               0,
                                               '',
                                               '',
                                               '',
                                               '',
                                               qryGenIte.FieldByName('ITE_EXCIPI').AsString,
                                               0.00,
                                               '',
                                               '',
                                               '',
                                               'S',
                                               'N',
                                               '',
                                               '',
                                               '',
                                               '',
                                               False,
                                               -1,
                                               -1,
                                               'N',
                                               '',
                                               'N',
                                               0,
                                               0,
                                               0,
                                               '',
                                               0,
                                               0,
                                               0,
                                               '',
                                               0,
                                               0,
                                               0,
                                               '',
                                               '',
                                               0,
                                               0,
                                               0,
                                               False,
                                               '',
                                               '',
                                               '',
                                               '',
                                               '',
                                               0,
                                               0,
                                               0,
                                               0,
                                               0,
                                               0,
                                               0,
                                               '',
                                               '',
                                               0,
                                               0,
                                               '',
                                               '',
                                               'N',
                                               'N',
                                               '',
                                               0,
                                               0,
                                               '',
                                               '',
                                               '',
                                               '',
                                               '',
                                               '',
                                               '',
                                               '',
                                               '',
                                               0,
                                               0,
                                               0,
                                               qryGenIte.FieldByName('ITE_MARMMV').AsFloat,
                                               qryGenIte.FieldByName('ITE_MARMMS').AsFloat,
                                               qryGenIte.FieldByName('ITE_MARMMG').AsFloat);

          If cdsConsulta.FieldByName('DET_QTDITE').AsFloat > 0 Then
          begin
            If Not (fEmptyStr(strNoDoc)) Then
            begin
              If (strQtdDoc <> '+1') Then
              begin
                If strNoDoc <> cdsConsulta.FieldByName('DET_NUMDOC').AsString Then
                Begin
                  strNoDoc := cdsConsulta.FieldByName('DET_NUMDOC').AsString;
                  strQtdDoc := '+1';
                End;
              end;
            end;
          end;
        End;

        cdsConsulta.Next;
        RegistrarProgresso(0, cdsConsulta.RecNo, cdsConsulta.RecordCount);
      End;

      If strQtdDoc = '+1' Then
      Begin
        strMen001 := fatVenda.strMen001;
        System.Delete(strMen001,Length(strMen001),1);
        fatVenda.strMen001 := strMen001;
        fatVenda.strMen002 := LeftStr(fatVenda.strMen002, Length(fatVenda.strMen002)-2);
      End
      Else
      Begin

        If fEmptyStr(strMen001) Then
        Begin
          strMen001 := fatVenda.strMen001;
          System.Delete(strMen001,Length(strMen001),1);
        End;

        fatVenda.strMen001 := strMen001;
        fatVenda.strMen002 := strMen002;
      End;

      Result := TRUE;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryGenIte) then FreeAndNil(qryGenIte);
    if Assigned(dicRetorno) then FreeAndNil(dicRetorno);
  End;
end;

procedure TfrmEntregasFuturasTintas.FormShow(Sender: TObject);
begin
  pAbrirConsulta;
end;

function TfrmEntregasFuturasTintas.fRetornaEmpresaTE: Boolean;
begin
  Result := False;
  frmSelecionaEmpresaTE := nil;
  Try
    Try
      pCriarFormularios(TfrmSelecionaEmpresaTE, frmSelecionaEmpresaTE);
      frmSelecionaEmpresaTE.ShowModal;
      Result := (frmSelecionaEmpresaTE.ModalResult = mrOk);
      If Result Then
        fatVenda.strEmp_TE := frmSelecionaEmpresaTE.strEmp_TE;
    Except
      on E: Exception do
      begin
        pMensagensErro(E.Message, '');
      end;
    End;
  Finally
    if Assigned(frmSelecionaEmpresaTE) then FreeAndNil(frmSelecionaEmpresaTE);
  End;
end;

function TfrmEntregasFuturasTintas.fTrocaLotePadrao(var strNovoLote: String): Boolean;
var
  frmDigCodigoLote: TfrmDigCodigoLote;
  blnConfirma: Boolean;
begin
  Result := false;
  Try
    Try
      Application.ProcessMessages;
      pCriarFormularios(TfrmDigCodigoLote, frmDigCodigoLote);
      frmDigCodigoLote.edtCodIte.Text := cdsConsulta.FieldByName('DET_CODITE').AsString;
      frmDigCodigoLote.edtDesIte.Text := cdsConsulta.FieldByName('DET_DESCRI').AsString;
      frmDigCodigoLote.edtCodEmp.Text := cdsConsulta.FieldByName('DET_CODEMP').AsString;
      Application.ProcessMessages;
      blnConfirma := (frmDigCodigoLote.ShowModal = mrOk);

      If (blnConfirma) Then
      Begin
        strNovoLote := frmDigCodigoLote.edtNumLot.Text;

        //cdsConsulta.Edit;
        //cdsConsulta.FieldByName('DET_NOVLOT').AsString := strNovoLote;
        //cdsConsulta.Post;
      End;
      Result := blnConfirma;
    Except
      on E: Exception do
      begin
        pMensagensErro(E.Message, '[TfrmEntregasFuturasTintas.fTrocaLotePadrao]');
      end;
    End;
  Finally
    if Assigned(frmDigCodigoLote) then FreeAndNil(frmDigCodigoLote);
  End;

end;

procedure TfrmEntregasFuturasTintas.pAbrirConsulta;
begin
  dbgDados.DataSource := nil;
  cdsConsulta.Close;
  qryConsulta.Close;

  qryConsulta.SQL.Text := fGetSql();
  qryConsulta.Open;
  pSetaClient(qryConsulta);
  dpsConsulta.DataSet := qryConsulta;
  cdsConsulta.SetProvider(dpsConsulta);
  cdsConsulta.Open;
  dbgDados.DataSource := dtsConsulta;
  dbgDados.Enabled := True;
  cdsConsulta.EnableConstraints;
  cdsConsulta.EnableControls;
  cdsConsulta.First;

  Application.ProcessMessages;
end;

procedure TfrmEntregasFuturasTintas.pAssociarEftGor;
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    Try
      cdsConsulta.DisableConstraints;
      cdsConsulta.DisableControls;
      qryGen := fCriaQuery();
      cdsConsulta.First;

      while not cdsConsulta.Eof do
      begin
        if cdsConsulta.FieldByName('SELECIONADO').AsInteger = 1 then
        begin
          qryGen.SQL.Text := TDDLFactory.GetInsert('EFTGOR');
          qryGen.ParamByName('FGO_NUMDOC').AsString := fatVenda.strNumDoc;
          qryGen.ParamByName('FGO_ESPDOC').AsString := fatVenda.strEspDoc;
          qryGen.ParamByName('FGO_EMPDOC').AsString := fatVenda.strEmpDoc;
          qryGen.ParamByName('FGO_CODACA').AsString := cdsConsulta.FieldByName('DET_CODACA').AsString;
          qryGen.ParamByName('FGO_EMPACA').AsString := cdsConsulta.FieldByName('DET_EMPACA').AsString;
          qryGen.ExecSQL;
        end;
        cdsConsulta.Next;
      end;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryGen) then FreeAndNil(qryGen);
    cdsConsulta.EnableConstraints;
    cdsConsulta.EnableControls;
  End;                              
end;

procedure TfrmEntregasFuturasTintas.pCarregarCliente(fatVenda: TFatVenda);
begin
  fatVenda.pCarregaDadosClienteBaixa(fRetornaClienteFilial(VS_strCodEmp));
  fatVenda.strCodDig := strLoginUsuarioLogado;                  // Digitador     - Codigo
  fatVenda.strNomVen := fRetNomVendRep(fatVenda.strCodVen);     // Vendedor      - Nome
  fatVenda.strNomDig := fRetNomVendRep(fatVenda.strCodDig);     // Digitador     - Nome
  fatVenda.strCodDiv := '';
  fatVenda.strConPag := '01000';
  fatVenda.strCndFor := fFormataCondPag(fatVenda.strConPag); // Condição de pagamento formatada

  If (fCfgSis('USACND', varBoolean)) Then
  Begin
    fatVenda.strCodCnd := fCfgSis('CNDAVI', varString);                // Condicao      - Codigo
    fatVenda.strDesCnd := fRetDesConPag(fCfgSis('CNDAVI', varString)); // Condicao      - Descricao
  End;

  If (fCfgSis('USAFPG', varBoolean)) Then
  Begin
    fatVenda.strCodFpg := '001';           // Código da Forma de Pagamento
    fatVenda.strDesFpg := 'DINHEIRO';      // Descrição da Forma de Pagamento
  End;
end;

procedure TfrmEntregasFuturasTintas.pCriaFatVenda;
begin
  if Assigned(fatVenda) then
  begin
    fatVenda.cdsBaiEntFut := nil;
    FreeAndNil(fatVenda);
  end;

  fatVenda := TFatVenda.CreateInstance('OR');
  pFreeCdsVenda;
  pCriarCdsVenda(Self);
  fatVenda.strOpcDocTrue:= 'FT';
  fatVenda.blnVerEstOrc := False;
  fatVenda.strNomeForm  := 'frmFatVendas';
  fatVenda.blnBaiEntFut := True;
  fatVenda.blnImprimeSep:= True;
  fatVenda.cdsBaiEntFut := cdsConsulta;
  fatVenda.strCodTra    := fCfgSis('TRASUG');
  fatVenda.strEntFat    := fCfgSis('ROMEFT');
  fatVenda.strEspDoc := 'OR';
  fatVenda.strOpcDoc := 'OR';
end;

procedure TfrmEntregasFuturasTintas.pInicializaTemporaria;
begin
  cdsVenda.EmptyDataSet;
  fatVenda.strMen001 := '';
  fatVenda.strMen002 := '';
  fatVenda.strMen001 := 'REF.DOCS.: ';
  fatVenda.strMen002 := 'VENDEDOR.: ';
end;

procedure TfrmEntregasFuturasTintas.pProcessarTabelasPrecosTintas(const dicRetorno: TDicionario);
var
  intCont: Integer;
  fltFatorMl: Double;
begin
  Try
    Try
      dicRetorno['idepro'] := cdsConsulta.FieldByName('DET_IDEPRO').AsString;
      dicRetorno['montad'] := cdsConsulta.FieldByName('DET_MONTAD').AsString;
      dicRetorno['a_n_o_'] := cdsConsulta.FieldByName('DET_A_N_O_').AsString;
      dicRetorno['itetin'] := cdsConsulta.FieldByName('DET_ITETIN').AsString;
      dicRetorno['tippre'] := cdsConsulta.FieldByName('DET_TIPPRE').AsString;
      dicRetorno['itebas'] := cdsConsulta.FieldByName('DET_CODITE').AsString;
      dicRetorno['iteemb'] := cdsConsulta.FieldByName('DET_ITEEMB').AsString;
      dicRetorno['codemp'] := cdsConsulta.FieldByName('DET_CODEMP').AsString;
      dicRetorno['volpro'] := cdsConsulta.FieldByName('DET_VOLPRO').AsFloat;
      dicRetorno['linha_'] := cdsConsulta.FieldByName('DET_LINLIN').AsString;

      fltFatorMl := fGetFatorML(cdsConsulta.FieldByName('DET_IDEPRO').AsString);

      for intCont := 1 to 20 do
      begin
        if not Assigned(cdsConsulta.FindField('DET_FORM' + fStrZero(intCont, 2))) then
          Break;

        if fEmptyStr(cdsConsulta.FieldByName('DET_FORM' + fStrZero(intCont, 2)).AsString) then
          Break;

        if fStrToFloat(cdsConsulta.FieldByName('DET_QTDB' + fStrZero(intCont, 2)).AsString) <= 0 then
          Continue;

        dicRetorno['base' + fStrZero(intCont, 2)] := cdsConsulta.FieldByName('DET_FORM' + fStrZero(intCont, 2)).AsString;
        dicRetorno['qtdb' + fStrZero(intCont, 2)] := fStrToFloat(cdsConsulta.FieldByName('DET_QTDB' + fStrZero(intCont, 2)).AsString) / cdsConsulta.FieldByName('DET_QTDITE').Value;
      end;

      dicRetorno['tabpre'] := fatVenda.strTabPre;
      dicRetorno.AdicionarObjeto('calculadorFatVendas', TFatVendasCalculadorWrapper.Create(fatVenda));
      pTintaRetornaTabelaPreco(dicRetorno, fltFatorMl);
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
  End;
end;

end.
