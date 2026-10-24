unit untEqualsDigPeriodo;

interface

uses
  System.SysUtils, System.Types, System.Classes, System.Variants,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Mask,
  Vcl.AppEvnts, System.StrUtils,

  Uni, EditFocus, MaskEditFocus, frxClass, frxExportCSVTestabilidade, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  dxCore, cxDateUtils, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar,
  BitBtnLockedIncrem, cxCheckBox,

  untLibCartoesPaiSimples,  untTLockLibCartoes, untLibCartoesInterfacesTipos,
  untILibCartoesFactory;

type
  TfrmEqualsDigPeriodo = class(TfrmPaiSimples)
    pnlConfirma: TPanel;
    btnConfirmaDados: TBitBtnLocked;
    btnCancelaDados: TBitBtnLocked;
    pnlFundoConcil: TPanel;
    lblDataFinal: TLabel;
    lblDataInicial: TLabel;
    lblEmpresa: TLabel;
    lblPontoDeVenda: TLabel;
    mskDtaFinConcil: TcxDateEdit;
    mskDtaIniConcil: TcxDateEdit;
    edtCodEmp: TEditFocus;
    edtDesEmp: TEditFocus;
    edtPonVen: TEditFocus;
    edtDesPon: TEditFocus;
    lblPeriodoConciliacao: TLabel;
    procedure btnCancelaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtPonVenKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FTravaPorEstabelecimento: Boolean;
    FobjLockEstabelecimento: TLock;

    strPesquisaEmpresa: String;
    function ExibeFiltroPorEmpresa:Boolean;
    function RetornaSQLEmpresas:String;
    function RetornaSQLSelecionaEmpresas:String;
    function TravarPorEstabelecimento(AEstabelecimento:String):Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    blnConfirma: Boolean;
    objConcil  : TCamposConcil;
    arrPonVen  : TConsultasArray;
    arrEmpresa : TConsultasArray;
    strEmpresas: String;
    strPonVen  : String;
    property objLockEstabelecimento : TLock read FobjLockEstabelecimento Write FobjLockEstabelecimento;
  end;


implementation

uses  untTEqualsFuncoes;

{$R *.dfm}

procedure TfrmEqualsDigPeriodo.btnCancelaClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

function TfrmEqualsDigPeriodo.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    LContador: Integer;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = mskDtaIniConcil) Then
    Begin

      If (TEqualsFuncoes.fEmptyStr(TEqualsFuncoes.fTiraCaracEspeciais(mskDtaIniConcil.Text))) Then
      Begin
        TEqualsFuncoes.fMensagem('ATENÇÃO!', 'A Data inicial deve ser preenchida!', ['&O k']);
        Result := False;
      End;

    End
    Else If (Sender = mskDtaFinConcil) Then
    Begin

      If TEqualsFuncoes.fEmptyStr(TEqualsFuncoes.fTiraCaracEspeciais(mskDtaFinConcil.Text)) Then
      Begin
        TEqualsFuncoes.fMensagem('ATENÇÃO!', 'A Data final deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else If (Not TEqualsFuncoes.fEmptyStr(TEqualsFuncoes.fTiraCaracEspeciais(mskDtaFinConcil.Text))) And
              (    TEqualsFuncoes.fEmptyStr(TEqualsFuncoes.fTiraCaracEspeciais(mskDtaIniConcil.Text))) Then
      Begin
        TEqualsFuncoes.fMensagem('ATENÇÃO!', 'Caso informe um período digite primeiramente a data inicial!', ['&O k']);
        Result := False;
      End
      Else If (Not TEqualsFuncoes.fEmptyStr(TEqualsFuncoes.fTiraCaracEspeciais(mskDtaFinConcil.Text))) And
              (Not TEqualsFuncoes.fEmptyStr(TEqualsFuncoes.fTiraCaracEspeciais(mskDtaIniConcil.Text))) Then
      Begin
        If (Not TEqualsFuncoes.fValidaPeriodo(mskDtaIniConcil.Text, mskDtaFinConcil.Text)) Then
        Begin
          TEqualsFuncoes.fMensagem('ATENÇÃO!', 'A data final deve ser maior ou igual a data inicial!', ['&O k']);
          Result := False;
        End;
      End;

    End

    Else If (Sender = edtCodEmp) And (Not TEqualsFuncoes.fEmptyStr(objConcil.CfgEstabelecimentos)) Then
    Begin

      If Not TEqualsFuncoes.fEmptyStr(edtCodEmp.Text) Then
      Begin
        If Not SameText(edtCodEmp.Text, '000') Then
        Begin
          TLibCartoesFactory.Get.pIPesquisaCadEmp(Nil, qryTabela, edtCodEmp.Text);
          edtDesEmp.Text := qryTabela.FieldByName('EMP_NOMEMP').AsString;

          If Pos(edtCodEmp.Text, strEmpresas) <= 0 Then
          Begin
            TEqualsFuncoes.fMensagem('', 'Empresa sem ponto de venda vinculada!', ['&Ok']);

            Result := False;
          End;

          SetLength(arrEmpresa, 0);

          If Result Then
          Begin
            SetLength(arrEmpresa, 1);
            arrEmpresa[0].strCodigo := edtCodEmp.Text;
          End
        End;
      End
      Else If TEqualsFuncoes.fEmptyStr(edtCodEmp.Text) Then
        edtDesEmp.Text := 'TODAS';

    End

    Else If (Sender = edtPonVen) And (Not TEqualsFuncoes.fEmptyStr(objConcil.CfgEstabelecimentos)) Then
    Begin

      If ((Not TEqualsFuncoes.fEmptyStr(edtPonVen.Text)) And (High(arrPonVen) < 0)) Then
      Begin
        edtDesPon.Text := edtPonVen.Text;

        If Pos(edtPonVen.Text, strPonVen) <= 0 Then
        Begin
          TEqualsFuncoes.fMensagem('', 'Esse Ponto de Venda não foi importado pela ' + objConcil.NomeConciliacao + '!', ['&Ok']);
          Result := False;
        End;

        If Result Then
        Begin
          SetLength(arrPonVen, 1);
          arrPonVen[0].strCodigo := edtPonVen.Text;
        End;
      End
      Else If TEqualsFuncoes.fEmptyStr(edtPonVen.Text) Then
        edtDesPon.Text := 'TODOS';

      If Result Then
      Begin
        FobjLockEstabelecimento.pDestravarTodos;

        If  ((Not TEqualsFuncoes.fEmptyStr(edtPonVen.Text)) And (High(arrPonVen) >= 0)) Then
        Begin
          For LContador := 0 To High(arrPonVen) Do
          Begin
            Result := TravarPorEstabelecimento(arrPonVen[LContador].strCodigo);

            If Not Result Then
              Exit;
          End;
        End
        Else
          Result := TravarPorEstabelecimento(edtPonVen.Text);
      End;

    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

function TfrmEqualsDigPeriodo.RetornaSQLEmpresas: String;
begin
  Result := 'EMP_CODEMP IN (SELECT DISTINCT SIS_CODEMP FROM CFGSIS WHERE SIS_CODCFG ';
  Result := Result + ' IN ("CFG_EQUEST") ';
  Result := Result + ' AND SIS_VALCFG <> "" AND SIS_VALCFG IS NOT NULL )';
end;

function TfrmEqualsDigPeriodo.RetornaSQLSelecionaEmpresas: String;
begin
  Result := 'SELECT DISTINCT SIS_CODEMP FROM CFGSIS ';
  Result := Result + ' WHERE SIS_CODCFG IN ("CFG_EQUEST") AND ';
  Result := Result + ' SIS_VALCFG <> "" AND SIS_VALCFG IS NOT NULL ';
end;

function TfrmEqualsDigPeriodo.TravarPorEstabelecimento(AEstabelecimento:String): Boolean;
  Var
    LConciliadora: String;
    LChaveLckatc: String;
    LChaveCompleta: String;
begin
  Result := True;

  If Not FTravaPorEstabelecimento Then
    Exit;

  LConciliadora := StringReplace(objConcil.NomeConciliacao, ' ', '_', [rfReplaceAll]);

  If TEqualsFuncoes.fEmptyStr(AEstabelecimento) Then
  Begin

    LChaveLckatc := 'CONCILIACAO_BAIXA_CARTOES_' + LConciliadora + '_';
    If FobjLockEstabelecimento.fVerificaLCKATCNomeParcialRetornaChave(LChaveLckatc,LChaveCompleta) Then
    Begin
      TEqualsFuncoes.fMensagem('ATENÇÃO','Não será permitido selecionar todos os estabelecimentos da operadora '
                                                   + LConciliadora + ', pois alguns já estão sendo ' +
                                                   'conciliados/baixados por outra estação: ' +
                                                   TLibCartoesFactory.Get.fIGetHostLock(LChaveCompleta), ['&OK'], 1);
      Exit(False);
    End;

    LChaveLckatc := 'CONCILIACAO_BAIXA_CARTOES_' + LConciliadora + '_TODOS';
    If Not FobjLockEstabelecimento.fLock_Unlock(LChaveLckatc, True, False) Then
    Begin
      TEqualsFuncoes.fMensagem('ATENÇÃO', 'Todos os estabelecimentos da operadora ' + LConciliadora + ' já estão sendo ' +
                                                   'conciliados/baixados por outra estação: ' +
                                                   TLibCartoesFactory.Get.fIGetHostLock(LChaveLckatc), ['&OK'], 1);
      Exit(False);
    End;


    Exit;
  End;

  LChaveLckatc := 'CONCILIACAO_BAIXA_CARTOES_' + LConciliadora + '_TODOS';
  If FobjLockEstabelecimento.fVerificaLCKATCNomeParcial(LChaveLckatc) Then
  Begin
    TEqualsFuncoes.fMensagem('ATENÇÃO', 'Todos os estabelecimentos da operadora ' + LConciliadora + ' já estão sendo ' +
                                                 'conciliados/baixados por outra estação: ' +
                                                 TLibCartoesFactory.Get.fIGetHostLock(LChaveLckatc), ['&OK'], 1);
    Exit(False);
  End;

  LChaveLckatc := 'CONCILIACAO_BAIXA_CARTOES_' + LConciliadora + '_' + AEstabelecimento;
  If Not FobjLockEstabelecimento.fLock_Unlock(LChaveLckatc, True, False) Then
  Begin
    TEqualsFuncoes.fMensagem('ATENÇÃO', 'O estabelecimento '+AEstabelecimento+' da operadora ' + LConciliadora + ' já está sendo ' +
                                                 'conciliado/baixado por outra estação: ' +
                                                 TLibCartoesFactory.Get.fIGetHostLock(LChaveLckatc), ['&OK'], 1);
    Exit(False);
  End;

end;

procedure TfrmEqualsDigPeriodo.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  TEqualsFuncoes.FreeAndNilDatasets(qryTabela);
  inherited;
end;

procedure TfrmEqualsDigPeriodo.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirma := False;

  FobjLockEstabelecimento := TLock.Create;
end;

procedure TfrmEqualsDigPeriodo.FormDestroy(Sender: TObject);
begin
  If Assigned(FobjLockEstabelecimento) Then
    FreeAndNil(FobjLockEstabelecimento);
  inherited;
end;

procedure TfrmEqualsDigPeriodo.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;

  //FECHAMENTO FINANCEIRO
  if edtCodEmp.Visible then
  Begin
    if TLibCartoesFactory.Get.fIFechamentoFinanceiroJaRealizado(TEqualsFuncoes.IIF(not TEqualsFuncoes.fEmptyStr(edtCodEmp.Text), edtCodEmp.Text, TLibCartoesFactory.Get.fIRetEmpresaLogada),
                                                                StrToDate(mskDtaIniConcil.Text),
                                                                Self.Name) then
     Exit;
  End;

  If fVerificaCampos Then
  Begin
    blnConfirma := True;
    Self.Close;
  End;
end;

procedure TfrmEqualsDigPeriodo.edtCodEmpKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  {********************************************}
  {* CONSULTA DE EMPRESAS COM PONTO DE VENDAS *}
  {*****************************************AJ*}
  If TLibCartoesFactory.Get.fIPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtDesEmp, Nil, Key, arrEmpresa, False, False, '', False, '',
     strPesquisaEmpresa) Then
  Begin
    If fValidaCampos(edtCodEmp) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmEqualsDigPeriodo.edtPonVenKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  {*******************************}
  {* CONSULTA DE PONTOS DE VENDA *}
  {****************************AJ*}
  If VS_FuncoesExternas.fIPesqEstConcil(Self, edtPonVen, edtDesPon, Key, objConcil, arrPonVen) Then
  Begin
    If fValidaCampos(edtPonVen) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmEqualsDigPeriodo.ExibeFiltroPorEmpresa: Boolean;
begin
  Result := True;

  If TEqualsFuncoes.fEmptyStr(strEmpresas) Then
    Exit(False);
end;

procedure TfrmEqualsDigPeriodo.FormShow(Sender: TObject);
Var
  qryEmpPV: TUniQuery;
  strSQL  : String;
begin
  inherited;
  FTravaPorEstabelecimento :=  False;

  pnlFundoConcil.Visible := True;
  pSetFocus(mskDtaIniConcil);
  mskDtaIniConcil.Date := TLibCartoesFactory.Get.fIGetVS_Date;
  mskDtaFinConcil.Date := TLibCartoesFactory.Get.fIGetVS_Date;

  qryEmpPV := Nil;
  Try
    qryEmpPV := VS_FuncoesExternas.fICriaQuery;
    strSQL := 'SELECT CAR_CODEST FROM ' +
              ' ESTCAR WHERE CAR_NOMOPE="' + objConcil.NomeConciliacao + '"';

    qryEmpPV.SQL.Text := strSQL;
    qryEmpPV.Open;

    strPonVen := '';
    While Not qryEmpPV.Eof Do
    Begin
      strPonVen := strPonVen + qryEmpPV.FieldByName('CAR_CODEST').AsString + '_';
      qryEmpPV.Next;
    End;

    qryEmpPV.Close;
    qryEmpPV.SQL.Text := RetornaSQLSelecionaEmpresas;
    qryEmpPV.Open;

    strEmpresas := '';
    While Not qryEmpPV.Eof Do
    Begin
      strEmpresas := strEmpresas + qryEmpPV.FieldByName('SIS_CODEMP').AsString + '_';
      qryEmpPV.Next;
    End;
  Finally
    TEqualsFuncoes.FreeAndNilDatasets(qryEmpPV);
  End;

  lblPontoDeVenda.Visible := True;
  edtPonVen.Visible := True;
  edtDesPon.Visible := True;

  lblEmpresa.Visible := ExibeFiltroPorEmpresa;
  edtCodEmp.Visible := lblEmpresa.Visible;
  edtDesEmp.Visible := lblEmpresa.Visible;

  Self.Caption := Self.Caption + ' (' + objConcil.NomeConciliacao + ')';
  qryTabela := VS_FuncoesExternas.fICriaQuery;

  strPesquisaEmpresa := RetornaSQLEmpresas;
end;

End.

