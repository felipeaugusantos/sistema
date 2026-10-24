unit untGeraDespesasProtesto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons, ExtCtrls,
  Mask, MaskEditFocus, EditFocus, cxControls, cxContainer, cxEdit, cxProgressBar,
  BitBtnLockedIncrem, Uni, UniClientDataSet, UniDataSetProvider, StrUtils,
  cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, frxClass, frxExportCSVTestabilidade, Data.DB, MemDS, DBAccess, Datasnap.Provider,
  Datasnap.DBClient, Vcl.Grids, Vcl.DBGrids, DBGridCitel, untPaiOrdena, dxCore,
  cxDateUtils, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, untTypesSistema, Math;

type
  TfrmGeraDespesasProtesto = class(TfrmPaiOrdena)
    btnGravar: TBitBtnLocked;
    btnMarcaTodos: TBitBtnLocked;
    btnDesmarcaTodos: TBitBtnLocked;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    Label1: TLabel;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    edtDiaAtr: TEditFocus;
    edtTaxJur: TEditFocus;
    edtValMin: TEditFocus;
    edtValDesCar: TEditFocus;
    mskDtaIni: TcxDateEdit;
    mskDtaFin: TcxDateEdit;
    btnAlteraTitulos: TBitBtnLocked;
    btnMarcaRegistro: TBitBtnLocked;
    btnCarregaTitulos: TBitBtnLocked;
    Panel1: TPanel;
    Label5: TLabel;
    Label6: TLabel;
    edtTotGer: TEditFocus;
    edtTotSel: TEditFocus;
    Label2: TLabel;
    Label3: TLabel;
    edtQtdeTotal: TEditFocus;
    edtQtdeSelecao: TEditFocus;
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnCarregaTitulosClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnMarcaTodosClick(Sender: TObject);
    procedure btnDesmarcaTodosClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnAlteraTitulosClick(Sender: TObject);
    procedure edtCodEmpExit(Sender: TObject);
    procedure btnMarcaRegistroClick(Sender: TObject);
    procedure cdsConsultaAfterOpen(DataSet: TDataSet);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnMudaOrdemClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure dbgConsultaDblClick(Sender: TObject);
  private
    { Private declarations }
    qryConEmp      : TUniQuery;
    qryConCli      : TUniQuery;
    cdsCtaRec      : TUniClientDataSet;
    blnAlteraTodas : Boolean;
    strEmpresa     : String;
    arrEmpresa     : TConsultasArray;
    indiceConsulta : String;

    procedure pCarregaCliente;
    procedure pCarregaEmpresa;
    // funções de SQL de dados, originais de banco e os gerados.
    function  fGetSqlTabela : String;
    function  fGetSQLNovosDados(ListaDados:TStringList) : String;
    // funções de carregamento e envio dos dados
    function  fCriaDespesas(pgbStatus: TcxProgressBar = Nil): Boolean;
    function  fEnviaDespesas(pgbStatus: TcxProgressBar = Nil): Boolean;

    procedure pStep(pgbStatus: TcxProgressBar);

    procedure pFiltraDados;
    procedure pAlteraDados;
    procedure pEditaDados(pgbStatus: TcxProgressBar = Nil);

    Function  fGravaDuplicatas(strDescon, strCodPor, strCodVen: String): Boolean;
    Function  fGravaRegistro(strDescon, strCodPor, strCodven: String): Boolean;

    Function  fGetListaCaixa: String;
    function  fBuscaDadosDuplicata(chave:String):String;
    function  fBuscaAutoIncrem(listaDados:TStringList):String;
    procedure pOrdenaGrid;
    procedure pMexeBotoes(trava:boolean);
    procedure pProtegeSelect(trava:boolean=False);
    function  fMarcaTodos(pgbStatus: TcxProgressBar = Nil): Boolean;
    procedure pCalculaTotais;
    procedure pMostraBarraVertical(valor:boolean=True);




  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function fGetSql(blnLike: Boolean): String; Override;
    function fSetParametros: Boolean; Override;
  public
    edtCodVen : String;
    edtDescon : String;
    edtCodPor : String;
    { Public declarations }
  end;


implementation

uses untFuncoesSimples, untFuncoes, untConsultas, untPesqAux, untCadRec,
     untGravando, untGeraDespesasProtestoConf, untFuncoesConsulta,
     untAtualizaOcorrenciasCRM, untTypesCRM;

{$R *.dfm}

procedure TfrmGeraDespesasProtesto.btnMarcaRegistroClick(Sender: TObject);
begin
  inherited;

  if (not cdsConsulta.Active) or (cdsConsulta.RecordCount = 0) then
  begin
    fMensagem('Atenção', 'É necessário selecionar ao menos uma duplicata!', ['&OK']);
    Exit;
  end;

  // pAddListaQuery;
  pSetFocus(dbgConsulta);
  Perform(WM_KEYDOWN, VK_SPACE, 0);
  dbgConsulta.Refresh;
  Application.ProcessMessages;
end;

procedure TfrmGeraDespesasProtesto.btnAlteraTitulosClick(Sender: TObject);
begin
  inherited;

  if (not cdsConsulta.Active) or (cdsConsulta.RecordCount = 0) then
  begin
    fMensagem('Atenção', 'É necessário selecionar ao menos uma duplicata!', ['&OK']);
    Exit;
  end;

  pCriarFormularios(TfrmGeraDespesasProtestoConf,frmGeraDespesasProtestoConf);
  If Assigned(frmGeraDespesasProtestoConf) Then
  Begin

    blnAlteraTodas := False;

      if not ( (frmGeraDespesasProtestoConf.ShowModal = mrOk) And
               (fGravaDuplicatas(edtCodVen, edtDescon, edtCodPor))
              ) then
        fMensagem('Atenção','Não foram alterados os títulos',['&OK']);

    FreeAndNil(frmGeraDespesasProtestoConf);
  End;
end;

procedure TfrmGeraDespesasProtesto.btnCarregaTitulosClick(Sender: TObject);
begin
  inherited;
  If Not fVerificaCampos  Then
     Exit
  else
  begin
    pCriarFormularios(TfrmGravando,frmGravando);
    pMexeBotoes(True);
    frmGravando.fExecutarAcao := fCriaDespesas;
    frmGravando.lblGravando.Caption := 'Aguarde... Carregando Títulos';
    frmGravando.ShowModal;

    If not cdsConsulta.IsEmpty Then
    begin
      pProtegeSelect(True);
      pSetFocus(dbgConsulta);
      pCalculaTotais;
    end
  end;
end;

procedure TfrmGeraDespesasProtesto.btnDesmarcaTodosClick(Sender: TObject);
begin
  inherited;

  if (not cdsConsulta.Active) or (cdsConsulta.RecordCount = 0) then
  begin
    fMensagem('Atenção', 'É necessário selecionar ao menos uma duplicata!', ['&OK']);
    Exit;
  end;

  stlListSelecao.Clear;
  dbgConsulta.Refresh;
  pCalculaTotais;
end;

procedure TfrmGeraDespesasProtesto.btnGravarClick(Sender: TObject);
begin
  inherited;

  if (not cdsConsulta.Active) or (cdsConsulta.RecordCount = 0) then
  begin
    fMensagem('Atenção', 'É necessário selecionar ao menos uma duplicata!', ['&OK']);
    Exit;
  end;

  if (cdsConsulta.RecordCount > 0) and (stlListSelecao.Count > 0) then
  begin
    pCriarFormularios(TfrmGravando,frmGravando);
    frmGravando.fExecutarAcao := fEnviaDespesas;
    frmGravando.lblGravando.Caption := 'Aguarde... Enviando Duplicatas';
    frmGravando.ShowModal;
  end else
    fMensagem('Atenção','Necessário haver dados de consulta e títulos selecionados',['&OK']);
end;

procedure TfrmGeraDespesasProtesto.btnMarcaTodosClick(Sender: TObject);
begin
  inherited;

  if (not cdsConsulta.Active) or (cdsConsulta.RecordCount = 0) then
  begin
    fMensagem('Atenção', 'É necessário selecionar ao menos uma duplicata!', ['&OK']);
    Exit;
  end;

  pCriarFormularios(TfrmGravando,frmGravando);
  frmGravando.fExecutarAcao := fMarcaTodos;
  frmGravando.lblGravando.Caption := 'Aguarde... Marcando Títulos';
  frmGravando.ShowModal;
  pCalculaTotais;
end;

procedure TfrmGeraDespesasProtesto.btnMudaOrdemClick(Sender: TObject);
begin
  inherited;

  if (not cdsConsulta.Active) or (cdsConsulta.RecordCount = 0) then
  begin
    fMensagem('Atenção', 'É necessário ter ao menos uma duplicata listada no grid!', ['&OK']);
    Exit;
  end;

  pOrdenaGrid;
end;

procedure TfrmGeraDespesasProtesto.btnPesquisarClick(Sender: TObject);
begin
  inherited;
  pFiltraDados;
end;

procedure TfrmGeraDespesasProtesto.btnSairClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmGeraDespesasProtesto.cdsConsultaAfterOpen(DataSet: TDataSet);
begin
  inherited;
  pEditaDados;
end;

procedure TfrmGeraDespesasProtesto.dbgConsultaDblClick(Sender: TObject);
begin
  // Procedimento para retirar o DBCLICK da  herança do formulario.
  Exit;
  // inherited;

end;

procedure TfrmGeraDespesasProtesto.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrCodCli : TConsultasArray;
begin
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, arrCodCli) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmGeraDespesasProtesto.edtCodEmpExit(Sender: TObject);

begin
  inherited;
  pEdtCodSelectExit(edtCodEmp, edtNomEmp, arrEmpresa, fRetNomeEmpresa, Nil, 'da Empresa', 0, False, 'Código', True);
end;

procedure TfrmGeraDespesasProtesto.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmpresa, False, True) Then
  Begin
    If fValidaCampos(edtCodEmp) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmGeraDespesasProtesto.fBuscaAutoIncrem(
  listaDados: TStringList): String;
var
  qryBuscaAutoIncrem:TUniQuery;
  listaLocal : TStringList;
  i : integer;
begin

  qryBuscaAutoIncrem := fCriaQuery(nil);
  listaLocal := TStringList.Create;

  for i:= 0 to listaDados.Count -1 do
  begin
    ExtractStrings(['|'],[ ],PChar(ListaDados[i]),listaLocal);

    qryBuscaAutoIncrem.SQL.Text := ' Select CADREC.AUTOINCREM from CADREC where ' + #13 +
                                   '     CTR_NUMDUP = ' + QuotedStr(listaLocal[0])    + #13 +
                                   ' AND CTR_PARCEL = ' + QuotedStr(listaLocal[1])    + #13 +
                                   ' AND CTR_ESPDOC = ' + QuotedStr(listaLocal[2])    + #13 +
                                   ' AND CTR_CODCLI = ' + QuotedStr(listaLocal[3])    + #13 +
                                   ' AND CTR_CODEMP = ' + QuotedStr(listaLocal[4]);
    qryBuscaAutoIncrem.Open;

    if i = listadados.Count -1 then
      result := result + QuotedStr(qryBuscaAutoIncrem.Fields[0].AsString)
    else
      result := result + QuotedStr(qryBuscaAutoIncrem.Fields[0].AsString) + ',';

    listaLocal.Clear;

  end;


  FreeAndNil(qryBuscaAutoIncrem);

end;

function TfrmGeraDespesasProtesto.fBuscaDadosDuplicata(chave: String): String;
Var
  strSQL : String;
  qryDados:TUniQuery;
begin
    qryDados := fCriaQuery(nil);

    strSQL := strSQL + 'SELECT CADREC.AUTOINCREM,   ';
    strSQL := strSQL + '  CTR_NUMDUP,CTR_PARCEL,CTR_ESPDOC,CTR_CODEMP, ';
    strSQL := strSQL + '  CTR_CODCLI,CLI_NOMCLI,CTR_CODPOR,POR_NOMPOR  ';
    strSQL := strSQL + 'FROM     ';
    strSQL := strSQL + '  CADREC ';
    strSQL := strSQL + '  INNER JOIN CADCLI ON CADREC.CTR_CODCLI = CADCLI.CLI_CODCLI ';
    strSQL := strSQL + '  LEFT  JOIN CADPOR ON CADREC.CTR_CODPOR = CADPOR.POR_CODPOR ';

    strSQL := strSQL + 'WHERE    ';
    strSQL := strSQL + '  CADREC.AUTOINCREM = ' + QuotedStr(chave);

    qryDados.SQL.Text := strSQL;
    qryDados.Open;

    with qryDados do
    begin
      Result :=                FieldByName('CTR_NUMDUP').AsString + '-' + FieldByName('CTR_PARCEL').AsString + '-' +
                               FieldByName('CTR_ESPDOC').AsString + '-' + FieldByName('CTR_CODEMP').AsString;
      Result := Result + '|' + FieldByName('CTR_CODCLI').AsString + '-' + FieldByName('CLI_NOMCLI').AsString;
      Result := Result + '|' + FieldByName('CTR_CODPOR').AsString + '-' + FieldByName('POR_NOMPOR').AsString;
    end;

    FreeAndNil(qryDados);

end;

function TfrmGeraDespesasProtesto.fCriaDespesas(
  pgbStatus: TcxProgressBar): Boolean;
begin

  Result := False;
  Try
    cdsConsulta.Close;
    qryConsulta.SQL.Text := fGetSqlTabela;

    qryConsulta.ParamByName('DTAINI').AsDateTime := StrToDateTime(mskDtaIni.Text);
    qryConsulta.ParamByName('DTAFIN').AsDateTime := StrToDateTime(mskDtaFin.Text);

    If Not fEmptyStr(edtCodCli.Text) Then
      qryConsulta.ParamByName('CODCLI').AsString := edtCodCli.Text;

    If (Not fEmptyStr(edtCodEmp.Text)) Then
      qryConsulta.ParamByName('CODEMP').AsString := edtCodEmp.Text;


    If (edtNomEmp.Text = '+1') Then
    Begin
      pSetaParam(edtCodEmp.Text, arrEmpresa, strEmpresa, 'CODEMP', qryConsulta);
    End else
    If (Not fEmptyStr(edtCodEmp.Text)) and ((edtNomEmp.Text <> '+1')) Then
      qryConsulta.ParamByName('CODEMP').AsString :=  edtCodEmp.Text;

    pMostraBarraVertical(false);
    With qryConsulta Do
    Begin
      open;
      If Not IsEmpty Then
      Begin
        pSetaClient(qryConsulta);
        pEditaDados(pgbStatus);
        pFiltraDados;
        dbgConsulta.Show;
        btnMarcaTodos.Click;
        Application.ProcessMessages;
        pMostraBarraVertical(True);

        Result := True;
      End
      Else
      Begin
        fMensagem('ATENÇÃO!', 'Nenhuma duplicata encontrada!', ['&O k']);
        if not cdsConsulta.Active then
        begin
          cdsConsulta.Open;
          cdsConsulta.EmptyDataSet;
          cdsConsulta.Close;
        end else
          cdsConsulta.EmptyDataSet;
        pSetFocus(mskDtaIni);
      End;
      Close;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;

end;

function TfrmGeraDespesasProtesto.fEnviaDespesas(
  pgbStatus: TcxProgressBar): Boolean;
var
  strNumPro: String;
  blnErro  : Boolean;
  listaGerados:TStringList;
  dtaDtaVenNovo:TDateTime;
begin

  Result := False;
  If stlListSelecao.Count > 0 Then
  begin
    blnErro  := True;

        with cdsConsulta do
        begin
          First;
          DisableControls;
          pgbStatus.Position := 0;
          pgbStatus.Properties.Max := stlListSelecao.count;
          listaGerados := TStringList.Create;
          While Not Eof Do
          Begin
            if Pos(FieldByName('AUTOINCREM').AsString,stlListSelecao.Text) > 0 then
            begin
              Edit;
              FieldByName('CTR_JURATR').AsFloat := (fStrToFloat(edtTaxJur.Text) / 30) * FieldByName('CTR_DIAATR').AsInteger;
              FieldByName('CTR_VALCOB').AsFloat := (  (  (
                                                           (
                                                             (fStrToFloat(edtTaxJur.Text) / 30) * FieldByName('CTR_DIAATR').AsInteger
                                                           )/100
                                                         ) * FieldByName('CTR_VALDUP').AsFloat
                                                      )   +
                                                        fStrToFloat(edtValDesCar.Text)
                                                   )     - (FieldByName('CTR_VALJUR').AsFloat - FieldByName('CTR_VALDES').AsFloat);
              Post;
              pStep(pgbStatus);
              Application.ProcessMessages;
              strNumPro                := fSeqDespesasProtesto;
              pStep(pgbStatus);
              Application.ProcessMessages;

              if FieldByName('CTR_DTAVEN').AsDateTime > VS_Date then
                dtaDtaVenNovo := FieldByName('CTR_DTAVEN').AsDateTime
              else
                dtaDtaVenNovo := VS_Date;

              if FieldByName('CTR_VALCOB').AsFloat >= 0.01 then
              begin
                If fGravaCadRec(Self.Name,
                                'INCLUSÃO',
                                strNumPro,
                                'A',
                                0,
                                'DC',
                                FieldByName('CTR_CODCLI').AsString,
                                FieldByName('CTR_CODEMP').AsString,
                                FieldByName('CTR_CODVEN').AsString,
                                FieldByName('CTR_CODDIG').AsString,
                                FieldByName('CTR_CODPOR').AsString,
                                VS_Date,
                                dtaDtaVenNovo,
                                FieldByName('CTR_VALCOB').AsFloat,
                                FieldByName('CTR_VALCOB').AsFloat,
                                0,
                                '',
                                'DESPESAS DE COBRANCA DE PROTESTO' + #13 +
                                ' Dup. de Origem: ' + FieldByName('CTR_NUMDUP').AsString + '-' +
                                                      FieldByName('CTR_CODEMP').AsString +
                                '    Dt.Venc.: ' + FieldByName('CTR_DTAVEN').AsString +
                                '    Dt.Receb.: ' + FieldByName('CTR_DTAREC').AsString,
                                'DOCUMENTO DE ORIGEM: ' + FieldByName('CTR_NUMDUP').AsString +  '-' +
                                                          FieldByName('CTR_CODEMP').AsString,
                                '',
                                '',
                                '',
                                '',
                                0,
                                0,
                                FieldByName('CTR_ADTCLI').AsString,
                                FieldByName('CTR_CODEVE').AsString,
                                FieldByName('CTR_CODVEL').AsString,
                                FieldByName('CTR_TIPFOR').AsString,
                                FieldByName('CTR_CODCND').AsString,
                                False,
                                FieldByName('CTR_CODCTA').AsString,
                                0,
                                FieldByName('CTR_VALCOB').AsFloat) Then
                Begin
                  if not fGravaDespProt(strNumPro,
                                 Copy(FieldByName('CTR_NUMDUP').AsString,1,Pos('-',FieldByName('CTR_NUMDUP').AsString)-1),
                                 FieldByName('CTR_PARCEL').AsString,
                                 FieldByName('CTR_ESPDOC').AsString,
                                 FieldByName('CTR_CODCLI').AsString,
                                 FieldByName('CTR_CODEMP').AsString) then
                  begin
                    blnErro := True;
                    fMensagem('Atenção!','Erro enviando Duplicata ' +
                                                          FieldByName('CTR_NUMDUP').AsString
                                                          ,['&OK']);
                  end else
                  begin
                    blnErro  := False;
                    listaGerados.Add(strNumPro+'|A|DC|'+FieldByName('CTR_CODCLI').AsString+'|'+FieldByName('CTR_CODEMP').AsString);
                  end;

                  If VS_strHabilitarCRM And (Not fEmptyStr(fCfgSis('OCOFIN', varString)))  Then
                  Begin
                    TAtuOcoCrm.pAtualizaOcorrenciaFinanceiro(FieldByName('CTR_NUMDUP').AsString,
                                                             FieldByName('CTR_ESPDOC').AsString,
                                                             FieldByName('CTR_CODEMP').AsString,
                                                             FieldByName('CTR_CODCLI').AsString,
                                                             FieldByName('CTR_PARCEL').AsString,
                                                             strLoginUsuarioLogado,
                                                             fRetCgcCpf(FieldByName('CTR_CODCLI').AsString),
                                                             afcGeraDespesaProtesto);
                  End;
                End else
                begin
                  blnErro := True;
                  fMensagem('Atenção!','Erro gerando remessa da Duplicata ' +
                                                          FieldByName('CTR_NUMDUP').AsString
                                                          ,['&OK']);
                end;
              end;
            end;
            Next;
          End;

          if not blnErro then
          begin
            fMensagem('Sucesso','Duplicatas geradas serão exibidas para CONFERÊNCIA',['&OK']);
            cdsConsulta.Close;
            cdsConsulta.Filter   := '';
            cdsConsulta.Filtered := False;
            with qryConsulta do
            begin
              SQL.Clear;
              SQL.Text := fGetSQLNovosDados(listaGerados);
              Open;
              pSetaClient(qryConsulta);
            end;
            pMostraBarraVertical(False);
            cdsConsulta.Open;
            pMexeBotoes(False);
            Application.ProcessMessages;
            pMostraBarraVertical(True);
          end
          else
            fMensagem('Atenção','Duplicatas não foram geradas. Favor conferir a seleção realizada.',['&OK']);

          EnableControls;
        end;
  end
  else
  begin
    fMensagem('Atenção!','Não foram selecionados títulos para envio',['&OK']);
    Result := False;
  end;

end;


function TfrmGeraDespesasProtesto.fGetListaCaixa: String;
  Var
    intIndice: Integer;
    sltLista : TStringList;
    strAutInc: String;

Begin
  sltLista := TStringList.Create;
  sltLista.Clear;

  For intIndice := 0 To stlListSelecao.Count - 1 Do
  Begin
    strAutInc := Copy(stlListSelecao[intIndice],2,21);

    sltLista.Add(QuotedStr(LeftStr(strAutInc,20)));
  End;

  Result := sltLista.CommaText;
End;

function TfrmGeraDespesasProtesto.fGetSql(blnLike: Boolean): String;
begin
  Result := fGetSqlTabela + fFiltraSQL(blnLike);
end;

function TfrmGeraDespesasProtesto.fGetSQLNovosDados(ListaDados:TStringList): String;
Var
  strSQL   : String;
begin

    strSQL := '';
    strSQL := strSQL + 'SELECT CADREC.AUTOINCREM,   ';
    strSQL := strSQL + '  CAST(CTR_NUMDUP AS CHAR(21)) AS CTR_NUMDUP,CTR_PARCEL,CTR_ESPDOC,CTR_CODEMP, ';
    strSQL := strSQL + '  CTR_CODCLI,CLI_NOMCLI,CTR_CODVEN,CTR_CODDIG, ';
    strSQL := strSQL + '  CTR_CODPOR,POR_NOMPOR,CTR_ADTCLI,CTR_CODEVE,CTR_CODVEL,CTR_TIPFOR, ' ;
    strSQL := strSQL + '  CTR_CODCND,CTR_CODCTA,CTR_DTACAD,CTR_DTAVEN, ';
    strSQL := strSQL + '  DATEDIFF(CTR_DTAREC, CTR_DTAVEN)                       AS CTR_DIAATR, ';
    strSQL := strSQL + '  IFNULL(CTR_VALDUP, 0)                                  AS CTR_VALDUP, ';
    strSQL := strSQL + '  0.00                                                   AS CTR_VALJUR, ';
    strSQL := strSQL + '  0.00                                                   AS CTR_DESCOB, ';
    strSQL := strSQL + '  CAST(0.00 AS DECIMAL(15,2))                            AS CTR_JURATR, ';
    strSQL := strSQL + '  CAST(0.00 AS DECIMAL(15,2))                            AS CTR_VALCOB, ';
    strSQL := strSQL + '                                                            CTR_DTAREC, ';
    strSQL := strSQL + '  0.00                                                   AS CTR_VALORI, ';
    strSQL := strSQL + '  0.00                                                   AS CTR_VALREC  ';
    strSQL := strSQL + 'FROM     ';
    strSQL := strSQL + '  CADREC ';
    strSQL := strSQL + '  INNER JOIN CADCLI ON CADREC.CTR_CODCLI = CADCLI.CLI_CODCLI ';
    strSQL := strSQL + '  LEFT  JOIN CADPOR ON CADREC.CTR_CODPOR = CADPOR.POR_CODPOR ';

    strSQL := strSQL + 'WHERE    ';

    strSQL := strSQL + ' CADREC.AUTOINCREM IN ( ' + fBuscaAutoIncrem(listaDados) + ' )';

    result := strSQL;


end;

function TfrmGeraDespesasProtesto.fGetSqlTabela: String;
Var
  strSQL   : String;
begin

    strSQL := '';
    strSQL := strSQL + 'SELECT CADREC.AUTOINCREM,   ';
    strSQL := strSQL + '  CAST(CTR_NUMDUP AS CHAR(21)) AS CTR_NUMDUP,CTR_PARCEL,CTR_ESPDOC,CTR_CODEMP, ';
    strSQL := strSQL + '  CTR_CODCLI,CLI_NOMCLI,CTR_CODVEN,CTR_CODDIG, ';
    strSQL := strSQL + '  CTR_CODPOR,POR_NOMPOR,CTR_ADTCLI,CTR_CODEVE,CTR_CODVEL,CTR_TIPFOR, ' ;
    strSQL := strSQL + '  CTR_CODCND,CTR_CODCTA,CTR_DTACAD,CTR_DTAVEN, ';
    strSQL := strSQL + '  DATEDIFF(CTR_DTAREC, CTR_DTAVEN)                       AS CTR_DIAATR, ';
    strSQL := strSQL + '  CTR_VALREC - IFNULL(CTR_VALJUR, 0) + IFNULL(CTR_VALDES, 0) + ' + AnsiReplaceStr(FloatToStrF(fStrToFloat(edtValDesCar.Text),ffFixed,12,2),',','.') + ' AS CTR_VALDUP, ';
    strSQL := strSQL + '  IFNULL(CTR_VALJUR, 0)                                  AS CTR_VALJUR, ';
    strSQL := strSQL + '  IFNULL(CTR_VALDES, 0)                                  AS CTR_VALDES, ';
    strSQL := strSQL + '  IFNULL(CTR_DESCOB, 0)                                  AS CTR_DESCOB, ';
    strSQL := strSQL + '  CAST(0.00 AS DECIMAL(15,2))                            AS CTR_JURATR, ';
    strSQL := strSQL + '  CAST(0.00 AS DECIMAL(15,2))                            AS CTR_VALCOB, ';
    strSQL := strSQL + '  CTR_DTAREC,                                                           ';
    strSQL := strSQL + '  CTR_VALORI,                                                           ';
    strSQL := strSQL + '  IFNULL(CTR_VALREC, 0) AS CTR_VALREC                                   ';
    strSQL := strSQL + 'FROM     ';
    strSQL := strSQL + '  CADREC ';
    strSQL := strSQL + '  INNER JOIN CADCLI ON CADREC.CTR_CODCLI = CADCLI.CLI_CODCLI ';
    strSQL := strSQL + '  LEFT  JOIN CADPOR ON CADREC.CTR_CODPOR = CADPOR.POR_CODPOR ';

    strSQL := strSQL + 'WHERE    ';
    strSQL := strSQL + '  CTR_VALORI > 0             AND ';
    strSQL := strSQL + '  CTR_PROTES IS NULL         AND ';

    if StrToInt(edtDiaAtr.Text) > 0 then
      strSQL := strSQL + '  DATEDIFF(CTR_DTAREC, CTR_DTAVEN)  >= ' + edtDiaAtr.Text + '   AND '
    else
      strSQL := strSQL + '  DATEDIFF(CTR_DTAREC, CTR_DTAVEN)  > 0  AND ';

    strSQL := strSQL + '  CTR_DTAREC BETWEEN :DTAINI AND :DTAFIN ';

    //Somente das empresas que o operador tem direito de acesso.
    If (Not fEmptyStr(edtCodEmp.Text)) AND (Pos(edtNomEmp.Text,'+1') = 0 ) Then
        strSQL := strSQL + ' AND CTR_CODEMP = :CODEMP ';

    if Pos(edtNomEmp.Text,'+1') > 0 then
      strSQL := strSQL + fStrLocate(edtCodEmp,  arrEmpresa,  'CTR_CODEMP', 'CODEMP')
    else
    if Pos(edtNomEmp.Text,'TODAS') > 0 then
      strSQL := strSQL + '  AND (LOCATE(CTR_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0) ';


    If Not fEmptyStr(edtCodCli.Text) Then
      strSQL := strSQL + '  AND CTR_CODCLI = :CODCLI ';

  result := strSQL;

end;

function TfrmGeraDespesasProtesto.fGravaDuplicatas(strDescon, strCodPor,
  strCodVen: String): Boolean;
begin
  Application.ProcessMessages;

  Try
    // fStartTransaction;

    blnAlteraTodas := frmGeraDespesasProtestoConf.chbRepassa.Checked;
    edtDescon := frmGeraDespesasProtestoConf.edtDescon.Text;
    edtCodPor := frmGeraDespesasProtestoConf.edtCodPor.Text;
    edtCodVen := frmGeraDespesasProtestoConf.edtCodVen.Text;


    Result := fGravaRegistro(edtDescon, edtCodPor, edtCodVen);

    if Result then
      fMensagem('Atenção','Titulos alterados, verifique os dados antes da geração',['&OK'])
   { else
      fMensagem('Atenção','Erro ocorrido na edição dos registros',['&OK']) }

  Except

    On E: Exception Do
    Begin
      fRollBack;
      Result := FALSE;
      pMensagensErro('Erro ao atualizar duplicatas. ' + E.Message , '[fGravaDuplicatas]');
    End;

  End;

end;

function TfrmGeraDespesasProtesto.fGravaRegistro(strDescon, strCodPor,
  strCodven: String): Boolean;
  Var
    strLista, strEmpSemAcesso: String;
Begin
  Try

    strLista := fGetListaCaixa;

    if not blnAlteraTodas then
    begin
      with cdsConsulta do
      begin
        {*REQ*145940**********RP*}
        If Not fEmpresaTemAcessoPortador(strCodPor, FieldByName('CTR_CODEMP').AsString) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
          Exit(False);
        End;

        Edit;
          If Not fEmptyStr(strDescon) Then
            FieldByName('CTR_DTAVEN').Value  := strDescon;

          If Not fEmptyStr(strCodPor) Then
            FieldByName('CTR_CODPOR').Value  := strCodPor;

          If Not fEmptyStr(strCodVen) Then
            FieldByName('CTR_CODVEN').Value := strCodVen;

        FieldByName('CLI_NOMCLI').AsString := FieldByName('CTR_CODCLI').AsString + '-' + fRetNomCliente(FieldByName('CTR_CODCLI').AsString);
        FieldByName('POR_NOMPOR').AsString := FieldByName('CTR_CODPOR').AsString + '-' + fRetNomPortador(FieldByName('CTR_CODPOR').AsString);
        Post;
      end;
      Result := True;
    end else
    begin
      with cdsConsulta do
      begin
        {*REQ*145940**********RP*}
        If Not fEmpresasTemAcessoPortador(strCodPor,
                                          cdsConsulta,
                                          'CTR_CODEMP',
                                          strEmpSemAcesso,
                                          'AUTOINCREM IN('+ strLista +')') Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa(s) sem acesso ao cadastro do Portador informado: '+ strEmpSemAcesso +'. Operação abortada!', ['&OK']);
          Exit(False);
        End;

        indiceConsulta := fGetAliasField(lflLastField.strNomCam);
        cdsConsulta.IndexFieldNames := 'CTR_NUMDUP';
        DisableControls;
        First;
        while not eof do
        begin
          If Pos(FieldByName('AUTOINCREM').AsString, strLista) > 0 then
          begin
            Edit;
            If Not fEmptyStr(strDescon) Then
              FieldByName('CTR_DTAVEN').Value  := strDescon;

            If Not fEmptyStr(strCodPor) Then
              FieldByName('CTR_CODPOR').Value  := strCodPor;

            If Not fEmptyStr(strCodVen) Then
              FieldByName('CTR_CODVEN').Value := strCodVen;

            FieldByName('CLI_NOMCLI').AsString := FieldByName('CTR_CODCLI').AsString + '-' + fRetNomCliente(FieldByName('CTR_CODCLI').AsString);
            FieldByName('POR_NOMPOR').AsString := FieldByName('CTR_CODPOR').AsString + '-' + fRetNomPortador(FieldByName('CTR_CODPOR').AsString);

            Post;
          end;
          Application.ProcessMessages;
          Next;
        end;
        First;
        cdsConsulta.IndexFieldNames := fGetAliasField(lflLastField.strNomCam);
        EnableControls;
        Result := True;
      end;
    end;
  Except
    On E: Exception Do
    Begin
      Result := FALSE;
      pMensagensErro('Erro ao atualizar títulos. ' + E.Message , '[fGravaRegistro]');
    End;
  End;

End;

function TfrmGeraDespesasProtesto.fMarcaTodos(pgbStatus: TcxProgressBar = Nil): Boolean;
begin
  If cdsConsulta.Active Then
  Begin
    stlListSelecao.Clear;
    With cdsConsulta Do
    Begin
      DisableControls;
      First;
      While Not Eof Do
      Begin
        pAddListaQuery;
        Next;
        pStep(pgbStatus);
      End;
      First;
      EnableControls;
    End;
    dbgConsulta.Refresh;
  End;
  Result := True;
end;

procedure TfrmGeraDespesasProtesto.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin

  FreeAndNil(qryConCli);
  FreeAndNil(qryConEmp);
  inherited;
end;

procedure TfrmGeraDespesasProtesto.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  pMexeBotoes(True);

  CanClose := True;

end;

procedure TfrmGeraDespesasProtesto.FormCreate(Sender: TObject);
begin
  inherited;
  blnSempreRelerbanco := False;
  cdsCtaRec := TUniClientDataSet.Create(Self);
  qryConCli := fCriarQuery('SELECT * FROM CADCLI WHERE FALSE', Self);
  qryConEmp := fCriarQuery('SELECT * FROM CADEMP WHERE FALSE', Self);
end;

procedure TfrmGeraDespesasProtesto.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (btnGravar.Enabled = False) AND (key <> VK_ESCAPE) then
      exit;

  Case Key of
    VK_F3     : btnMudaOrdem.Click;
    VK_F10    : btnGravar.Click;
    VK_F6     : btnMarcaTodos.Click;
    VK_F7     : btnDesmarcaTodos.Click;
    VK_RETURN : if dbgConsulta.Focused then
                begin
                  if stlListSelecao.Count = 0 then
                    fMensagem('Atenção','Para alteração de títulos, necessário ter títulos selecionados',['&OK']);
                  if stlListSelecao.Count > 0 then
                    pAlteraDados;

                  exit;

                end
                else
                  inherited;
    VK_SPACE  : begin
                  if not btnGravar.Enabled then
                    Exit;
                  pAddListaQuery;
                  pCalculaTotais;
                  dbgConsulta.Refresh;
                  Application.ProcessMessages;
                end;
    VK_ESCAPE : begin
                  if not btnCarregaTitulos.Enabled then
                  begin
                    if pnlPesquisa.Visible then
                    begin
                       pLimpaPesquisa;
                       pRefresh;
                       pSetFocus(dbgConsulta);
                       pAcaoAbort;
                       pFiltraDados;
                       Abort;
                    end;
                    pProtegeSelect(False);
                    cdsConsulta.Filtered := False;
                    cdsConsulta.Filter   := '';
                    cdsConsulta.EmptyDataSet;
                    cdsConsulta.Close;
                    qryConsulta.Close;
                    dbgConsulta.Refresh;
                    cdsConsulta.IndexFieldNames := 'CTR_NUMDUP';
                    pSetFocus(mskDtaIni);
                    pCalculaTotais;
                    Exit;

                  end else
                  begin
                    inherited;
                    Exit;
                  end;
                end;
  end;
  inherited;
end;

procedure TfrmGeraDespesasProtesto.FormResize(Sender: TObject);
begin
  inherited;
  with Self do
  begin
    Top  := (Screen.WorkAreaHeight - Height) DIV 2;
    Left := (Screen.WorkAreaWidth - Width) DIV 2;
  end;
end;

procedure TfrmGeraDespesasProtesto.FormShow(Sender: TObject);
begin
  inherited;
  mskDtaIni.Text   := FormatDateTime('dd/mm/yyyy', VS_Date);
  mskDtaFin.Text   := FormatDateTime('dd/mm/yyyy', VS_Date);
  edtTaxJur.Text   := FloatToStrF(fCfgSis('JURATR', varDouble), ffFixed, 12, 2);
  edtValDesCar.Text:= FloatToStrF(fCfgSis('DESATR', varDouble), ffFixed, 12, 2);
  edtCodEmp.Text   := VS_strCodEmp;
  edtNomEmp.Text   := fRetNomeEmpresa;
  dbgConsulta.drawingStyle := gdsThemed;
  pSetFocus(mskDtaIni);
  windowState := wsMaximized;
end;

function TfrmGeraDespesasProtesto.fSetParametros: Boolean;
begin
  Result := False;
  If Not fVerificaCampos  Then
     Exit;
  With qryConsulta Do
  Begin
    If Not fEmptyStr(edtCodCli.Text) Then
    Begin
      ParamByName('CODCLI').AsString := edtCodCli.Text;
    End;

    If Not fEmptyStr(edtCodEmp.Text) Then
    Begin
      ParamByName('CODEMP').AsString := edtCodEmp.Text;
    End;

    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
    Begin
      ParamByName('DTAINI').AsDateTime := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDateTime := StrToDate(mskDtaFin.Text);
    End;

  End;

  Result := TRUE;
end;

function TfrmGeraDespesasProtesto.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = mskDtaIni) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data Inicial deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        mskDtaFin.Enabled := True;
      End;
    End

    Else If (Sender = mskDtaFin) Then
    Begin
      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data Final deve ser preenchida!', ['&O k']);
          Result := False;
        End
        Else If Not fValidaPeriodo(mskDtaIni.Text, mskDtaFin.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data Final deve ser maior ou igual a Data Inicial!', ['&O k']);
          Result := False;
        End;
      End
      Else
      Begin
        fMensagem('ATENÇÃO!', 'A Data Inicial deve ser preenchida!', ['&Ok']);
        blnMudarFoco := False;
        pSetFocus(mskDtaIni);
      End;
    End

    Else If (Sender = edtCodCli) Then
    Begin
      If Not fEmptyStr(edtCodCli.Text) Then
      Begin
        pCarregaCliente;
        If fEmptyStr(edtNomCli.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Cliente não está cadastrado!', ['&O k']);
          Result := False;
        End;
      End
      Else
      Begin
        edtNomCli.Text := 'TODOS';
        Result := True;
      End;
    End

    Else If (Sender = edtCodEmp) Then
    Begin

      If (not fEmptyStr(edtCodEmp.text)) and ( Not SameText(edtCodEmp.Text, '000')) Then
      Begin
        SetLength(arrEmpresa, 0);

        pCarregaEmpresa;
        If fEmptyStr(edtNomEmp.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&Ok']);
          Result := False;
        End
        Else If Pos(edtCodEmp.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a esta empresa!', ['&Ok']);
          Result := False;
        End;
      End;

    End

    Else If (Sender = edtDiaAtr) Then
    Begin

      If fEmptyStr(edtDiaAtr.Text) Then
      Begin
        fMensagem('', 'O campo Dias de atraso deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        Try
          fStrToFloat(edtDiaAtr.Text);

          If (fStrToFloat(edtDiaAtr.Text) < 0) Then
          Begin
            fMensagem('ATENÇÃO!', 'Não é permitido valor negativo!', ['&Ok']);
            Result := False;
          End;
        Except
          fMensagem('', 'O campo Dias de atraso deve ser numérico!', ['&Ok']);
          Result := False;
        End;
      End;

    End

    Else If (Sender = edtTaxJur) Then
    Begin

      If (fStrToFloat(edtTaxJur.Text) < 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'Não é permitido valor negativo!', ['&Ok']);
        Result := False;
      End;

    End

    Else If (Sender = edtValMin) Then
    Begin

      If (fStrToFloat(edtValMin.Text) < 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'Não é permitido valor negativo!', ['&Ok']);
        Result := False;
      End;

    End

    Else If (Sender = edtValDesCar) Then
    Begin

      If (fStrToFloat(edtValDesCar.Text) < 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'Não é permitido valor negativo!', ['&Ok']);
        Result := False;
      End;

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmGeraDespesasProtesto.pAlteraDados;
begin
  btnAlteraTitulos.Click;
end;

procedure TfrmGeraDespesasProtesto.pCalculaTotais;
  Var fltTotGer, fltTotSel: Double;
      intRecNo: Integer;
begin
  fltTotGer := 0;
  fltTotSel := 0;
  edtQtdeTotal.Text   := '0';
  edtQtdeSelecao.Text := '0';

  If cdsConsulta.Active Then
  Begin
    With cdsConsulta Do
    Begin
      intRecNo := RecNo;
      DisableControls;
      First;

      While Not Eof Do
      Begin
        If fInLista Then
          fltTotSel := fltTotSel + FieldByName('CTR_VALDUP').AsFloat;

        fltTotGer := fltTotGer + FieldByName('CTR_VALDUP').AsFloat;

        Next;
      End;
      RecNo := intRecNo;
      EnableControls;
    End;
    edtQtdeTotal.Text   := IntToStr(cdsConsulta.RecordCount);
    edtQtdeSelecao.Text := IntToStr(stlListSelecao.Count);
  End;

  edtTotGer.Text      := FormatFloat('#,##0.00', fltTotGer);
  edtTotSel.Text      := FormatFloat('#,##0.00', fltTotSel);
end;

procedure TfrmGeraDespesasProtesto.pCarregaCliente;
begin
  pPesquisaCadCli(qryConCli, qryConCli, edtCodCli.Text);
  With qryConCli Do
  Begin
    edtNomCli.Text := FieldbyName('CLI_NOMCLI').AsString;
  End;
end;

procedure TfrmGeraDespesasProtesto.pCarregaEmpresa;
begin
  If Not fEmptyStr(edtCodEmp.Text) Then
  Begin
    edtNomEmp.Text := fRetNomeEmpresaSelec(edtCodEmp.Text);
    pPesquisaCadEmp(qryConEmp, qryConEmp, edtCodEmp.Text);
  End
  Else
    edtNomEmp.Clear;
end;

procedure TfrmGeraDespesasProtesto.pMexeBotoes(trava:boolean);
begin
  btnGravar.Enabled        := Trava;
  btnMudaOrdem.Enabled     := Trava;
  btnPesquisar.Enabled     := Trava;
  btnMarcatodos.Enabled    := Trava;
  btnDesmarcaTodos.Enabled := Trava;
  btnAlteraTitulos.Enabled := Trava;
  btnMarcaRegistro.Enabled := Trava;
end;

procedure TfrmGeraDespesasProtesto.pMostraBarraVertical(valor: boolean);
begin
  if valor then
    Panel1.Height := Panel1.Height + 1
  else
    Panel1.Height := Panel1.Height - 1;
end;

procedure TfrmGeraDespesasProtesto.pEditaDados(pgbStatus: TcxProgressBar = Nil);
Var
  listaDados:TStringList;
begin
  if not btnCarregaTitulos.Enabled then
    Exit;

  listaDados := TStringList.Create;
        With cdsConsulta Do
        Begin
          Open;
          pMascaraValor;
          DisableControls;
          First;
          While Not Eof Do
          Begin
            pStep(pgbStatus);
            Application.ProcessMessages;
            Edit;
            ExtractStrings(['|'],[ ],PChar(fBuscaDadosDuplicata(cdsConsulta.FieldByname('AUTOINCREM').AsString)),listaDados);
            FieldByName('CTR_NUMDUP').AsString := listaDados[0];
            FieldByName('CLI_NOMCLI').AsString := FieldByName('CTR_CODCLI').AsString + '-' + fRetNomCliente(FieldByName('CTR_CODCLI').AsString);
            FieldByName('POR_NOMPOR').AsString := FieldByName('CTR_CODPOR').AsString + '-' + fRetNomPortador(FieldByName('CTR_CODPOR').AsString);
            // SETUP DOS CAMPOS PARA PREVISÃO DOS VALORES DA NOVA DUPLICATA MEDIANTE OS VALORES INFORMADOS NO GRID DE SELEÇÃO
            FieldByName('CTR_JURATR').AsFloat := (fStrToFloat(edtTaxJur.Text) / 30) * FieldByName('CTR_DIAATR').AsInteger;
            FieldByName('CTR_VALCOB').AsFloat := RoundTo((  (  (
                                                           (
                                                             (fStrToFloat(edtTaxJur.Text) / 30) * FieldByName('CTR_DIAATR').AsInteger
                                                           )/100
                                                         ) * FieldByName('CTR_VALDUP').AsFloat
                                                      )   +
                                                        fStrToFloat(edtValDesCar.Text)
                                                   )     - (FieldByName('CTR_VALJUR').AsFloat - FieldByName('CTR_VALDES').AsFloat),
                                                    -2);
            listaDados.clear;
            Next;
          End;
          First;
          EnableControls;
        End;
end;

procedure TfrmGeraDespesasProtesto.pFiltraDados;
begin
  if cdsConsulta.Active then
  begin
    with cdsConsulta do
    begin
      Filtered := False;
      Filter := '';
      if (StrToInt(edtDiaAtr.Text) > 0) then
      begin
        Filter   := 'CTR_DIAATR >' + IIF(edtDiaAtr.Text = '0', ' ', '= ') + edtDiaAtr.Text;
      end;
      if (fStrToFloat(edtValMin.Text) > 0) then
      begin
        if Filter <> '' then
          Filter   := Filter + ' AND ' ;
        Filter := Filter + ' CTR_VALCOB >= ' + FormatFloat('0.00', fStrToFloat(edtValMin.Text));
      end;

      if Filter <> '' then
      begin
        Filtered := True;
        First;
        If IsEmpty Then
        Begin
          fMensagem('ATENÇÃO!', 'Nenhuma duplicata encontrada!', ['&O k']);
          pSetFocus(mskDtaIni);
          Filtered := False;
          Filter   := '';
          EmptyDataSet;
          QryConsulta.Close;
        End;
      end;
    end;
  end;
end;

procedure TfrmGeraDespesasProtesto.pOrdenaGrid;
begin
  pEditaDados;
  pFiltraDados;
end;

procedure TfrmGeraDespesasProtesto.pProtegeSelect(trava: boolean=False);
begin

  mskDtaIni.Enabled          := not Trava;
  mskDtaFin.Enabled          := not Trava;
  edtCodCli.Enabled          := not Trava;
  edtCodEmp.Enabled          := not Trava;
  edtDiaAtr.Enabled          := not Trava;
  edtTaxJur.Enabled          := not Trava;
  edtValDesCar.Enabled       := not Trava;
  edtValMin.Enabled          := not Trava;
  btnCarregatitulos.Enabled  := not Trava;
end;

procedure TfrmGeraDespesasProtesto.pStep(pgbStatus: TcxProgressBar);
begin
  If Assigned(pgbStatus) Then
  Begin
    pgbStatus.Position := pgbStatus.Position + 1;
    Application.ProcessMessages;
  End;
end;

end.

