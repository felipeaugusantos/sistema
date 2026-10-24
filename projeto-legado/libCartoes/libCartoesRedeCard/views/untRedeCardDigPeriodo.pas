unit untRedeCardDigPeriodo;

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
  TfrmRedeCardDigPeriodo = class(TfrmPaiSimples)
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
    FListaPV: TStringList;

    function NormalizaPV(const AValor: String): String;
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
    property objLockEstabelecimento : TLock read FobjLockEstabelecimento Write FobjLockEstabelecimento;
  end;


implementation

uses  untTRedeCardFuncoes;

{$R *.dfm}

procedure TfrmRedeCardDigPeriodo.btnCancelaClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

function TfrmRedeCardDigPeriodo.NormalizaPV(const AValor: String): String;
begin
  Result := Trim(AValor);

  While (Length(Result) > 1) And (Result[1] = '0') Do
    Delete(Result, 1, 1);

  Result := Result.PadLeft(9, '0');
end;

function TfrmRedeCardDigPeriodo.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    LContador: Integer;
    LChave   : String;
    LCodigos : TArray<String>;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = mskDtaIniConcil) Then
    Begin

      If (TRedeCardFuncoes.fEmptyStr(TRedeCardFuncoes.fTiraCaracEspeciais(mskDtaIniConcil.Text))) Then
      Begin
        TRedeCardFuncoes.fMensagem('ATENÇÃO!', 'A Data inicial deve ser preenchida!', ['&O k']);
        Result := False;
      End;

    End
    Else If (Sender = mskDtaFinConcil) Then
    Begin

      If TRedeCardFuncoes.fEmptyStr(TRedeCardFuncoes.fTiraCaracEspeciais(mskDtaFinConcil.Text)) Then
      Begin
        TRedeCardFuncoes.fMensagem('ATENÇÃO!', 'A Data final deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else If (Not TRedeCardFuncoes.fEmptyStr(TRedeCardFuncoes.fTiraCaracEspeciais(mskDtaFinConcil.Text))) And
              (    TRedeCardFuncoes.fEmptyStr(TRedeCardFuncoes.fTiraCaracEspeciais(mskDtaIniConcil.Text))) Then
      Begin
        TRedeCardFuncoes.fMensagem('ATENÇÃO!', 'Caso informe um período digite primeiramente a data inicial!', ['&O k']);
        Result := False;
      End
      Else If (Not TRedeCardFuncoes.fEmptyStr(TRedeCardFuncoes.fTiraCaracEspeciais(mskDtaFinConcil.Text))) And
              (Not TRedeCardFuncoes.fEmptyStr(TRedeCardFuncoes.fTiraCaracEspeciais(mskDtaIniConcil.Text))) Then
      Begin
        If (Not TRedeCardFuncoes.fValidaPeriodo(mskDtaIniConcil.Text, mskDtaFinConcil.Text)) Then
        Begin
          TRedeCardFuncoes.fMensagem('ATENÇÃO!', 'A data final deve ser maior ou igual a data inicial!', ['&O k']);
          Result := False;
        End;
      End;

    End

    Else If (Sender = edtCodEmp) And (Not TRedeCardFuncoes.fEmptyStr(objConcil.CfgEstabelecimentos)) Then
    Begin

      If Not TRedeCardFuncoes.fEmptyStr(edtCodEmp.Text) Then
      Begin
        If Not SameText(edtCodEmp.Text, '000') Then
        Begin
          TLibCartoesFactory.Get.pIPesquisaCadEmp(Nil, qryTabela, edtCodEmp.Text);
          edtDesEmp.Text := qryTabela.FieldByName('EMP_NOMEMP').AsString;

          If Pos(edtCodEmp.Text, strEmpresas) <= 0 Then
          Begin
            TRedeCardFuncoes.fMensagem('', 'Empresa sem ponto de venda vinculada!', ['&Ok']);

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
      Else If TRedeCardFuncoes.fEmptyStr(edtCodEmp.Text) Then
        edtDesEmp.Text := 'TODAS';

    End
    Else If (Sender = edtPonVen) And (Not TRedeCardFuncoes.fEmptyStr(objConcil.CfgEstabelecimentos)) Then
    Begin

      If ((Not TRedeCardFuncoes.fEmptyStr(edtPonVen.Text)) And (High(arrPonVen) < 0)) Then
      Begin
        LChave := NormalizaPV(edtPonVen.Text);

        If FListaPV.IndexOfName(LChave) < 0 Then
        Begin
          TRedeCardFuncoes.fMensagem('', 'Esse Ponto de Venda não foi importado pela ' + objConcil.NomeConciliacao + '!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          LCodigos := FListaPV.Values[LChave].Split([';']);
          SetLength(arrPonVen, Length(LCodigos));
          For LContador := 0 To High(LCodigos) Do
            arrPonVen[LContador].strCodigo := LCodigos[LContador];

          edtPonVen.Text := LChave;
        End;

        edtDesPon.Text := edtPonVen.Text;
      End
      Else If TRedeCardFuncoes.fEmptyStr(edtPonVen.Text) Then
        edtDesPon.Text := 'TODOS';

      If Result Then
      Begin
        FobjLockEstabelecimento.pDestravarTodos;

        If  ((Not TRedeCardFuncoes.fEmptyStr(edtPonVen.Text)) And (High(arrPonVen) >= 0)) Then
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

function TfrmRedeCardDigPeriodo.RetornaSQLEmpresas: String;
begin
  Result := 'EMP_CODEMP IN (SELECT DISTINCT SIS_CODEMP FROM CFGSIS WHERE SIS_CODCFG ';
  Result := Result + ' IN ("CFG_REDEST", "CFG_REDECO") ';
  Result := Result + ' AND SIS_VALCFG <> "" AND SIS_VALCFG IS NOT NULL )';
end;

function TfrmRedeCardDigPeriodo.RetornaSQLSelecionaEmpresas: String;
begin
  Result := 'SELECT DISTINCT SIS_CODEMP FROM CFGSIS ';
  Result := Result + ' WHERE SIS_CODCFG IN ("CFG_REDEST", "CFG_REDECO") AND ';
  Result := Result + ' SIS_VALCFG <> "" AND SIS_VALCFG IS NOT NULL ';
end;

function TfrmRedeCardDigPeriodo.TravarPorEstabelecimento(AEstabelecimento:String): Boolean;
  Var
    LConciliadora: String;
    LChaveLckatc: String;
    LChaveCompleta: String;
begin
  Result := True;

  If Not FTravaPorEstabelecimento Then
    Exit;

  LConciliadora := StringReplace(objConcil.NomeConciliacao, ' ', '_', [rfReplaceAll]);

  If TRedeCardFuncoes.fEmptyStr(AEstabelecimento) Then
  Begin

    LChaveLckatc := 'CONCILIACAO_BAIXA_CARTOES_' + LConciliadora + '_';
    If FobjLockEstabelecimento.fVerificaLCKATCNomeParcialRetornaChave(LChaveLckatc,LChaveCompleta) Then
    Begin
      TRedeCardFuncoes.fMensagem('ATENÇÃO','Não será permitido selecionar todos os estabelecimentos da operadora '
                                                   + LConciliadora + ', pois alguns já estão sendo ' +
                                                   'conciliados/baixados por outra estação: ' +
                                                   TLibCartoesFactory.Get.fIGetHostLock(LChaveCompleta), ['&OK'], 1);
      Exit(False);
    End;

    LChaveLckatc := 'CONCILIACAO_BAIXA_CARTOES_' + LConciliadora + '_TODOS';
    If Not FobjLockEstabelecimento.fLock_Unlock(LChaveLckatc, True, False) Then
    Begin
      TRedeCardFuncoes.fMensagem('ATENÇÃO', 'Todos os estabelecimentos da operadora ' + LConciliadora + ' já estão sendo ' +
                                                   'conciliados/baixados por outra estação: ' +
                                                   TLibCartoesFactory.Get.fIGetHostLock(LChaveLckatc), ['&OK'], 1);
      Exit(False);
    End;


    Exit;
  End;

  LChaveLckatc := 'CONCILIACAO_BAIXA_CARTOES_' + LConciliadora + '_TODOS';
  If FobjLockEstabelecimento.fVerificaLCKATCNomeParcial(LChaveLckatc) Then
  Begin
    TRedeCardFuncoes.fMensagem('ATENÇÃO', 'Todos os estabelecimentos da operadora ' + LConciliadora + ' já estão sendo ' +
                                                 'conciliados/baixados por outra estação: ' +
                                                 TLibCartoesFactory.Get.fIGetHostLock(LChaveLckatc), ['&OK'], 1);
    Exit(False);
  End;

  LChaveLckatc := 'CONCILIACAO_BAIXA_CARTOES_' + LConciliadora + '_' + AEstabelecimento;
  If Not FobjLockEstabelecimento.fLock_Unlock(LChaveLckatc, True, False) Then
  Begin
    TRedeCardFuncoes.fMensagem('ATENÇÃO', 'O estabelecimento '+AEstabelecimento+' da operadora ' + LConciliadora + ' já está sendo ' +
                                                 'conciliado/baixado por outra estação: ' +
                                                 TLibCartoesFactory.Get.fIGetHostLock(LChaveLckatc), ['&OK'], 1);
    Exit(False);
  End;

end;

procedure TfrmRedeCardDigPeriodo.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  TRedeCardFuncoes.FreeAndNilDatasets(qryTabela);

  inherited;
end;

procedure TfrmRedeCardDigPeriodo.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirma := False;

  FobjLockEstabelecimento := TLock.Create;
  FListaPV := TStringList.Create;
end;

procedure TfrmRedeCardDigPeriodo.FormDestroy(Sender: TObject);
begin
  If Assigned(FobjLockEstabelecimento) Then
    FreeAndNil(FobjLockEstabelecimento);

  If Assigned(FListaPV) Then
    FreeAndNil(FListaPV);

  inherited;
end;

procedure TfrmRedeCardDigPeriodo.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;

  //FECHAMENTO FINANCEIRO
  if edtCodEmp.Visible then
  Begin
    if TLibCartoesFactory.Get.fIFechamentoFinanceiroJaRealizado(TRedeCardFuncoes.IIF(not TRedeCardFuncoes.fEmptyStr(edtCodEmp.Text), edtCodEmp.Text, TLibCartoesFactory.Get.fIRetEmpresaLogada),
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

procedure TfrmRedeCardDigPeriodo.edtCodEmpKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmRedeCardDigPeriodo.edtPonVenKeyPress(Sender: TObject; var Key: Char);
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

function TfrmRedeCardDigPeriodo.ExibeFiltroPorEmpresa: Boolean;
begin
  Result := True;

  If TRedeCardFuncoes.fEmptyStr(strEmpresas) Then
    Exit(False);
end;

procedure TfrmRedeCardDigPeriodo.FormShow(Sender: TObject);
Var
  qryEmpPV: TUniQuery;
  strSQL  : String;
  LCod    : String;
  LChave  : String;
  LIdx    : Integer;
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
    //Selecionando pontos de venda
    strSQL := 'SELECT CAR_CODEST FROM ' +
              ' ESTCAR WHERE CAR_NOMOPE="' + objConcil.NomeConciliacao + '"';

    qryEmpPV.SQL.Text := strSQL;
    qryEmpPV.Open;

    FListaPV.Clear;

    While Not qryEmpPV.Eof Do
    Begin
      LCod   := Trim(qryEmpPV.FieldByName('CAR_CODEST').AsString);
      LChave := NormalizaPV(LCod);
      LIdx   := FListaPV.IndexOfName(LChave);

      If LIdx < 0 Then
        FListaPV.Values[LChave] := LCod
      Else If Not ((';' + FListaPV.ValueFromIndex[LIdx] + ';').Contains(';' + LCod + ';')) Then
        FListaPV.ValueFromIndex[LIdx] := FListaPV.ValueFromIndex[LIdx] + ';' + LCod;

      qryEmpPV.Next;
    End;

    //Selecionando empresas
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
    TRedeCardFuncoes.FreeAndNilDatasets(qryEmpPV);
  End;

  lblPontoDeVenda.Visible := True;
  edtPonVen.Visible := True;
  edtDesPon.Visible := True;

  lblEmpresa.Visible := ExibeFiltroPorEmpresa;
  edtCodEmp.Visible := lblEmpresa.Visible;
  edtDesEmp.Visible := lblEmpresa.Visible;

  Self.Caption := Self.Caption + ' (' + objConcil.NomeConciliacao + ')';
  If objConcil.NomeConciliacao.Contains(' API') Then
    Self.Caption := Self.Caption + ' (RedeCard Online)';
  qryTabela := VS_FuncoesExternas.fICriaQuery;

  strPesquisaEmpresa := RetornaSQLEmpresas;
end;

End.

