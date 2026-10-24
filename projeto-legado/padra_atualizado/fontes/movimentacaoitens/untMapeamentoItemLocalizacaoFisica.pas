unit untMapeamentoItemLocalizacaoFisica;

interface

uses
  Winapi.Windows, Winapi.Messages, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels, untZClient,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxProgressBar,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCitel,
  cxClasses, cxGridLevel, cxGrid, EditFocus, untHelperCitel,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxLabel, MemDS,
  DBAccess, Uni, untTPickingCheckOut, untDllOpeProdFuncoes, untDllOpeProd,
  untPesqAux, System.StrUtils, System.Types, System.SysUtils;

type
  TfrmMapeamentoItemLocalizacaoFisica = class(TfrmPaiConfirma)
    pnlItem: TPanel;
    cxgLocIteLevel: TcxGridLevel;
    cxgLocIteTableView: TcxGridDBTableViewCitel;
    cxgLocIte: TcxGridCitel;
    Label11: TLabel;
    edtLocFis: TEditFocus;
    edtPontoReposicao: TEditFocus;
    Label1: TLabel;
    Label2: TLabel;
    edtQtdMaxima: TEditFocus;
    btnAdicionar: TBitBtnLocked;
    btnCancelaItem: TBitBtnLocked;
    cxgLocIteTableViewCODLOC: TcxGridDBColumn;
    cxgLocIteTableViewQTDREP: TcxGridDBColumn;
    cxgLocIteTableViewQTDMAX: TcxGridDBColumn;
    cxgLocIteTableViewDESLOC: TcxGridDBColumn;
    edtDesLoc: TEditFocus;
    cxgLocIteTableViewTIPLOC: TcxGridDBColumn;
    lblCodOpe: TLabel;
    edtNomOpe: TEditFocus;
    edtCodOpe: TEditFocus;
    Label7: TLabel;
    Label10: TLabel;
    edtCodIte: TEditFocus;
    edtDesIte: TEditFocus;
    edtRefere: TEditFocus;
    Bevel1: TBevel;
    procedure edtLocFisKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnCancelaItemClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxgLocIteTableViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnSairClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtCodOpeKeyPress(Sender: TObject; var Key: Char);
  private
    cdsLocIte : TZClient;
    strLocFis,
    strAutoIncrem : String;
    qryConOpe: TUniQuery;
    strCodOpe: String;
    strIgnLpk: String;
    blnObrigaLotePicking: Boolean;
    blnJaVinculouPicking: Boolean;
    blnJaVinculouLocFisComLotePickingTemporariamente: Boolean;

    procedure pEnableLocalizacao(blnEnabled : Boolean);
    function fAbreDados : Boolean;
    function fGravaDados(cxProgress: TcxProgressBar): Boolean;
    procedure pReseta;
    procedure pCarregaDadosEdicao;
    procedure pDeletaMapeamento;
    procedure pLimpaLocalizacao;
    procedure pGravaLocalizacao(blnCarregaTodos: Boolean = False);

    function fRetSQLCaseTipoDeLocalizacao : String;
    function fValidarEmbalagem: Boolean;
    procedure pCarregaOperador;
    function fLoteExiste(AStrLocFis: String): Boolean;
    function fValidaLocFisIgnorar(AStrCodLoc: String): Boolean;
    function fValidaLocFis(out AStrLocDescri, AStrAutoincrem: String): Boolean;
    function fValidaLotePickingLocFis(ABlnValidaExisteLotePicking: Boolean = False; blnOrigemExclusaoLocFis: Boolean = False; blnOrigemConfirmacao: Boolean = False): Boolean;
    function fEditarLote(AStrAutIncLote, AStrCodIte, AStrCodLoc, AStrDesLoc,
      AStrNumLot: String): Boolean;
    function fVerificaLote(AStrLocFis: String): Boolean;

  public
    blnCarregandoDoPlanoDeRecebimento: Boolean;

  protected
    function fValidaCampos(Sender : TWinControl; blnBuscaPorChave : Boolean) : Boolean; Override;
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples, untConsultas, untTypesSistema, untGravando,
  untCadLoteItens;

procedure TfrmMapeamentoItemLocalizacaoFisica.pGravaLocalizacao(blnCarregaTodos: Boolean = False);
const
  PICKING = ' IFNULL(LOC_PICKIN,"N") = "S" ';
  PICKING_E_PICKING_CHECKOUT = ' ((IFNULL(LOC_PICKIN,"N") = "S") OR (IFNULL(LOC_PICKIN,"N") = "C")) ';

  SQL_CONSULTA_LOCALIZACAO_PIKIN = ' SELECT CADLOT.AUTOINCREM, '+
                                   '      LOC_CODEMP,   '+
                                   '      LOT_CODITE,   '+
                                   '      LOC_CODLOC,   '+
                                   '      LOC_DESCRI,   '+
                                   '     IFNULL(LOT_PONREP, 0) AS LOT_PONREP, '+
                                   '     IFNULL(LOT_CAPACI, 0) AS LOT_CAPACI, '+
                                   '     [TIPO_LOCALIZACAO] ' +
                                   'FROM  CADLOT        '+
                                   '   INNER JOIN CADLOC '+
                                   '            ON LOC_CODLOC = LOT_LOCFIS AND '+
                                   '               LOT_CODEMP = LOC_CODEMP '+
                                   'WHERE LOT_CODEMP = :CODEMP   AND '+
                                   '      LOT_CODITE = :CODITE AND  '+
                                   '      [PICKING] AND '+
                                   '      LOT_STATUS = "S"   ';
var
  qryConsulta: TUniQuery;
  strSQL : String;
  blnResultValida: Boolean;
begin
  inherited;
  strSQL := IIF(TPickingCheckOut.fWMSUtilizaPickingCheckOut,
                SQL_CONSULTA_LOCALIZACAO_PIKIN.Replace('[PICKING]', PICKING_E_PICKING_CHECKOUT),
                SQL_CONSULTA_LOCALIZACAO_PIKIN.Replace('[PICKING]', PICKING));

    strSQL := strSQL.Replace('[TIPO_LOCALIZACAO]', fRetSQLCaseTipoDeLocalizacao);

    If (Not fEmptyStr(fCfgSis('LFNPIM'))) Then
      strSQL := strSQL + fSqlExcecaoLocFisicaMapeamento;

    strLocFis:= '';

    If blnCarregaTodos Then
    Begin

      qryConsulta:= fCriaQuery;
      Try
        qryConsulta.SQL.Clear;
        qryConsulta.SQL.Add(strSQL);
        qryConsulta.ParamByName('CODEMP').AsString:= VS_strCodEmp;
        qryConsulta.ParamByName('CODITE').AsString:= edtCodIte.Text;
        qryConsulta.Open;

        qryConsulta.First;
      While Not qryConsulta.eof do
      Begin
        strLocFis:= qryConsulta.FieldByName('LOC_CODLOC').AsString;
        blnResultValida := fValidaCampos(edtLocFis, False);

        If blnObrigaLotePicking And (Not blnResultValida) Then
        Begin
          pMensagemOk('Falha ao definir lote PICKING!');
          pReseta;
          Exit;
        End;

        If cdsLocIte.Locate('LCI_LOCFIS', strAutoIncrem, []) Then
          cdsLocIte.Edit
        Else
          begin
            cdsLocIte.Append;
            cdsLocIte.FieldByName('LCI_LOCFIS').AsString  := strAutoIncrem;
          end;

          cdsLocIte.FieldByName('LCI_CODEMP').AsString  := qryConsulta.FieldByName('LOC_CODEMP').AsString;
          cdsLocIte.FieldByName('LCI_CODITE').AsString  := qryConsulta.FieldByName('LOT_CODITE').AsString;
          cdsLocIte.FieldByName('LOC_CODLOC').AsString  := qryConsulta.FieldByName('LOC_CODLOC').AsString;
          cdsLocIte.FieldByName('LOC_DESCRI').AsString  := qryConsulta.FieldByName('LOC_DESCRI').AsString;
          If fStrToFloat(cdsLocIte.FieldByName('LCI_QTDREP').AsString) = 0 Then
            cdsLocIte.FieldByName('LCI_QTDREP').AsFloat   := fStrToFloat(qryConsulta.FieldByName('LOT_PONREP').AsString);
          If fStrToFloat(cdsLocIte.FieldByName('LCI_QTDMAX').AsString) = 0 Then
            cdsLocIte.FieldByName('LCI_QTDMAX').AsFloat   := fStrToFloat(qryConsulta.FieldByName('LOT_CAPACI').AsString);

          cdsLocIte.FieldByName('TIPO_LOCALIZACAO').AsString := qryConsulta.FieldByName('TIPO_LOCALIZACAO').AsString;
          cdsLocIte.FieldByname('LCI_CODOPE').AsString  := edtCodOpe.Text;
          cdsLocIte.Post;

          qryConsulta.Next;
        End;
      Finally
        FreeAndNil(qryConsulta);
      End;

    End
    Else
    Begin
      If fValidaCampos(edtLocFis, False) And
         fValidaCampos(edtQtdMaxima, False) And
         fValidaCampos(edtPontoReposicao, False) Then
      Begin

        If cdsLocIte.Locate('LCI_LOCFIS', strAutoIncrem, []) Then
          cdsLocIte.Edit
        Else
        begin
          cdsLocIte.Append;
          cdsLocIte.FieldByName('LCI_LOCFIS').AsString  := strAutoIncrem;
        end;

        cdsLocIte.FieldByName('LCI_CODEMP').AsString  := VS_strCodEmp;
        cdsLocIte.FieldByName('LCI_CODITE').AsString  := edtCodIte.Text;
        cdsLocIte.FieldByName('LOC_CODLOC').AsString  := edtLocFis.Text;
        cdsLocIte.FieldByName('LOC_DESCRI').AsString  := edtDesLoc.Text;
        cdsLocIte.FieldByName('LCI_QTDREP').AsFloat   := fStrToFloat(edtPontoReposicao.Text);
        cdsLocIte.FieldByName('LCI_QTDMAX').AsFloat   := fStrToFloat(edtQtdMaxima.Text);
        cdsLocIte.FieldByname('LCI_CODOPE').AsString  := edtCodOpe.Text;
        cdsLocIte.Post;
      End;

    End;

    pLimpaLocalizacao;
    pSetFocus(edtCodOpe);
end;

procedure TfrmMapeamentoItemLocalizacaoFisica.btnAdicionarClick(Sender: TObject);
Begin
  If fValidaCampos(edtCodOpe, True) Then
    pGravaLocalizacao(False);
End;

procedure TfrmMapeamentoItemLocalizacaoFisica.pLimpaLocalizacao;
begin
  strAutoIncrem := '';
  strLocFis     := '';
  edtLocFis.Clear;
  edtDesLoc.Clear;
  edtPontoReposicao.Clear;
  edtQtdMaxima.Clear;
  strCodOpe := '';
  edtNomOpe.Clear;
  edtCodOpe.Clear;
end;

procedure TfrmMapeamentoItemLocalizacaoFisica.btnCancelaItemClick(Sender: TObject);
begin
  inherited;
  pLimpaLocalizacao;

  pSetFocus(edtCodOpe);
end;

procedure TfrmMapeamentoItemLocalizacaoFisica.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrNone;

  If (not cdsLocIte.Active) or (fEmptyStr(edtCodIte.Text)) Then
  Begin
    fMensagem('', 'Carregue um Item para Salvar o Mapeamento!', ['&OK']);
    Exit;
  End;

  If blnObrigaLotePicking And (Not fValidaLotePickingLocFis(False, False, True)) Then
    Exit;

  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.fExecutarAcao := fGravaDados;
    frmGravando.ShowModal;
  Finally
    FreeAndNil(frmGravando)
  End;

end;

procedure TfrmMapeamentoItemLocalizacaoFisica.btnSairClick(Sender: TObject);
begin
  if not fEmptyStr(edtCodIte.Text) then
  begin
    ModalResult := mrNone;
    pReseta;
  end
  else
    inherited;

end;

procedure TfrmMapeamentoItemLocalizacaoFisica.cxgLocIteTableViewKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_RETURN) Then
  Begin
    pCarregaDadosEdicao;
    pSetFocus(edtCodOpe);
    Key := 0;
  End
  Else
  If (Key = VK_DELETE) Then
  Begin
    pDeletaMapeamento;
    Key := 0;
  End;
end;

function TfrmMapeamentoItemLocalizacaoFisica.fGravaDados(cxProgress : TcxProgressBar) : Boolean;
Begin
  Result := True;
  Try
    cdsLocIte.DisableControls;
    cdsLocIte.First;

    cxProgress.pSetMax(cdsLocIte.RecordCount);

    Result:= True;

    Try
      While Not cdsLocIte.Eof Do
      Begin
        cxProgress.pStep;

        If (StrToIntDef(cdsLocIte.FieldByName('LCI_QTDREP').AsString, -1) < 0) Then
        Begin
          fMensagem('', 'A Quantidade do Ponto de Reposição deve ser maior ou igual a 0 para a '+#13#10+' localização: '+cdsLocIte.FieldByName('LOC_CODLOC').AsString+'!', ['&OK']);
          Result:= False;
          Break;
        End
        Else
        If (StrToIntDef(cdsLocIte.FieldByName('LCI_QTDMAX').AsString, -1) <= 0) Then
        Begin
          fMensagem('', 'A Quantidade Máxima deve ser maior que 0 para a '+#13#10+' localização: '+cdsLocIte.FieldByName('LOC_CODLOC').AsString+' !', ['&OK']);
          Result:= False;
          Break;
        End
        else
        if not fEmptyStr(cdsLocIte.FieldByName('LCI_QTDREP').AsString) then
        begin
          If (StrToIntDef(cdsLocIte.FieldByName('LCI_QTDMAX').AsString, 0) <= StrToIntDef(cdsLocIte.FieldByName('LCI_QTDREP').AsString, 0)) Then
          Begin
            fMensagem('', 'A Quantidade Máxima deve ser maior que o ponto de reposição para a '+#13#10+' localização: '+cdsLocIte.FieldByName('LOC_CODLOC').AsString+' !', ['&OK']);
            Result:= False;
            Break;
          End;
        end;


        If fEmptyStr(cdsLocIte.FieldByName('AUTOINCREM').AsString) Then
        Begin
          cdsLocIte.Edit;
          cdsLocIte.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('LOCITE', VS_strCodEmp);
          cdsLocIte.Post;
        End;

        If Not fLoteExiste(cdsLocIte.FieldByName('LOC_CODLOC').AsString) Then
          TfrmCadLoteItens.pCadastroRapidoMapeamentoLocFis(edtCodIte.Text, cdsLocIte.FieldByName('LOC_CODLOC').AsString);

        cdsLocIte.Next;
      End;

      If Result Then
        Result := cdsLocIte.fSalva;

    Except
      On E : Exception Do
      Begin
        Result := False;
        pMensagensErro(e.Message, 'TfrmMapeamentoItemLocalizacaoFisica.fGravaDados');
      End;
    End;

  Finally
    cdsLocIte.First;
    cdsLocIte.EnableControls;

    If Result Then
      pReseta;
  End;

End;

procedure TfrmMapeamentoItemLocalizacaoFisica.edtLocFisKeyPress(Sender: TObject; var Key: Char);
  Var
    arrLocFis : TConsultasArray;
begin
  inherited;
  If fPesqLocFisicaMapeamento(Self, edtLocFis, Nil, Nil, Key, arrLocFis, edtCodIte.Text, True) Then
  Begin
    If (fValidaCampos(edtLocFis, True)) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmMapeamentoItemLocalizacaoFisica.edtCodIteKeyPress(Sender: TObject; var Key: Char);
  Var
    arrCadIte : TConsultasArray;
begin
  inherited;
  if fPesqItem(conIteSimples, Self, edtCodIte, edtDesIte, Nil, Key, arrCadIte) Then
  Begin
    If fValidaCampos(edtCodIte, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmMapeamentoItemLocalizacaoFisica.edtCodOpeKeyPress(Sender: TObject;
  var Key: Char);
var
  arrSel: TConsultasArray;
begin
  inherited;
  If (Key = ',') or (Key = '+') Then
  Begin
    Key := #0;
    Exit;
  End;

  Try
    if fPesqOperador(Self, edtCodOpe, edtNomOpe, qryConOpe, Key, arrSel) then
    Begin
      If fValidaCampos(edtCodOpe, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  Except
    On E: Exception Do
    Begin
      fMensagem('', 'Erro na busca rápida: ' + E.Message, ['&O k']);
    End;
  End;
end;

function TfrmMapeamentoItemLocalizacaoFisica.fAbreDados: Boolean;
begin
  If cdsLocIte.Active Then
    cdsLocIte.EmptyDataSet;

  cdsLocIte.qryQuery.Close;
  cdsLocIte.qryQuery.ParamByName('CODITE').AsString := edtCodIte.Text;
  cdsLocIte.qryQuery.ParamByName('CODEMP').AsString := VS_strCodEmp;
  Result := cdsLocIte.fAbreClient(True, 'TfrmMapeamentoItemClasseLocFis.fAbreDados');

  cxgLocIteTableView.DataController.DataSource := cdsLocIte.dtsSource;

  If blnObrigaLotePicking And (Not fValidaLotePickingLocFis(True)) Then
  Begin
    Result := False;
    pReseta;
  End;
end;

procedure TfrmMapeamentoItemLocalizacaoFisica.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If (cdsLocIte.Active) And (not cdsLocIte.IsEmpty) Then
  Begin
    Action := caNone;
    If fMensagem('', 'Deseja Cancelar?', ['&Sim', '&Não'], 2) = 1 Then
    Begin
      cdsLocIte.EmptyDataSet;
      pReseta;
    End;
  End;

end;

procedure TfrmMapeamentoItemLocalizacaoFisica.FormCreate(Sender: TObject);
begin
  inherited;
  pSetaCodIte(edtCodIte);

  cdsLocIte := TZClient.Create(Self);
  cdsLocIte.qryQuery.SQL.Add('SELECT                                                ');
  cdsLocIte.qryQuery.SQL.Add('  LOCITE.*,                                           ');
  cdsLocIte.qryQuery.SQL.Add('  LOC_CODLOC,                                         ');
  cdsLocIte.qryQuery.SQL.Add('  LOC_DESCRI,                                         ');
  cdsLocIte.qryQuery.SQL.Add(fRetSQLCaseTipoDeLocalizacao);
  cdsLocIte.qryQuery.SQL.Add('FROM                                                  ');
  cdsLocIte.qryQuery.SQL.Add('  LOCITE                                              ');
  cdsLocIte.qryQuery.SQL.Add('  INNER JOIN CADLOC ON CADLOC.AUTOINCREM = LCI_LOCFIS ');
  cdsLocIte.qryQuery.SQL.Add('WHERE                                                 ');
  cdsLocIte.qryQuery.SQL.Add('      LCI_CODITE = :CODITE                            ');
  cdsLocIte.qryQuery.SQL.Add('  AND LCI_CODEMP = :CODEMP                            ');

  cxgLocIteTableViewTIPLOC.Visible := TPickingCheckOut.fWMSUtilizaPickingCheckOut Or
                                      fUsaPickingLaboratorioWms;

  blnCarregandoDoPlanoDeRecebimento := False;

  qryConOpe := fCriarQuery('SELECT * FROM CADOPE WHERE FALSE', Self);
  strCodOpe   := '';

  strIgnLpk := fCfgSis('IGNLPK', varString);
  blnObrigaLotePicking := fCfgSis('OBRLPK', varBoolean) And fCfgSis('LOTPIC', varBoolean);
end;

procedure TfrmMapeamentoItemLocalizacaoFisica.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_F10 : btnConfirma.Click;
  end;
end;

procedure TfrmMapeamentoItemLocalizacaoFisica.FormShow(Sender: TObject);
begin
  inherited;
  If blnCarregandoDoPlanoDeRecebimento Then
    fValidaCampos(edtCodIte, True);
end;

function TfrmMapeamentoItemLocalizacaoFisica.fRetSQLCaseTipoDeLocalizacao: String;
begin
  Result := ' (CASE ';

  If fUsaPickingLaboratorioWms Then
  Begin
    Result := Result + ' WHEN (IFNULL(LOC_PICKIN,"N") = "S") AND (IFNULL(LOC_PRILAB,"N") = "S") THEN "Picking laboratório" ';
    Result := Result + ' WHEN (IFNULL(LOC_PICKIN,"N") = "S") AND (IFNULL(LOC_PRILAB,"N") = "N") THEN "Picking" ';
  End
  Else
    Result := Result + ' WHEN (IFNULL(LOC_PICKIN,"N") = "S") THEN "Picking" ';

  Result := Result + '   WHEN (IFNULL(LOC_PICKIN,"N") = "C") THEN "Picking checkout" ';
  Result := Result + '   WHEN (IFNULL(LOC_PICKIN,"N") = "N") THEN "Buffer"  ';
  Result := Result + '   WHEN (IFNULL(LOC_PICKIN,"N") = "E") THEN "Excesso" ';
  Result := Result + ' ELSE "" END) AS TIPO_LOCALIZACAO ';
end;

function TfrmMapeamentoItemLocalizacaoFisica.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
  var
    strLocDescr,
    strAutInc,
    strMSG   : String;
begin
  Result := Inherited fValidaCampos(Sender, blnBuscaPorChave);

  If Result Then
  Begin
    If (Sender = edtCodIte) And blnBuscaPorChave Then
    Begin
      If fEmptyStr(edtCodIte.Text) Then
      Begin
        Result := fMensagem('', 'Informe o Código do Item Para Realizar o Mapeamento!', ['&OK']) = -1;
      End
      Else
      Begin
        edtDesIte.Text := fRetNomProduto(edtCodIte.Text);
        edtRefere.Text := fRetReferenciaProd(edtCodIte.Text);

        Result := fValidarEmbalagem;

        If Result Then
        Begin
          If fEmptyStr(edtDesIte.Text) Then
            Result := fMensagem('', 'Produto não Encontrado!', ['&OK']) = -1
          Else If fAbreDados Then
          Begin
            pEnableLocalizacao(True);
            blnMudarFoco := False;
            edtCodIte.Enabled := False;
            pSetFocus(edtCodOpe);

            strMSG := IIF(TPickingCheckOut.fWMSUtilizaPickingCheckOut,
                          'Deseja carregar as localizações do tipo picking e picking checkout já cadastradas?',
                          'Deseja carregar as localizações do tipo picking já cadastradas?');

            If fPergunta(strMSG) Then
              pGravaLocalizacao(True);

          End
          Else
          Begin
            If blnObrigaLotePicking Then
              Result := False;
          End;
        End;

      End;

    End

    Else If (Sender = edtLocFis)  Then
    Begin
      edtDesLoc.Clear;
      strAutoIncrem := '';

      If (fEmptyStr(edtLocFis.Text)) And fEmptyStr(strLocFis) Then
      Begin
        pSetFocus(cxgLocIte);
        blnMudarFoco := False;
      End
      Else
      Begin
        Result := fValidaLocfis(strLocDescr, strAutInc);
        If Result And blnObrigaLotePicking Then
        Begin
          Result := fValidaLotePickingLocFis;
          blnJaVinculouLocFisComLotePickingTemporariamente := Result;
        End;

        If Result Then
        begin
          edtDesLoc.Text := strLocDescr;
          strAutoIncrem  := strAutInc;

          if blnBuscaPorChave and cdsLocIte.Locate('LCI_LOCFIS', strAutoIncrem, []) then
            pCarregaDadosEdicao;
        end;

      End;

    End

    Else If (Sender = edtPontoReposicao)  Then
    Begin

      If (StrToIntDef(edtPontoReposicao.Text, -1) < 0) Then
        Result := fMensagem('', 'A Quantidade do Ponto de Reposição deve ser maior ou igual a 0 !', ['&OK']) = -1;

    End

    Else If (Sender = edtQtdMaxima)  Then
    Begin

      If (StrToIntDef(edtQtdMaxima.Text, -1) <= 0) Then
        Result := fMensagem('', 'A Quantidade Máxima deve ser maior que 0 !', ['&OK']) = -1
      else if not fEmptyStr(edtPontoReposicao.Text) then
      begin

        If (StrToIntDef(edtQtdMaxima.Text, 0) <= StrToIntDef(edtPontoReposicao.Text, 0)) Then
          Result := fMensagem('', 'A Quantidade Máxima deve ser maior que o ponto de reposição !', ['&OK']) = -1

      end;

    End
    Else If (Sender = edtCodOpe) Then
    Begin

      If fEmptyStr(edtCodOpe.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O operador deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin

        pCarregaOperador;
        If qryConOpe.FieldByName('OPE_CODOPE').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse operador não está cadastrado!', ['&O k']);
          Result := False;
        End
        Else If (strCodOpe <> edtCodOpe.Text) Then
        Begin
          If (ffrmSenha(strSenha)) Then
            Begin

              If (strSenha <> fDecrypt(qryConOpe.FieldByName('OPE_SENOPE').AsString)) Then
              Begin
                fMensagem('ATENÇÃO!', 'Senha Invalida!', ['&O k']);
                edtNomOpe.Clear;
                Result := False;
              End
              Else
              Begin
                strCodOpe := edtCodOpe.Text;
              End;

            End
            Else
            Begin
              Result := False;
            End;
        End;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmMapeamentoItemLocalizacaoFisica.pEnableLocalizacao(blnEnabled: Boolean);
begin
  edtLocFis.Enabled := blnEnabled;
  edtQtdMaxima.Enabled := blnEnabled;
  edtPontoReposicao.Enabled := blnEnabled;
  btnAdicionar.Enabled := blnEnabled;
  btnCancelaItem.Enabled := blnEnabled;
  edtCodOpe.Enabled := blnEnabled;
  edtNomOpe.Enabled := blnEnabled;
end;

procedure TfrmMapeamentoItemLocalizacaoFisica.pReseta;
Begin
  if cdsLocIte.Active Then
    cdsLocIte.EmptyDataSet;

  edtCodIte.Clear;
  edtDesIte.Clear;
  edtRefere.Clear;

  edtCodOpe.Clear;
  edtNomOpe.Clear;

  pLimpaLocalizacao;

  edtCodIte.Enabled := True;
  pEnableLocalizacao(False);
  pSetFocus(edtCodIte);

  blnJaVinculouPicking := False;
  blnJaVinculouLocFisComLotePickingTemporariamente := False;
End;

procedure TfrmMapeamentoItemLocalizacaoFisica.pCarregaDadosEdicao;
Begin
  strAutoIncrem  := cdsLocIte.FieldByName('LCI_LOCFIS').AsString;
  edtLocFis.Text := cdsLocIte.FieldByName('LOC_CODLOC').AsString;
  edtDesLoc.Text := cdsLocIte.FieldByName('LOC_DESCRI').AsString;
  edtPontoReposicao.Text := cdsLocIte.FieldByName('LCI_QTDREP').AsString;
  edtQtdMaxima.Text := cdsLocIte.FieldByName('LCI_QTDMAX').AsString;
  If fEmptyStr(edtCodOpe.Text) Then
    edtCodOpe.Text := cdsLocIte.FieldByName('LCI_CODOPE').AsString;
End;

procedure TfrmMapeamentoItemLocalizacaoFisica.pDeletaMapeamento;
Begin
  If fPergunta('Deseja Excluir esse Mapeamento?') Then
    cdsLocIte.Delete;

  blnJaVinculouLocFisComLotePickingTemporariamente := blnObrigaLotePicking And fValidaLotePickingLocFis(False, True);
End;

function TfrmMapeamentoItemLocalizacaoFisica.fValidarEmbalagem: Boolean;
var
  strEmbala,
  strCodIte,
  strMsg: String;
  blnTemDireitoAcesso: Boolean;
begin
  Try
    strCodIte := edtCodIte.Text;
    strEmbala := fCampoTabela('BAR_EMBALA', 'ITEBAR', ['BAR_CODITE','BAR_COMPRA'], [strCodIte,'1']);
    Result := strEmbala <> '0';

    If Result Then
      Exit(True);

    blnTemDireitoAcesso := fVerificaAcessoSistema('frmDigCodBarLocFis', strLoginUsuarioLogado);

    strMsg := 'Este produto não tem nenhum código de barras informado como ''Principal para compra'''+'.'+ #13 +
              'Será necessário ajustar o cadastro de produtos para que seja permitido o mapeamento de localizações físicas.' + #13 +
              IIF(blnTemDireitoAcesso, 'Utilize o botão ''Atalho'' para acessar a rotina de digitação de cód.barras/loc.físicas','');

    If Not Result Then
    Begin
      If blnTemDireitoAcesso Then
      Begin
        If fMensagem('ATENÇÃO', strMsg, ['&Atalho', '&Cancelar']) = 1 Then
          pOpeProd(DigCodBarLocFis, '', 0, strCodIte);
      End
      Else
      Begin
        pMensagemOk(strMsg);
      End;
    End;
  Finally
    strEmbala := fCampoTabela('BAR_EMBALA', 'ITEBAR', ['BAR_CODITE','BAR_COMPRA'], [strCodIte,'1']);
    If strEmbala = '0' Then
    Begin
      edtCodIte.Clear;
      edtDesIte.Clear;
      pSetFocus(edtCodIte);
    End;
  End;
end;

procedure TfrmMapeamentoItemLocalizacaoFisica.pCarregaOperador;
begin
  pPesquisaCadOpe(qryConOpe, qryConOpe, edtCodOpe.Text);
  With qryConOpe Do
  Begin
    edtNomOpe.Text := FieldByName('OPE_NOMOPE').AsString;
  End;
end;

function TfrmMapeamentoItemLocalizacaoFisica.fLoteExiste(AStrLocFis: String): Boolean;
var
  qryAux: TUniQuery;
begin
  qryAux := fCriaQuery;
  Try
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT SQL_NO_CACHE AUTOINCREM  ');
    qryAux.SQL.Add(' FROM CADLOT                    ');
    qryAux.SQL.Add(' WHERE TRUE                     ');
    qryAux.SQL.Add('   AND LOT_CODITE = :CODITE     ');
    qryAux.SQL.Add('   AND LOT_CODEMP = :CODEMP     ');
    qryAux.SQL.Add('   AND LOT_LOCFIS = :LOCFIS     ');

    qryAux.ParamByName('CODITE').AsString := edtCodIte.Text;
    qryAux.ParamByName('CODEMP').AsString := VS_StrCodEmp;
    qryAux.ParamByName('LOCFIS').AsString := AStrLocFis;

    qryAux.Open;

    Result := Not qryAux.IsEmpty;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function TfrmMapeamentoItemLocalizacaoFisica.fValidaLocFisIgnorar(AStrCodLoc: String):Boolean;
var
  arrIgnorar: TStringDynArray;
  strCodLoc: String;
  intCont,
  intLength: Integer;
begin
  Result := True;

  If fEmptyStr(strIgnLpk) Then
    Exit;

  arrIgnorar := SplitString(strIgnLpk, ',');
  For intCont := 0 To Length(arrIgnorar)-1 Do
  Begin
    strCodLoc := arrIgnorar[intCont];
    If (Pos('*', strCodLoc) > 0) Then
    Begin
      strCodLoc := StringReplace(strCodLoc, '*','',[rfReplaceAll]);
      intLength := Length(strCodLoc);
      If (Pos(Copy(AStrCodLoc,0,intLength), strCodLoc) > 0) Then
        Exit(False)
    End
    Else
    If AStrCodLoc = strCodLoc Then
      Exit(False);
  End;
end;

function TFrmMapeamentoItemLocalizacaoFisica.fValidaLocFis(out AStrLocDescri, AStrAutoincrem: String): Boolean;
var
  qryQuery: TUniQuery;
begin
  qryQuery := fCriaQuery;
  Result := True;
  try
    qryQuery.SQL.Clear;
    qryQuery.SQL.Add('SELECT AUTOINCREM, LOC_DESCRI, LOC_PICKIN, LOC_PDERPD, LOC_ITEPIC ');

    If (Not fEmptyStr(fCfgSis('LFNPIM'))) Then
      qryQuery.SQL.Add(', (TRUE '+fSqlExcecaoLocFisicaMapeamento+') AS PERMITIDO ')
    Else
      qryQuery.SQL.Add(', TRUE AS PERMITIDO ');

    qryQuery.SQL.Add('FROM CADLOC WHERE LOC_CODEMP = :CODEMP AND LOC_CODLOC = :CODLOC ');

    qryQuery.ParamByName('CODEMP').AsString := VS_strCodEmp;

    If fEmptyStr(strLocFis) Then
      qryQuery.ParamByName('CODLOC').AsString := edtLocFis.Text
    Else
      qryQuery.ParamByName('CODLOC').AsString := strLocFis;

    qryQuery.Open;

    if qryQuery.isEmpty then
      Result := fMensagem('', 'Localização Física não Encontrada', ['&OK']) = -1
    else if qryQuery.FieldByName('PERMITIDO').AsString = '0' then
      Result := fMensagem('', 'Essa localização foi adicionada na configuração "CFG_LFNPIM" e não pode ser informada no mapeamento!', ['&OK']) = -1
    else if qryQuery.FieldByName('LOC_PICKIN').AsString = 'N' then
      Result := fMensagem('', 'Essa localização não é PICKIN e não pode ser mapeada!', ['&OK']) = -1
    else if (((qryQuery.FieldByName('LOC_ITEPIC').AsString <> edtCodIte.Text) And Not (fEmptyStr(qryQuery.FieldByName('LOC_ITEPIC').AsString))) And (qryQuery.FieldByName('LOC_PDERPD').AsString = 'N')) Then
      Result := fMensagem('', 'Essa localização não permite produto diferente e seu item para picking é o ' + qryQuery.FieldByName('LOC_ITEPIC').AsString , ['&Ok']) = -1
    else
    If (Not fValidaLocFisIgnorar(edtLocFis.Text)) Then
    Begin
      pMensagemOk('Localização física não permitida pela configuração [CFG_IGNLPK]!');
      Result := False;
    End;

    If Result Then
    Begin
      AStrLocDescri  := qryQuery.FieldByName('LOC_DESCRI').AsString;
      AStrAutoincrem := qryQuery.FieldByName('AUTOINCREM').AsString;
    End;

  finally
    FreeAndNil(qryQuery);
  end;
end;

function TfrmMapeamentoItemLocalizacaoFisica.fValidaLotePickingLocFis(ABlnValidaExisteLotePicking: Boolean = False; blnOrigemExclusaoLocFis: Boolean = False; blnOrigemConfirmacao: Boolean = False): Boolean;
var
  qryCons: TUniQuery;
  strNumLot: String;
  blnPrimeiraInsercao: Boolean;
begin
  blnPrimeiraInsercao := cdsLocIte.IsEmpty;
  Result := True;

  If (Not blnOrigemExclusaoLocFis) And (blnJaVinculouLocFisComLotePickingTemporariamente) Then
    Exit(True);

  qryCons := fCriaQuery;
  Try
    qryCons.SQL.Clear;
    qryCons.SQL.Add(' SELECT LOT_NUMLOT FROM CADLOT WHERE LOT_NUMLOT = "PICKING" AND LOT_CODEMP = :CODEMP AND LOT_CODITE = :CODITE LIMIT 1');
    qryCons.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryCons.ParamByName('CODITE').AsString := edtCodIte.Text;
    qryCons.Open;

    If qryCons.IsEmpty Then
    Begin
      pMensagemOk('Conforme configurações do sistema, é necessário criar lote chamado ''PICKING'' associado a localização física picking para prosseguir com o mapeamento!');
      If ABlnValidaExisteLotePicking Then
        Exit(False);
    End
    Else
    Begin
      If ABlnValidaExisteLotePicking Then
        Exit(True);
    End;

    If blnPrimeiraInsercao Then
    Begin
      If blnOrigemExclusaoLocFis THen
        Exit(False);

      If blnOrigemConfirmacao Then
        Exit(False);

      If fEmptyStr(edtLocFis.Text) Then
        Exit;

      Result := fVerificaLote(edtLocFis.Text);
    End
    Else
    If Not (fEmptyStr(edtLocFis.Text)) Then
    Begin
      Result := fVerificaLote(edtLocFis.Text);
    End
    Else
    Begin
      Try
        cdsLocIte.DisableControls;
        cdsLocIte.First;
        While Not cdsLocIte.Eof Do
        Begin
          strNumLot := fCampoTabela('LOT_NUMLOT','CADLOT',['LOT_LOCFIS','LOT_CODITE','LOT_CODEMP','LOT_STATUS'], [cdsLocIte.FieldByName('LOC_CODLOC').AsString, edtCodIte.Text, VS_StrCodEmp, 'S']);
          blnJaVinculouPicking := strNumLot = 'PICKING';
          If blnJaVinculouPicking  Then
            Exit(True);

          cdsLocIte.Next;
        End;

        If Not blnJaVinculouPicking Then
        Begin
          cdsLocIte.First;
          Result := fVerificaLote(cdsLocIte.FieldByName('LOC_CODLOC').AsString);
        End;
      Finally
        cdsLocIte.EnableControls;
      End;
    End;
  Finally
    FreeAndNil(qryCons);
  End;
end;

function TfrmMapeamentoItemLocalizacaoFisica.fEditarLote(AStrAutIncLote, AStrCodIte, AStrCodLoc, AStrDesLoc, AStrNumLot: String): Boolean;
begin
  If Not fVerificaAcessoSistema('frmCadLoteItens') Then
  Begin
    pMensagemOk('Operador sem direito de acesso ao cadastro de lotes!');
    Exit(False);
  End;

  Result := TFrmCadLoteItens.fEditarLote(AStrAutIncLote, AStrCodIte, AStrCodLoc, AStrDesLoc, AStrNumLot);

end;

function TfrmMapeamentoItemLocalizacaoFisica.fVerificaLote(AStrLocFis: String): Boolean;
var
  qryCons: TUniQuery;
begin
  Result := True;
  qryCons := fCriaQuery;
  Try
    qryCons.SQL.Clear;
    qryCons.SQL.Add('SELECT LOT_NUMLOT, LOT_LOCFIS, LOT_STATUS FROM CADLOT WHERE LOT_NUMLOT = "PICKING" AND LOT_CODEMP = :CODEMP AND LOT_CODITE = :CODITE AND LOT_STATUS = "S"');
    qryCons.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryCons.ParamByName('CODITE').AsString := edtCodIte.Text;
    qryCons.Open;

    If qryCons.FieldByName('LOT_LOCFIS').AsString = AStrLocFis Then
    Begin
      Exit(True);
    End;

    qryCons.SQL.Clear;
    qryCons.SQL.Add('SELECT AUTOINCREM, LOT_NUMLOT, LOT_LOCFIS, LOT_STATUS FROM CADLOT WHERE LOT_NUMLOT = "PICKING" AND LOT_CODEMP = :CODEMP AND LOT_CODITE = :CODITE ');
    qryCons.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryCons.ParamByName('CODITE').AsString := edtCodIte.Text;
    qryCons.Open;

    If qryCons.FieldByName('LOT_LOCFIS').AsString <> AStrLocFis Then
    Begin
      pMensagemOk('A localização física ' + AStrLocFis + ' selecionada, deve ser associada ao lote chamado ''PICKING''');
      Result := fEditarLote(qryCons.FieldByName('AUTOINCREM').AsString, edtCodIte.Text, AStrLocFis, fRetNomLocFisica(edtLocFis.Text), 'PICKING');
    End
    Else
    If qryCons.FieldByName('LOT_STATUS').AsString <> 'S' Then
    Begin
      pMensagemOk('A localização física ' + AStrLocFis + ' selecionada está associada ao lote chamado ''PICKING'' mas o mesmo não está ATIVO');
      Result := fEditarLote(qryCons.FieldByName('AUTOINCREM').AsString, edtCodIte.Text, AStrLocFis, fRetNomLocFisica(AStrLocFis), 'PICKING');
    End;
  Finally
    FreeAndNil(qryCons);
  End;
end;

end.
