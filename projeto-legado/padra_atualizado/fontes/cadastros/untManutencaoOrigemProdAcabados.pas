unit untManutencaoOrigemProdAcabados;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, EditFocus, Uni, untTypesSistema, untConsultas;

type
  TfrmManutencaoOrigemProdAcabados = class(TfrmPai)
    grbSubProdAtual: TGroupBox;
    edtCodProdutoAcabado: TEditFocus;
    edtNomeProdutoAcabado: TEditFocus;
    Label2: TLabel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    edtCodProdutoGranelOrigem: TEditFocus;
    edtNomeProdutoGranelOrigem: TEditFocus;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    edtCodProdutoComposicaoOrigem: TEditFocus;
    edtNomeProdutoComposicaoOrigem: TEditFocus;
    GroupBox3: TGroupBox;
    Label4: TLabel;
    edtCodProdutoGranelNovo: TEditFocus;
    edtNomeProdutoGranelNovo: TEditFocus;
    GroupBox4: TGroupBox;
    Label5: TLabel;
    edtCodProdutoComposicaoNovo: TEditFocus;
    edtNomeProdutoComposicaoNovo: TEditFocus;
    btnConfirma: TBitBtnLocked;
    Label6: TLabel;
    edtNomeCorGranelOrigem: TEditFocus;
    Label7: TLabel;
    edtNomeCorGranelNovo: TEditFocus;
    edtCodCorGranelOrigem: TEditFocus;
    edtCodCorGranelNovo: TEditFocus;
    Label8: TLabel;
    edtReferenciaAcabado: TEditFocus;
    Label9: TLabel;
    edtUniMedidaAcabado: TEditFocus;
    Label10: TLabel;
    edtReferenciaGranelOrigem: TEditFocus;
    Label11: TLabel;
    edtUniMedidaGranelOrigem: TEditFocus;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtCodProdutoAcabadoKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCorGranelOrigemKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCorGranelNovoKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodProdutoGranelNovoKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodProdutoComposicaoNovoKeyPress(Sender: TObject;
      var Key: Char);
    procedure edtCodCorGranelNovoExit(Sender: TObject);
    procedure edtCodProdutoComposicaoOrigemExit(Sender: TObject);
    procedure edtCodProdutoGranelNovoExit(Sender: TObject);
    procedure edtCodProdutoComposicaoNovoExit(Sender: TObject);
  private
    qryConIte: TUniQuery;
    qryConCor: TUniQuery;
    bSalvar  : Boolean;
    sCodUniMedia: String;
    procedure pCarregaProdutoAcabado(qryConsulta: TUniQuery);
    procedure pCarregaProdutoCompos(sProduto, sComposicao: String);
    procedure pCarregaComposicao;
    procedure pCarregaProdutoGranelNovo(qryConsulta: TUniQuery);
    procedure pCarregaCorNovo(qryConsulta: TUniQuery);
    procedure pCarregaProdutoGranel(iCodProduto: String);
    procedure pLog(sData, sHora, sUsuario, sCodProdAcabado, sCodProdAtual,
                   sCodProdNovo, sCodCorAtual, sCodCorNovo, sCodComAtual, sCodComNovo: String);
    procedure pLimpaCampos;
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
    function fTipoProduto(sTipo, sCodProduto: String): String;//G=Granel, E=Embalagem, A=Acabado

    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmManutencaoOrigemProdAcabados: TfrmManutencaoOrigemProdAcabados;

implementation

uses untFuncoesSimples, untPesqAux;

{$R *.dfm}

procedure TfrmManutencaoOrigemProdAcabados.btnConfirmaClick(Sender: TObject);
var
  qryGenTemp: TUniQuery;
begin
  inherited;
  bSalvar:= True;
  If fVerificaCampos Then
  Begin
    qryGenTemp:= fCriaQuery(Self);
    Try
      qryGenTemp.Close;
      qryGenTemp.SQL.Clear;
      qryGenTemp.SQL.Add('SELECT      '+
                         ' ITE_CODPAG,'+
                         ' ITE_CODCOR,'+
                         ' ITE_CODUNI,'+
                         ' UNI_PESLIT,'+
                         ' UNI_KILLIT '+
                         'FROM        '+
                         '  CADITE    '+
                         '  INNER JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI '+
                         'WHERE ITE_CODPAG = :ITE_CODPAG '+
                         '  AND ITE_CODCOR = :ITE_CODCOR '+
                         '  AND ITE_CODUNI = :ITE_CODUNI ');

      qryGenTemp.ParamByName('ITE_CODPAG').AsString:= edtCodProdutoGranelNovo.Text;
      qryGenTemp.ParamByName('ITE_CODCOR').AsString:= edtCodCorGranelNovo.Text;
      qryGenTemp.ParamByName('ITE_CODUNI').AsString:= sCodUniMedia;
      qryGenTemp.Open;

      If (qryGenTemp.FieldByName('ITE_CODPAG').AsString <> '') or
        (Not(qryGenTemp.FieldByName('ITE_CODPAG').IsNull)) Then
      Begin
        fMensagem('', 'Já existe uma combinação para o produto informado!', ['&Ok']);
        bSalvar:= False;
        pSetFocus(edtCodProdutoGranelNovo);
        Exit;
      End;
      fStartTransaction;

      qryGenTemp.Close;
      qryGenTemp.SQL.Clear;
      qryGenTemp.SQL.Add('UPDATE CADITE SET           '+
                         '  ITE_CODPAG = :ITE_CODPAG, '+
                         '  ITE_CODCOR = :ITE_CODCOR, '+
                         '  ITE_CODCOM = :ITE_CODCOM  '+
                         'WHERE ITE_CODITE = :ITE_CODITE');

      If (edtCodProdutoGranelNovo.Text <> '') Then
        qryGenTemp.ParamByName('ITE_CODPAG').AsString:= edtCodProdutoGranelNovo.Text;

      If (edtCodCorGranelNovo.Text <> '') then
        qryGenTemp.ParamByName('ITE_CODCOR').AsString:= edtCodCorGranelNovo.Text;

      If (edtCodProdutoComposicaoNovo.Text <> '') Then
        qryGenTemp.ParamByName('ITE_CODCOM').AsString:= edtCodProdutoComposicaoNovo.Text;

      qryGenTemp.ParamByName('ITE_CODITE').AsString:= edtCodProdutoAcabado.Text;
      qryGenTemp.ExecSQL;

      pLog(DateToStr(fNow),
           TimeToStr(fNow),
           strLoginUsuarioLogado,
           edtCodProdutoAcabado.Text,
           edtCodProdutoGranelOrigem.Text,
           edtCodProdutoGranelNovo.Text,
           edtCodCorGranelOrigem.Text,
           edtCodCorGranelNovo.Text,
           edtCodProdutoComposicaoOrigem.Text,
           edtCodProdutoComposicaoNovo.Text);
      fCommit;
      fMensagem('', 'Manutenção realizada com sucesso!', ['&Ok']);
      pSetFocus(edtCodProdutoAcabado);
      pLimpaCampos;
      bSalvar:= False;
      edtCodProdutoAcabado.Text:= '';
    Finally
      FreeAndNil(qryGenTemp);
      if fStartTransaction then
        fRollBack;
      bSalvar:= False;
    End;

  End;
end;

procedure TfrmManutencaoOrigemProdAcabados.edtCodCorGranelNovoExit(
  Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtCodCorGranelNovo.Text) Then
  Begin
    edtNomeCorGranelNovo.Text:= '';
  End;
end;

procedure TfrmManutencaoOrigemProdAcabados.edtCodCorGranelNovoKeyPress(
  Sender: TObject; var Key: Char);
  Var
    arrCor : TConsultasArray;
begin
  inherited;

  If fEntraCons(Key) Then
  Begin
    If fPesqCores(Self, edtCodCorGranelNovo, edtNomeCorGranelNovo, qryConCor, Key, arrCor) then
    Begin
      pCarregaCorNovo(qryConCor);
      SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmManutencaoOrigemProdAcabados.edtCodCorGranelOrigemKeyPress(
  Sender: TObject; var Key: Char);
  Var
    arrCor : TConsultasArray;
begin
  inherited;

  If fEntraCons(Key) Then
  Begin
    if fPesqCores(Self, edtCodCorGranelOrigem, edtNomeCorGranelOrigem, qryConCor, Key, arrCor) then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmManutencaoOrigemProdAcabados.edtCodProdutoAcabadoKeyPress(
  Sender: TObject; var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;

  If fEntraCons(Key) Then
  Begin
    Try
      //if fPesqItem(conIteSimples, Self, edtCodProdutoAcabado, edtNomeProdutoAcabado, qryConIte, Key, arrSel, True, nil, 'Consulta de Itens', '1',
      //            '',0,False,False,0,cdrCodIte,'',False,'',True,False,False,'',False,True) then

      if fPesqItem(conIteSimples, Self, edtCodProdutoAcabado, edtNomeProdutoAcabado, qryConIte, Key, arrSel, True, nil, 'Consulta de Itens', '1',
                  '',0,False,False,0,cdrCodIte,'',False,'','',True,False,False,'',False,True) then
      Begin
        pCarregaProdutoAcabado(qryConIte);
        SelectNext(ActiveControl, True, True);
      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[frmManutencaoOrigemProdAcabados.edtCodProdutoAcabadoKeyPress]');
      End;
    End;

  End;
end;

procedure TfrmManutencaoOrigemProdAcabados.edtCodProdutoComposicaoNovoExit(
  Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtCodProdutoComposicaoNovo.Text) Then
  Begin
    edtCodProdutoComposicaoNovo.Text:= '';
  End;

end;

procedure TfrmManutencaoOrigemProdAcabados.edtCodProdutoComposicaoNovoKeyPress(
  Sender: TObject; var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    Try
      If fPesqComposicao(Self, edtCodProdutoComposicaoNovo, edtNomeProdutoComposicaoNovo, Nil, Key, arrSel) then
      Begin
        SelectNext(ActiveControl, True, True);
      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[frmManutencaoOrigemProdAcabados.edtCodProdutoComposicaoNovoKeyPress]');
      End;
    End;

  End;
end;

procedure TfrmManutencaoOrigemProdAcabados.edtCodProdutoComposicaoOrigemExit(
  Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtCodProdutoComposicaoOrigem.Text) Then
  Begin
    edtNomeProdutoComposicaoOrigem.Text:= '';
  End;

end;

procedure TfrmManutencaoOrigemProdAcabados.edtCodProdutoGranelNovoExit(
  Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtNomeProdutoGranelNovo.Text) Then
  Begin
    edtNomeProdutoGranelNovo.Text:= '';
  End;

end;

procedure TfrmManutencaoOrigemProdAcabados.edtCodProdutoGranelNovoKeyPress(
  Sender: TObject; var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    Try
      if fPesqItem(conIteSimples, Self, edtCodProdutoGranelNovo, edtNomeProdutoGranelNovo, qryConIte, Key, arrSel, True, nil, 'Consulta de Itens', '1',
                  '',0,False,False,0,cdrCodIte,'',False,'','',True,False,False,'',False,False,False,True) then
      Begin
        pCarregaProdutoGranelNovo(qryConIte);
        SelectNext(ActiveControl, True, True);
      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[frmManutencaoOrigemProdAcabados.edtCodProdutoGranelNovoKeyPress]');
      End;
    End;

  End;
end;

procedure TfrmManutencaoOrigemProdAcabados.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(qryConIte);
  FreeAndNil(qryConCor);

end;

procedure TfrmManutencaoOrigemProdAcabados.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F10:btnConfirma.Click;
  End;

end;

procedure TfrmManutencaoOrigemProdAcabados.FormShow(Sender: TObject);
begin
  inherited;
  qryConIte := fCriarQuery('SELECT * FROM CADITE WHERE FALSE', Self);
  qryConCor := fCriarQuery('SELECT * FROM CADCOR WHERE FALSE', Self);

  pSetFocus(edtCodProdutoAcabado);

end;

function TfrmManutencaoOrigemProdAcabados.fTipoProduto(sTipo, sCodProduto: String): String;
  var qryConsultaTemp: TUniQuery;
begin
  //G=Granel, E=Embalagem, A=Acabado
  result:= '';
  qryConsultaTemp:= fCriaQuery(Self);
  Try
    qryConsultaTemp.Close;
    qryConsultaTemp.SQL.Clear;
    qryConsultaTemp.SQL.Add('SELECT        '+
                            '  DEP_PROEMB, '+
                            '  DEP_PROGRA, '+
                            '  DEP_PROACA  '+
                            'FROM          '+
                            '  CADITE      '+
                            '  INNER JOIN CADDEP ON DEP_CODIGO = ITE_CODDEP '+
                            'WHERE CADITE.ITE_CODITE = :CODITE ');
    qryConsultaTemp.ParamByName('CODITE').AsString:= sCodProduto;
    qryConsultaTemp.Open;

    If sTipo = 'G' then
    Begin
      result:= qryConsultaTemp.FieldByName('DEP_PROGRA').AsString;
    End
    Else
    If sTipo = 'E' then
    Begin
      result:= qryConsultaTemp.FieldByName('DEP_PROEMB').AsString;
    End
    Else
    If sTipo = 'A' then
    Begin
      result:= qryConsultaTemp.FieldByName('DEP_PROACA').AsString;
    End;

  Finally
    FreeAndNil(qryConsultaTemp);
  End;
end;

function TfrmManutencaoOrigemProdAcabados.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
  var
    qryGenTemp: TUniQuery;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin

    If (Sender = edtCodProdutoAcabado) Then
    Begin

      If fEmptyStr(edtCodProdutoAcabado.Text) Then
      Begin
        fMensagem('ATENÇÃO','Digite o Código do Produto Acabado!',['&O K']);
        edtNomeProdutoGranelNovo.Text:= '';
        pSetFocus(edtCodProdutoAcabado);
        Result := False;
      End
      Else
      Begin
        {Checa se é um produto acabado}
        If fTipoProduto('A', edtCodProdutoAcabado.Text) <> 'S' then
        Begin
          fMensagem('', 'O Código informado não pertence a um produto acabado!', ['&Ok']);
          pSetFocus(edtCodProdutoAcabado);
          Exit;
        End;

        pCarregaProdutoAcabado(qryConIte);
      End;
    End

    Else

    If (Sender = edtCodProdutoGranelNovo) Then
    Begin
      If fEmptyStr(edtCodProdutoGranelNovo.Text) Then
      Begin
        fMensagem('ATENÇÃO','Digite o Código do Produto a Granel para Substituição!',['&O K']);
        edtNomeProdutoGranelNovo.Text:= '';
        pSetFocus(edtCodProdutoGranelNovo);
        Result := False;
      End
      Else
      Begin
        {Checa se é um produto a granel}
        If fTipoProduto('G', edtCodProdutoGranelNovo.Text) <> 'S' then
        Begin
          fMensagem('', 'O Item informado não corresponde a um produto a granel!', ['&Ok']);
          pSetFocus(edtCodProdutoGranelNovo);
          Exit;
        End;
        pCarregaProdutoGranelNovo(qryConIte);
      End;
    End

    Else

    If (Sender = edtCodCorGranelNovo) Then
    Begin
      If fEmptyStr(edtCodCorGranelNovo.Text) Then
      Begin
        fMensagem('ATENÇÃO','Digite o Código da Cor para Substituição!',['&O K']);
        edtNomeCorGranelNovo.Text:= '';
        pSetFocus(edtCodCorGranelNovo);
        Result := False;
      End
      Else
      Begin
        pCarregaCorNovo(qryConCor);

        sCodUniMedia:= '';
        qryGenTemp:= fCriaQuery(Self);
        Try
          qryGenTemp.Close;
          qryGenTemp.SQL.Clear;
          qryGenTemp.SQL.Add('SELECT        '+
                             '  GMT_CODITE, '+
                             '  GMT_CODCOR, '+
                             '  ITE_CODUNI  '+
                             'FROM          '+
                             '  GEIMAT      '+
                             '  INNER JOIN CADITE ON GMT_CODITE = ITE_CODITE '+
                             'WHERE GMT_CODITE = :GMT_CODITE '+
                             '  AND GMT_CODCOR = :GMT_CODCOR ');

          qryGenTemp.ParamByName('GMT_CODITE').AsString:= edtCodProdutoGranelNovo.Text;
          qryGenTemp.ParamByName('GMT_CODCOR').AsString:= edtCodCorGranelNovo.Text;
          qryGenTemp.Open;

          If ((qryGenTemp.FieldByName('GMT_CODITE').AsString = '') or
            (qryGenTemp.FieldByName('GMT_CODITE').IsNull)) Then
          Begin
            fMensagem('', 'Não existe uma fórmula cadastrada para a combinação abaixo '+#13+
                          'Produto a granel: '+edtCodProdutoGranelNovo.Text+ #13+
                          'Cor: '+edtCodCorGranelNovo.Text, ['&Ok']);
            bSalvar:= False;
            pSetFocus(edtCodProdutoGranelNovo);
            Result := False;
            Exit;
          End;

          sCodUniMedia:= qryGenTemp.FieldByName('ITE_CODUNI').AsString;
        Finally
          FreeAndNil(qryGenTemp);
        End;

      End;
    End

    Else

    If (Sender = edtCodProdutoComposicaoNovo) Then
    Begin
      If Not(fEmptyStr(edtCodProdutoComposicaoNovo.Text)) Then
      Begin
        pCarregaComposicao;

        qryGenTemp:= fCriaQuery(Self);
        Try
          qryGenTemp.Close;
          qryGenTemp.SQL.Clear;
          qryGenTemp.SQL.Add('SELECT    '+
                             '  *       '+
                             'FROM      '+
                             '  GERCOM  '+
                             'WHERE GCO_CODCOM = :GCO_CODCOM');

          qryGenTemp.ParamByName('GCO_CODCOM').AsString:= edtCodProdutoComposicaoNovo.Text;
          qryGenTemp.Open;

          If ((qryGenTemp.FieldByName('GCO_CODCOM').AsString = '') or
            (qryGenTemp.FieldByName('GCO_CODCOM').IsNull)) Then
          Begin
            fMensagem('ATENÇÃO','Código da Composição não encontrado!',['&O K']);
            bSalvar:= False;
            pSetFocus(edtCodProdutoComposicaoNovo);
            Result := False;
            Exit;
          End;
        Finally
          FreeAndNil(qryGenTemp);
        End;
      End;
    End;

  End;
  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmManutencaoOrigemProdAcabados.pCarregaComposicao;
Var
  qryConsultaComp: TUniQuery;
begin

  qryConsultaComp:= fCriaQuery(Self);
  Try
    qryConsultaComp.Close;
    qryConsultaComp.SQL.Clear;
    qryConsultaComp.SQL.Add('SELECT       '+
                            '  GCO_DESCOM '+
                            'FROM         '+
                            '  GERCOM     '+
                            'WHERE GCO_CODCOM = :GCO_CODCOM ');
    qryConsultaComp.ParamByName('GCO_CODCOM').AsString:= edtCodProdutoComposicaoNovo.Text;
    qryConsultaComp.Open;

    edtNomeProdutoComposicaoNovo.Text := qryConsultaComp.FieldByName('GCO_DESCOM').AsString;

  Finally
    FreeAndNil(qryConsultaComp);
  End;


end;

procedure TfrmManutencaoOrigemProdAcabados.pCarregaCorNovo(
  qryConsulta: TUniQuery);
Var
  qryConsultaCor: TUniQuery;
begin

  pPesquisaCadCor(qryConsulta, qryConsulta, edtCodCorGranelNovo.Text);
  qryConsultaCor:= fCriaQuery(Self);
  Try
    qryConsultaCor.Close;
    qryConsultaCor.SQL.Clear;
    qryConsultaCor.SQL.Add('SELECT   '+
                           '  *      '+
                           'FROM     '+
                           '  CADCOR '+
                           'WHERE COR_CODCOR = :COR_CODCOR ');
    qryConsultaCor.ParamByName('COR_CODCOR').AsString:= edtCodCorGranelNovo.Text;
    qryConsultaCor.Open;

    edtNomeCorGranelNovo.Text := qryConsultaCor.FieldByName('COR_DESCOR').AsString;

  Finally
    FreeAndNil(qryConsultaCor);
  End;


end;

procedure TfrmManutencaoOrigemProdAcabados.pCarregaProdutoAcabado(
  qryConsulta: TUniQuery);
  Var
   qryConsultaProdA: TUniQuery;
begin
  pPesquisaCadIte(qryConsulta, qryConsulta, edtCodProdutoAcabado.Text, '', False,  False, True, True, True, False);

  With qryConsulta Do
  Begin
   If fTipoProduto('A', edtCodProdutoAcabado.Text) <> 'S' then
   Begin
      fMensagem('', 'O Código informado não pertence a um produto acabado!', ['&Ok']);
      pSetFocus(edtCodProdutoAcabado);
      Exit;
    End;

    qryConsultaProdA:= fCriaQuery(Self);
    Try

      qryConsultaProdA.Close;
      qryConsultaProdA.SQL.Clear;
      qryConsultaProdA.SQL.Add('SELECT        '+
                               '  ORD_CODITE, '+
                               '  ORD_QTDPRO, '+
                               '  ORD_QTDENV  '+
                               'FROM          '+
                               '  ORDDET      '+
                               'WHERE ORD_CODITE = :ORD_CODITE ');

      qryConsultaProdA.ParamByName('ORD_CODITE').AsString:= edtCodProdutoAcabado.Text;
      qryConsultaProdA.Open;

      If ((qryConsultaProdA.FieldByName('ORD_QTDPRO').AsString <> '') or
        (Not(qryConsultaProdA.FieldByName('ORD_QTDPRO').IsNull))) Then
      Begin
        fMensagem('', 'Manutenção de produtos não permitida, pois o mesmo já se encontra em uma ordem de produção!', ['&Ok']);
        bSalvar:= False;
        pSetFocus(edtCodProdutoAcabado);
        Exit;
      End;



      qryConsultaProdA.Close;
      qryConsultaProdA.SQL.Clear;
      qryConsultaProdA.SQL.Add('SELECT               '+
                               '  CADITE.ITE_REFERE, '+
                               '  CADITE.ITE_CODITE, '+
                               '  CADITE.ITE_CODPAG, '+
                               '  CADITE.ITE_CODCOR, '+
                               '  CADUNI.UNI_DESUNI, '+
                               '  CADUNI.UNI_SIGUNI, '+
                               '  CADITE.ITE_CODCOM, '+
                               '  CADITE.ITE_CODITE, '+
                               '  CADITE.ITE_DESITE, '+
                               '  GERCOM.*           '+
                               'FROM                 '+
                               '  CADITE             '+
                               '  LEFT  JOIN GERCOM        ON ITE_CODCOM        = GCO_CODCOM        '+
                               '  INNER JOIN CADITE GRANEL ON CADITE.ITE_CODPAG = GRANEL.ITE_CODITE '+
                               '  INNER JOIN CADCOR        ON CADITE.ITE_CODCOR = CADCOR.COR_CODCOR '+
                               '  INNER JOIN CADUNI        ON CADUNI.UNI_CODUNI = CADITE.ITE_CODUNI '+
                               'WHERE CADITE.ITE_CODITE = :CODITE ');
      qryConsultaProdA.ParamByName('CODITE').AsString := edtCodProdutoAcabado.Text;
      qryConsultaProdA.Open;

      edtNomeProdutoAcabado.Text := qryConsultaProdA.FieldByName('ITE_DESITE').AsString;
      edtReferenciaAcabado.Text  := qryConsultaProdA.FieldByName('ITE_REFERE').AsString;
      edtUniMedidaAcabado.Text   := qryConsultaProdA.FieldByName('UNI_SIGUNI').AsString;


      If fEmptyStr(qryConsultaProdA.FieldByName('ITE_CODCOR').AsString) then
      Begin
        fMensagem('', 'O Produto informado não possui cor vinculada!', ['&Ok']);
        pSetFocus(edtCodProdutoAcabado);
        Exit;
      End;

      If fEmptyStr(qryConsultaProdA.FieldByName('ITE_CODPAG').AsString) then
      Begin
        fMensagem('', 'O Produto informado não possui um produto a granel vinculado!', ['&Ok']);
        pSetFocus(edtCodProdutoAcabado);
        Exit;
      End;

      If (qryConsultaProdA.FieldByName('ITE_CODITE').AsString = qryConsultaProdA.FieldByName('ITE_CODPAG').AsString) then
      Begin
        fMensagem('', 'O Produto informado está configurado como um produto intermediário, '+
                      'portanto, não pode ser substituído !', ['&Ok']);
        pSetFocus(edtCodProdutoAcabado);
        Exit;
      End;

      pCarregaProdutoGranel(qryConsultaProdA.FieldByName('ITE_CODITE').AsString);
      pCarregaProdutoCompos(qryConsultaProdA.FieldByName('ITE_CODITE').AsString, qryConsultaProdA.FieldByName('ITE_CODCOM').AsString);

      edtCodProdutoComposicaoOrigem.Text := qryConsultaProdA.FieldByName('GCO_CODCOM').AsString;
      edtNomeProdutoComposicaoOrigem.Text:= qryConsultaProdA.FieldByName('GCO_DESCOM').AsString;

      If(Not(bSalvar)) then
      Begin
        edtCodProdutoComposicaoNovo.Text   := qryConsultaProdA.FieldByName('GCO_CODCOM').AsString;
        edtNomeProdutoComposicaoNovo.Text  := qryConsultaProdA.FieldByName('GCO_DESCOM').AsString;
      End;

    Finally
      FreeAndNil(qryConsultaProdA);
    End;
  End;

end;

procedure TfrmManutencaoOrigemProdAcabados.pCarregaProdutoCompos(sProduto,
  sComposicao: String);
  Var
   qryConsultaMem: TUniQuery;
begin
  qryConsultaMem:= fCriaQuery(Self);
  Try
    qryConsultaMem.SQL.Clear;
    qryConsultaMem.SQL.Add('SELECT               '+
                           '  CADITE.ITE_CODITE, '+
                           '  CADITE.ITE_DESITE, '+
                           '  GERCOM.*           '+
                           'FROM                 '+
                           '  CADITE             '+
                           '  LEFT  JOIN  GERCOM        ON ITE_CODCOM        = GCO_CODCOM        '+
                           '  INNER JOIN CADITE GRANEL  ON CADITE.ITE_CODPAG = GRANEL.ITE_CODITE '+
                           '  INNER JOIN CADCOR         ON GRANEL.ITE_CODCOR = CADCOR.COR_CODCOR '+
                           '  WHERE CADITE.ITE_CODITE = :CODITE '+
                           '    AND CADITE.ITE_CODCOM = :CODCOM ');

    qryConsultaMem.ParamByName('CODITE').AsString := sProduto;
    qryConsultaMem.ParamByName('CODCOM').AsString := sComposicao;

    qryConsultaMem.Open;

    edtCodProdutoComposicaoOrigem.Text := qryConsultaMem.FieldByName('GCO_CODCOM').AsString;
    edtNomeProdutoComposicaoOrigem.Text:= qryConsultaMem.FieldByName('GCO_DESCOM').AsString;
    If(Not(bSalvar)) then
    Begin
      edtCodProdutoComposicaoNovo.Text := qryConsultaMem.FieldByName('GCO_CODCOM').AsString;
      edtNomeProdutoComposicaoNovo.Text:= qryConsultaMem.FieldByName('GCO_DESCOM').AsString;
    End;
  Finally
    FreeAndNil(qryConsultaMem);
  End;
end;


procedure TfrmManutencaoOrigemProdAcabados.pCarregaProdutoGranel(
  iCodProduto: String);
  Var
    qryConsultaMemGra: TUniQuery;
begin
  qryConsultaMemGra:= fCriaQuery(Self);
  Try
    qryConsultaMemGra.Close;
    qryConsultaMemGra.SQL.Clear;
    qryConsultaMemGra.SQL.Add('SELECT               '+
                              '  GRANEL.ITE_REFERE AS REFERENCIA_GRANEL, '+
                              '  CADITE.ITE_CODCOM, '+
                              '  CADITE.ITE_CODPAG, '+
                              '  CADCOR.COR_CODCOR, '+
                              '  CADCOR.COR_DESCOR, '+
                              '  UNI_DESUNI,        '+
                              '  UNI_SIGUNI AS SIGLA_UNI_GRANEL, '+
                              '  GRANEL.ITE_DESITE AS ITE_PRODUTO_GRANEL, '+
                              '  GRANEL.ITE_CODITE AS ITE_CODPRODGRANEL, '+
                              '  CADITE.ITE_DESITE, '+
                              '  CADITE.ITE_CODITE, '+
                              '  CADITE.ITE_CODPAG, '+
                              '  CADITE.ITE_CODCOR, '+
                              '  CADITE.ITE_CODCOM, '+
                              '  GERCOM.*           '+
                              'FROM                 '+
                              '  CADITE             '+
                              '  INNER JOIN CADITE GRANEL ON CADITE.ITE_CODPAG = GRANEL.ITE_CODITE '+
                              '  LEFT  JOIN GERCOM        ON CADITE.ITE_CODCOM = GCO_CODCOM        '+
                              '  INNER JOIN CADCOR        ON GRANEL.ITE_CODCOR = CADCOR.COR_CODCOR '+
                              '  INNER JOIN CADUNI        ON CADUNI.UNI_CODUNI = GRANEL.ITE_CODUNI '+
                              'WHERE CADITE.ITE_CODITE = :CODITE ');

    qryConsultaMemGra.ParamByName('CODITE').AsString := edtCodProdutoAcabado.Text;
    qryConsultaMemGra.Open;

    edtNomeProdutoGranelOrigem.Text:= qryConsultaMemGra.FieldByName('ITE_PRODUTO_GRANEL').AsString;
    edtCodProdutoGranelOrigem.Text := qryConsultaMemGra.FieldByName('ITE_CODPRODGRANEL').AsString;
    edtCodCorGranelOrigem.Text     := qryConsultaMemGra.FieldByName('ITE_CODCOR').AsString;
    edtNomeCorGranelOrigem.Text    := qryConsultaMemGra.FieldByName('COR_DESCOR').AsString;
    edtReferenciaGranelOrigem.Text := qryConsultaMemGra.FieldByName('REFERENCIA_GRANEL').AsString;
    edtUniMedidaGranelOrigem.Text  := qryConsultaMemGra.FieldByName('SIGLA_UNI_GRANEL').AsString;

    If(Not(bSalvar)) then
    Begin
      edtNomeProdutoGranelNovo.Text  := qryConsultaMemGra.FieldByName('ITE_PRODUTO_GRANEL').AsString;
      edtCodProdutoGranelNovo.Text   := qryConsultaMemGra.FieldByName('ITE_CODPRODGRANEL').AsString;
    End;

    If(Not(bSalvar)) then
    Begin
      edtCodCorGranelNovo.Text       := qryConsultaMemGra.FieldByName('COR_CODCOR').AsString;
      edtNomeCorGranelNovo.Text      := qryConsultaMemGra.FieldByName('COR_DESCOR').AsString
    End;


  Finally
    FreeAndNil(qryConsultaMemGra);
  End;
end;

procedure TfrmManutencaoOrigemProdAcabados.pCarregaProdutoGranelNovo(
  qryConsulta: TUniQuery);
var
  qryConsultaProd: TUniQuery;
begin
  pPesquisaCadIte(qryConsulta, qryConsulta, edtCodProdutoGranelNovo.Text, '', False, False, True, True, False, False, True, False);
  With qryConsulta Do
  Begin
    If fTipoProduto('G', edtCodProdutoGranelNovo.Text) <> 'S' then
    Begin
      fMensagem('', 'O Item informado não corresponde a um produto a granel!', ['&Ok']);
      pSetFocus(edtCodProdutoGranelNovo);
      Exit;
    End;

    qryConsultaProd:= fCriaQuery(Self);
    Try
      qryConsultaProd.Close;
      qryConsultaProd.SQL.Clear;
      qryConsultaProd.SQL.Add('SELECT       '+
                              '  ITE_DESITE '+
                              'FROM         '+
                              '  CADITE     '+
                              'WHERE ITE_CODITE = :ITE_CODITE ');
      qryConsultaProd.ParamByName('ITE_CODITE').AsString:= edtCodProdutoGranelNovo.Text;
      qryConsultaProd.Open;

      edtNomeProdutoGranelNovo.Text:= qryConsultaProd.FieldByName('ITE_DESITE').AsString;
    Finally
      FreeAndNil(qryConsultaProd);
    End;
  End;
end;


procedure TfrmManutencaoOrigemProdAcabados.pLimpaCampos;
begin
  sCodUniMedia                       := '';
  edtNomeProdutoAcabado.Text         := '';
  edtCodProdutoGranelOrigem.Text     := '';
  edtNomeProdutoGranelOrigem.Text    := '';
  edtCodCorGranelOrigem.Text         := '';
  edtNomeCorGranelOrigem.Text        := '';
  edtCodProdutoGranelNovo.Text       := '';
  edtNomeProdutoGranelNovo.Text      := '';
  edtCodCorGranelNovo.Text           := '';
  edtNomeCorGranelNovo.Text          := '';
  edtCodProdutoComposicaoOrigem.Text := '';
  edtNomeProdutoComposicaoOrigem.Text:= '';
  edtCodProdutoComposicaoNovo.Text   := '';
  edtNomeProdutoComposicaoNovo.Text  := '';
end;

procedure TfrmManutencaoOrigemProdAcabados.pLog(sData, sHora, sUsuario,
  sCodProdAcabado, sCodProdAtual, sCodProdNovo, sCodCorAtual,
  sCodCorNovo, sCodComAtual, sCodComNovo: String);
  var
    qryInsUpdate: TUniQuery;
begin
  qryInsUpdate:= fCriaQuery(Self);
  Try
    qryInsUpdate.Close;
    qryInsUpdate.SQL.Clear;
    qryInsUpdate.SQL.Add('INSERT INTO           '+
                         '  LOGMPA(             '+
                         '          AUTOINCREM, '+
                         '          LGM_DATAIC, '+
                         '          LGM_HORAIC, '+
                         '          LGM_CODOPE, '+
                         '          LGM_ITEACB, '+
                         '          LGM_ITEORA, '+
                         '          LGM_ITEORN, '+
                         '          LGM_CORATU, '+
                         '          LGM_CORNOV, '+
                         '          LGM_COMATU, '+
                         '          LGM_COMNOV) '+
                         'VALUES(               '+
                         '          :AUTINC,    '+
                         '          :LGM_DATAIC,'+
                         '          :LGM_HORAIC,'+
                         '          :LGM_CODOPE,'+
                         '          :LGM_ITEACB,'+
                         '          :LGM_ITEORA,'+
                         '          :LGM_ITEORN,'+
                         '          :LGM_CORATU,'+
                         '          :LGM_CORNOV,'+
                         '          :LGM_COMATU,'+
                         '          :LGM_COMNOV)');

    qryInsUpdate.ParamByName('AUTINC').AsString    := fRetAutoIncrem('LOGMPA', VS_strCodEmp);
    qryInsUpdate.ParamByName('LGM_DATAIC').AsDate  :=StrToDate(sData);
    qryInsUpdate.ParamByName('LGM_HORAIC').AsString:= sHora;
    qryInsUpdate.ParamByName('LGM_CODOPE').AsString:= sUsuario;
    qryInsUpdate.ParamByName('LGM_ITEACB').AsString:= sCodProdAcabado;

    If sCodProdAtual <> '' Then
      qryInsUpdate.ParamByName('LGM_ITEORA').AsString:= sCodProdAtual;

    If sCodProdNovo <> '' Then
      qryInsUpdate.ParamByName('LGM_ITEORN').AsString:= sCodProdNovo;

    If sCodCorNovo <> '' Then
      qryInsUpdate.ParamByName('LGM_CORNOV').AsString:= sCodCorNovo;

    If sCodCorAtual <> '' Then
      qryInsUpdate.ParamByName('LGM_CORATU').AsString:= sCodCorAtual;

    If sCodComAtual <> '' Then
      qryInsUpdate.ParamByName('LGM_COMATU').AsString:= sCodComAtual;

    If sCodComNovo <> '' Then
      qryInsUpdate.ParamByName('LGM_COMNOV').AsString:= sCodComNovo;

    qryInsUpdate.ExecSQL;
  Finally
    FreeAndNil(qryInsUpdate);
  End;


end;

end.
