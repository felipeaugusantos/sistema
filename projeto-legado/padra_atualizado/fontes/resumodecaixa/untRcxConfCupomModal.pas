{*********************************}
{* ATENÇÃO AO MEXER NESTA UNIT   *}
{* ALTERAR A UNTMODALIDADE POIS  *}
{* É EQUIVALENTE                 *}
{******************************AF*}
{*************************************}
{* SE VC MEXER NA IMPRESSÃO DE CUPOM *}
{* VERIFIQUE SE VAI SER FEITO NO F11 *}
{**********************************AF*}
unit untRcxConfCupomModal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, EditFocus, QColorLabel, Menus, Buttons, Uni, untTypesSistema,
  ExtCtrls, untfuncoesSimples, StrUtils, untPai, AppEvnts, untGravaMovCar,
  BitBtnLockedIncrem, untFiscal, cxProgressBar, UniClientDataSet, Mask,
  MaskEditFocus, untFuncoesGenerica, untCadChq, MaskUtils, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmRcxConfCupomModal = class(TfrmPai)
    pnlTitulo: TPanel;
    pnlModalidades: TPanel;
    pnlTroco: TPanel;
    edtValDig: TEditFocus;
    Panel1: TPanel;
    lblTotal: TColorLabel;
    edtTotDoc: TEditFocus;
    btnConfirma: TBitBtnLocked;
    ColorLabel1: TColorLabel;
    edtValTro: TEditFocus;
    ColorLabel2: TColorLabel;
    Panel2: TPanel;
    chkEndEnt: TCheckBox;
    scrModalidades: TScrollBox;
    lblCgcCpf: TColorLabel;
    mskCgcCpf: TMaskEditFocus;
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    { Private declarations }
    strDesMod: String;
    strPatIni: String;
    strCodEcf: String;
    strModEcf: String;
    strPorta : String;
//    arrDatas : TDateArray;
    blnModDef  : Boolean;
    intModDef  : Integer;

    FPais: TPais;

    function fCarregaModalidades: Boolean;
    Function fTemModalidadeVinculado: Boolean;
    Function fImprimeEnderecoEntrega(strDesMod: String; ecfFiscal: TUntFiscal;
      strNumCOO: String; qryItens: TUniQuery): Boolean;

    Function fImprimeDadosGarantia(ecfFiscal: TUntFiscal): Boolean;

    function fRetQtdModalidades: Integer;
    function fCalculaTotDig: Double;
    function fTemVlrModMaior: Boolean;
    function fRetValModalidade( strIdenti: String ): Double;
    function fGravaCheques: Boolean;
    function fChequesCadastrados(fltValor: Double; blnPrazo: Boolean): Boolean;

    procedure pSetaEnderecoEntrega;
    Procedure pMensagemVinculado(ecfFiscal: TUntFiscal; strMensagem: String);
    function  fRetVencimentos( strConPag: String; dtaDtaEnt: TDateTime ): String;
    function fConfirma(pgbStatus: TcxProgressBar): Boolean;

    procedure pPosicionaModalidadeDefault(strCodFpg: String);
    procedure pStep(pgbStatus: TcxProgressBar);

    procedure pCancelaCupomNoEcf(ecfFiscal: TUntFiscal);
    function fLogChq(cdsLog: TUniClientDataSet; intOpcao: Integer): Boolean;
    procedure pImprimeModalidades(objFiscal: TUntFiscal;
      arrParametros: array of TObject);

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pOnKeyDownEdits(Sender: TObject; var Key: Word;
      Shift: TShiftState); override;

  public
    { Public declarations }

    strCodOpe    : String;
    arrCartoes   : TCartoesResumoCaixaArray;
    arrDuplicOri : Array[0..11] Of TArrDigDuplic;

    blnConfirma  : Boolean;

    fltTotal     : Double;
    fltDinheiro  : Double;
    fltCartao    : Double;
    fltChequeVis : Double;
    fltChequePre : Double;
    fltFaturado  : Double;
    fltOutros    : Double;

    cdsChqPre    : TUniClientDataSet;
    cdsChqVis    : TUniClientDataSet;

    strCodCnd    : String;
    strMskCnd    : String;

    strNumDoc    : String;
    strCodCli    : String;
    strNomCli    : String;
    strEndCli    : String;
    strCepCli    : String;
    strBaiCli    : String;
    strCidCli    : String;
    strEstCli    : String;
    strCodVen    : String;
    strNomVen    : String;
    strCGCCPF    : String;
    strIESCli    : String;
    strRG_Cli    : String;
    strFone01    : String;
    strEndEnt,
    strBaiEnt,
    strCepEnt,
    strCidEnt,
    strEstEnt    : String;  
    dtaDtaEnt    : TDateTime;
    strConPag    : String;

    strCodEmp    : String;
    strNomArq    : String;
    strSeqGer    : String;
    fltTotIcm    : Double;
    fltImpPag    : Double;
    fltPeImPg    : Double;
    fltFedImp    : Double;
    fltPeImFd    : Double;
    fltEstImp    : Double;
    fltPeImEs    : Double;
    fltMunImp    : Double;
    fltPeImMn    : Double;

    strNumSer    : String;
    strNumCoo    : String;
    strNumCcf    : String;

    blnMosMod    : Boolean;
    blnF10Automatico: Boolean;

    strMen001    : String;
    strMen002    : String;

    strCodFpg    : String;

    strTabelaGer: String;
    strSerie: String;
    strEspDoc: String;

    strCodigoCaixa: String;

    function fDigitacaoCartoes(fltValor: Double; pgbStatus: TcxProgressBar): Boolean;
    function fChequeVis(strValor: String): Boolean;
    function fChequePre(strValor: String): Boolean;
//    function fFaturado(fltValor: Double): Boolean;
    function fImprimeCupom( strSeqGer: String; pgbStatus: TcxProgressBar): Boolean;

    procedure pSetaModalidade(strCodMod: String; fltValor: Double);

  end;

var
  frmRcxConfCupomModal: TfrmRcxConfCupomModal;

implementation

uses
  {$IFNDEF LINUX}
    untArredondaParcelasCartoes,
  {$ENDIF LINUX}
  untRcxMostraCartoes, untRcxDigCartoes, untCadCheques,
  untConstantes,untFuncoes,
  untFuncTinta, untGravando, untCarnePagto,
  DB, untMovCar, untImpDadosGarantia, untImpressorCupom,
  untTCadChqRepository, untDuplicatas, untArredondaParcelaImpl;

{$R *.dfm}

Type Modalidades = record
       strModalidade : String;
       strIdentifMod : String;
       strCodigoMod  : String;
       edtCampo      : TEditFocus;
       lblLabel      : TLabel;
       fltValor      : Double;
       strInfAdi     : String;
     End;

Const intMaxModalidades = 20;
      blnModoTeste = False;          //Variavel para Teste de Gravacao **** NAO ESQUECE DE VOLTAR ****
Var
  arrModalidades : array[1..intMaxModalidades] of Modalidades;

function TfrmRcxConfCupomModal.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
Var fltTotDig: Double;
begin

  Result := True;

  If (inherited fValidaCampos(Sender)) Then
  Begin

    If (Sender is TEditFocus) Then
    Begin

      If ( fEmptyStr( ( Sender as TEditFocus ).Text ) ) Then
      Begin
        ( Sender as TEditFocus ).Text := '0,00';
        Result := True;
      End;

      If ( fStrToFloat( Trim( ( Sender as TEditFocus ).Text ) ) ) < 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'Valor não pode ser negativo!', ['&Ok']);
        Result := False;
      End;

      ( Sender as TEditFocus ).Text := FormatFloat('#,##0.00', fStrToFloat(( Sender as TEditFocus ).Text));

      If ( fStrToFloat( Trim( ( Sender as TEditFocus ).Text ) ) > fltTotal ) Then
      Begin

        {*****************************************}
        {* 2 - CHEQUE PRÉ                        *}
        {**************************************MA*}
        If ( Sender as TEditFocus ).Hint = '2' Then
        Begin
          fMensagem('ATENÇÃO!', 'O valor da Modalidade Cheque Pré não pode ultrapassar o Valor Total da Venda!', ['&Ok']);
          Result := False;
        End;

        {*****************************************}
        {* 3 - CARTAO                            *}
        {**************************************MA*}
        If ( Sender as TEditFocus ).Hint = '3' Then
        Begin
          fMensagem('ATENÇÃO!', 'O valor da Modalidade Cartão não pode ultrapassar o Valor Total da Venda!', ['&Ok']);
          Result := False;
        End;

        {*****************************************}
        {* 4 - CHEQUE A VISTA                    *}
        {**************************************MA*}
        If ( Sender as TEditFocus ).Hint = '4' Then
        Begin
          fMensagem('ATENÇÃO!', 'O valor da Modalidade Cheque a Vista não pode ultrapassar o Valor Total da Venda!', ['&Ok']);
          Result := False;
        End;

        {*****************************************}
        {* 5 - FATURADO                          *}
        {**************************************MA*}
        If ( Sender as TEditFocus ).Hint = '5' Then
        Begin
          fMensagem('ATENÇÃO!', 'O valor da Modalidade Faturado não pode ultrapassar o Valor Total da Venda!', ['&Ok']);
          Result := False;
        End;

      End;

      {*****************************************}
      {* SE VALIDADO                           *}
      {**************************************MA*}
      If Result Then
      Begin
        pSetaEnderecoEntrega;

        fltTotDig := fCalculaTotDig;

        edtValDig.Text := FormatFloat('#,##0.00', fltTotDig );
        If fltTotDig > fltTotal Then
          edtValTro.Text := FormatFloat('#,##0.00', fltTotDig - fltTotal )
        Else
          edtValTro.Text := FormatFloat('#,##0.00', 0.00 );

        {*****************************************}
        {* 0 - GERAL / OUTROS                    *}
        {**************************************MA*}
        If ( Sender as TEditFocus ).Hint = '0' Then
        Begin
          fltOutros    := fStrToFloat(( Sender as TEditFocus ).Text);
        End;

        {*****************************************}
        {* 1 - DINHEIRO                          *}
        {**************************************MA*}
        If ( Sender as TEditFocus ).Hint = '1' Then
        Begin
          fltDinheiro := fStrToFloat(( Sender as TEditFocus ).Text);
        End;

        {*****************************************}
        {* 2 - CHEQUE PRÉ                        *}
        {**************************************MA*}
        If ( Sender as TEditFocus ).Hint = '2' Then
        Begin
          fltChequePre := fStrToFloat(( Sender as TEditFocus ).Text);

          If fltChequePre > 0.00 Then
             Result := True; //fChequePre(( Sender as TEditFocus ).Text);

        End;

        {*****************************************}
        {* 3 - CARTAO                            *}
        {**************************************MA*}
        If ( Sender as TEditFocus ).Hint = '3' Then
        Begin
          fltCartao := fStrToFloat(( Sender as TEditFocus ).Text);

          If fltCartao > 0.00 Then
            Result := True; //fDigitacaoCartoes(fltCartao);

        End;

        {*****************************************}
        {* 4 - CHEQUE A VISTA                    *}
        {**************************************MA*}
        If ( Sender as TEditFocus ).Hint = '4' Then
        Begin
          fltChequeVis := fStrToFloat(( Sender as TEditFocus ).Text);

          If fltChequeVis > 0.00 Then
            Result := True; //fChequeVis(( Sender as TEditFocus ).Text)

        End;

        {*****************************************}
        {* 5 - FATURADO                          *}
        {**************************************MA*}
        If ( Sender as TEditFocus ).Hint = '5' Then
        Begin

          fltFaturado := fStrToFloat(( Sender as TEditFocus ).Text);

          If fltFaturado > 0.00 Then
            Result := True; //fFaturado(fltFaturado);

        End;

      End;

    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

function TfrmRcxConfCupomModal.fCarregaModalidades: Boolean;
Var intContador: Integer;
    edtTemp    : TEditFocus;
    lblTemp    : TLabel;
    strSql     : String;
    qryGenMod  : TUniQuery;
    strModDef  : string;
Begin
  strModDef := fCfgSis('MOD_F8');
  qryGenMod := fCriaQuery(Self);

  Result := False;

  With qryGenMod Do
  Begin

    strSql := '';
    strSql := strSql + ' SELECT * ';
    strSql := strSql + ' FROM ';
    strSql := strSql + '   ECFMOD ';
    strSql := strSql + ' WHERE ';
    strSql := strSql + '   ECF_CODECF = :CODECF ';

    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODECF').AsString := strCodEcf;
    Open;

    intContador := 1;

    blnModDef := Locate('ECF_DESMOD', strModDef, []);
    
    First;

    While Not Eof Do
    Begin

      arrModalidades[intContador].strModalidade := FieldByName('ECF_DESMOD').AsString;
      arrModalidades[intContador].strIdentifMod := FieldByName('ECF_IDENTI').AsString;
      arrModalidades[intContador].strCodigoMod  := FieldByName('ECF_CODMOD').AsString;


      If ((Not blnModDef) And (FieldByName('ECF_IDENTI').AsString = '1')) Or
         ( blnModDef      And SameText(FieldByName('ECF_DESMOD').AsString, strModDef)) Then
      Begin
        arrModalidades[intContador].fltValor      := fltTotal;
        intModDef := intContador;
      End Else
        arrModalidades[intContador].fltValor      := 0.00;

       If (FieldByName('ECF_INFADI').AsString = 'S') Then
        arrModalidades[intContador].strInfAdi := 'S'
      Else
        arrModalidades[intContador].strInfAdi := 'N';

      edtTemp := TEditFocus.Create( Self );
      edtTemp.Parent    := scrModalidades;
      edtTemp.Font      := edtTotDoc.Font;
      edtTemp.Alignment := taRightJustify;
      edtTemp.EditFormat:= '#,####0.00';
      edtTemp.Text      := FloatToStrF(arrModalidades[intContador].fltValor, ffFixed, 12, 2);
      edtTemp.Name      := 'edtTemp' + IntToStr(intContador);
      edtTemp.Top       := 8 + ((intContador - 1) * 25);
      edtTemp.Left      := edtTotDoc.Left;
      edtTemp.Width     := edtTotDoc.Width;
      edtTemp.TabOrder  := intContador;
      edtTemp.TipoTexto := ttNumerico;
      edtTemp.Tag       := 99;
      edtTemp.Hint      := FieldByName('ECF_IDENTI').AsString;
      edtTemp.OnKeyDown := pOnKeyDownEdits;

      lblTemp := TLabel.Create( Self );
      lblTemp.Parent    := scrModalidades;
      lblTemp.Font      := lblTotal.Font;
      lblTemp.Alignment := taRightJustify;
      lblTemp.Caption   := Trim(UpperCase(FieldByName('ECF_DESMOD').AsString)) + ':';
      lblTemp.Name      := 'lblTemp' + IntToStr(intContador);
      lblTemp.Height    := lblTotal.Height;
      lblTemp.Width     := lblTotal.Width;
      lblTemp.Top       := edtTemp.Top;
      lblTemp.Layout    := tlCenter;
      lblTemp.Left      := lblTotal.Left;

      arrModalidades[intContador].edtCampo := edtTemp;
      arrModalidades[intContador].lblLabel := lblTemp;

      If (intContador > 1) And (frmRcxConfCupomModal.Height <= 500) Then
        frmRcxConfCupomModal.Height := frmRcxConfCupomModal.Height + 28
      Else If (intContador <= 1) Then
        frmRcxConfCupomModal.Height := frmRcxConfCupomModal.Height + 32;

      Inc(intContador);

      Result := True;

      Next;
    End;
    
  End;

  FreeAndNil(qryGenMod);
End;

procedure TfrmRcxConfCupomModal.pSetaEnderecoEntrega;
Begin
  chkEndEnt.Enabled := (VS_strUsaTef <> 'S') And (fCfgSis('CUPEET') = 'S') And fTemModalidadeVinculado;

  If fCfgSis('CHKENT', varBoolean) Then
    chkEndEnt.Checked := chkEndEnt.Enabled;
End;

procedure TfrmRcxConfCupomModal.FormShow(Sender: TObject);
  Var
    strAux: String;
begin
  inherited;

  If Not blnModDef Then
  Begin
    arrModalidades[ 1 ].edtCampo.Text := FloatToStrF( fltDinheiro, ffFixed, 12, 2 );
    pSetFocus(arrModalidades[ 1 ].edtCampo);
  End Else
  Begin
    arrModalidades[ intModDef ].edtCampo.Text := FloatToStrF( fltDinheiro, ffFixed, 12, 2 );
    pSetFocus(arrModalidades[ intModDef ].edtCampo);
  End;

  pSetaEnderecoEntrega;

  If fCfgSis('MODFF8', varBoolean) Then
  Begin
    pPosicionaModalidadeDefault(strCodFpg);
  End;  

  strAux := fFormataCpfCgc(strCGCCPF, FPais);
  If Pos('/', strAux) > 0 Then
  Begin
    lblCgcCpf.Caption  := 'CNPJ:';
    mskCgcCpf.EditMask := fRetMascaraC_G_C_(fSetaPais, C_G_C_);
  End
  Else
  Begin
    lblCgcCpf.Caption  := 'CPF:';
    mskCgcCpf.EditMask := fRetMascaraC_G_C_(fSetaPais, C_P_F_);
  End;
  mskCgcCpf.Text := strCGCCPF;
  
end;

{*****************************************}
{* FUNÇÃO QUE É ATRIBUIDA NO EVENTO      *}
{* 'OnKeyDown' DOS Edits. (continua...)  *}
{**************************************MV*}
procedure TfrmRcxConfCupomModal.pOnKeyDownEdits(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
end;

function TfrmRcxConfCupomModal.fCalculaTotDig: Double;
Var intContador: Integer;
Begin

  Result := 0.00;
  For intContador := 1 To intMaxModalidades Do
    If ( arrModalidades[ intContador ].edtCampo <> Nil ) Then
      Result := Result + fStrToFloat( Trim( arrModalidades[ intContador ].edtCampo.Text ) );

End;

function TfrmRcxConfCupomModal.fRetQtdModalidades: Integer;
Var intContador: Integer;
Begin

  Result := 0;
  For intContador := 1 To intMaxModalidades Do
    If ( arrModalidades[ intContador ].edtCampo <> Nil ) Then
      If fStrToFloat( Trim( arrModalidades[ intContador ].edtCampo.Text ) ) > 0 Then
        inc( Result );

End;

function TfrmRcxConfCupomModal.fRetValModalidade( strIdenti: String ): Double;
Var intContador: Integer;
Begin

  {*****************************************}
  {* IDENTIFICACAO:                        *}
  {* 1 - DINHEIRO                          *}
  {* 2 - CHEQUE PRÉ                        *}
  {* 3 - CARTAO                            *}
  {* 4 - CHEQUE A VISTA                    *}
  {* 5 - FATURADO                          *}
  {**************************************MA*}
  Result := 0;
  For intContador := 1 To intMaxModalidades Do
    If ( arrModalidades[ intContador ].edtCampo <> Nil ) Then
      If arrModalidades[ intContador ].strIdentifMod = strIdenti Then
        Result := fStrToFloat( Trim( arrModalidades[ intContador ].edtCampo.Text ) );

End;

function TfrmRcxConfCupomModal.fTemVlrModMaior: Boolean;
Var intContador: Integer;
Begin

  Result := False;
  For intContador := 1 To intMaxModalidades Do
    If ( arrModalidades[ intContador ].edtCampo <> Nil ) Then
      If fStrToFloat( Trim( arrModalidades[ intContador ].edtCampo.Text ) ) >= fltTotal Then
        Result := True;

End;

procedure TfrmRcxConfCupomModal.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  If (Not fEmptyStr(mskCgcCpf.Text)) Then
  Begin
    If Not fValidaCnpjCpf(IIF(lblCgcCpf.Caption = 'CPF:','2','1'), mskCgcCpf.Text, True, True) Then
    Begin
      pSetFocus(mskCgcCpf);
      Exit;
    End;
  End;
  
  Try

    pCriarFormularios(TfrmGravando,frmGravando);
    frmGravando.lblGravando.Caption := 'Aguarde... Imprimindo.';
    frmGravando.strChave := 'RCXIMPCUPVEL';
    frmGravando.fExecutarAcao := fConfirma;
    frmGravando.ShowModal;
    blnConfirma := frmGravando.blnConfirma;

    Close;

  Except
    On E: Exception Do
    Begin
      blnConfirma := False;
      pMensagensErro(E.Message,'[Confirma - untRcxConfCupomModal]');
    End;
  End;
  pFreeAndNil(frmGravando);

end;

procedure TfrmRcxConfCupomModal.pStep(pgbStatus: TcxProgressBar);
Begin
  If Assigned(pgbStatus) Then
  Begin
    pgbStatus.Position := pgbStatus.Position + 1;
    Application.ProcessMessages;
  End;
End;

function TfrmRcxConfCupomModal.fConfirma(pgbStatus: TcxProgressBar): Boolean;
  Var
    intQtdMod          : Integer;
    intContCopia       : Integer;
    intContador        : Integer;
    intContador2       : Integer;
    fltTotDig          : Double;
    fltTmpCartao       : Double;
    blnRetorno         : Boolean;
    arrDuplicFat,
    arrDuplicata       : TArrDigDuplicArray;
    objArredondaParcela: IArredondaParcela;
    LTipoParcelamento: String;
Begin

  Result    := False;
  intQtdMod := fRetQtdModalidades;
  fltTotDig := fCalculaTotDig;

  pgbStatus.Position := 0;

  If intQtdMod <= 0 Then
  Begin
    fMensagem('ATENÇÃO!', 'Nenhuma Modalidade foi digitada!', ['&Ok']);
    pSetFocus(arrModalidades[ 1 ].edtCampo);
    Exit;
  End;

  {****************************************}
  {* VERIFICA SE FORAM DIGITADAS AS       *}
  {* INFORMACOES DE TODAS AS MODALIDADES  *}
  {* MAIOR QUE 0 E SE OS VALORES DIGITADOS*}
  {* BATEM COM O VALOR DA MODALIDADE      *}
  {*************************************MA*}
  For intContador := 1 To intMaxModalidades Do
  Begin

    If ( arrModalidades[ intContador ].edtCampo <> Nil ) Then
    Begin

      If fStrToFloat( Trim( arrModalidades[ intContador ].edtCampo.Text ) ) > 0 Then
      Begin

        {****************************************}
        {* VERIFICA CHEQUES PRE                 *}
        {*************************************MA*}
        If arrModalidades[ intContador ].strIdentifMod = '2' Then
        Begin

          If Assigned(cdsChqPre) Then
          Begin

            If Not fChequesCadastrados(fStrToFloat(arrModalidades[ intContador ].edtCampo.Text), True) Then
            Begin
              fMensagem('','O valor dos cheques a prazo cadastrados difere do valor digitado!!!',['&OK']);
              pSetFocus(arrModalidades[ intContador ].edtCampo);
              Exit;
            End;

          End;

        End;

        {****************************************}
        {* VERIFICA CARTOES                     *}
        {*************************************MA*}
        If arrModalidades[ intContador ].strIdentifMod = '3' Then
        Begin

          fltTmpCartao := 0;
          If Length(arrCartoes) > 0 Then
          Begin

            For intContador2 := 0 To Length(arrCartoes) - 1 Do
            Begin
              fltTmpCartao := fltTmpCartao + arrCartoes[intContador2].fltValDig;
            End;

            If Not ( fltTmpCartao = fStrToFloat( arrModalidades[ intContador ].edtCampo.Text ) ) Then
            Begin
              fMensagem('','O valor dos cartões cadastrados difere do valor digitado!!!',['&OK']);
              pSetFocus(arrModalidades[ intContador ].edtCampo);
              Exit;
            End;

          End;

        End;

        {****************************************}
        {* VERIFICA CHEQUES A VISTA CADASTRADOS *}
        {*************************************MA*}
        If arrModalidades[ intContador ].strIdentifMod = '4' Then
        Begin

          If Assigned(cdsChqVis) Then
          Begin
            If Not fChequesCadastrados(fStrToFloat(arrModalidades[ intContador ].edtCampo.Text), False) Then
            Begin
              fMensagem('','O valor dos cheques a vista cadastrados difere do valor digitado!!!',['&OK']);
              pSetFocus(arrModalidades[ intContador ].edtCampo);
              Exit;
            End;
          End;

        End;

      End;

    End;

  End;

  pStep(pgbStatus);
  If ( intQtdMod > 1 ) And fTemVlrModMaior Then
  Begin
    fMensagem('ATENÇÃO!', 'Existe várias Modalidades digitadas sendo que em alguma delas o Valor é maior ou igual ao Valor Total da Venda!', ['&Ok']);
    pSetFocus(arrModalidades[ 1 ].edtCampo);
    Exit;
  End;

  pStep(pgbStatus);

  If fltTotDig < fltTotal Then
  Begin
    fMensagem('ATENÇÃO!', 'A soma das Modalidades deve ser igual ou maior ao Valor Total da Venda!', ['&Ok']);
    pSetFocus(arrModalidades[ 1 ].edtCampo);
    Exit;
  End;

  pStep(pgbStatus);
  {*****************************************}
  {* VALIDA TROCO QUANDO DIGITADO SOMENTE  *}
  {* UMA MODALIDADE                        *}
  {**************************************MA*}
  If ( intQtdMod = 1 ) And ( fltTotDig > fltTotal ) Then
  Begin

    {*****************************************}
    {* 2 - CHEQUE PRÉ                        *}
    {**************************************MA*}
    If fRetValModalidade( '2' ) > fltTotal Then
    Begin
      fMensagem('ATENÇÃO!', 'O valor da Modalidade Cheque Pré não pode ultrapassar o Valor Total da Venda!', ['&Ok']);
      pSetFocus(arrModalidades[ 1 ].edtCampo);
      Exit;
    End;

    {*****************************************}
    {* 3 - CARTAO                            *}
    {**************************************MA*}
    If fRetValModalidade( '3' ) > fltTotal Then
    Begin
      fMensagem('ATENÇÃO!', 'O valor da Modalidade Cartão não pode ultrapassar o Valor Total da Venda!', ['&Ok']);
      pSetFocus(arrModalidades[ 1 ].edtCampo);
      Exit;
    End;

    {*****************************************}
    {* 4 - CHEQUE A VISTA                    *}
    {**************************************MA*}
    If fRetValModalidade( '4' ) > fltTotal Then
    Begin
      fMensagem('ATENÇÃO!', 'O valor da Modalidade Cheque a Vista não pode ultrapassar o Valor Total da Venda!', ['&Ok']);
      pSetFocus(arrModalidades[ 1 ].edtCampo);
      Exit;
    End;

    {*****************************************}
    {* 5 - FATURADO                          *}
    {**************************************MA*}
    If fRetValModalidade( '5' ) > fltTotal Then
    Begin
      fMensagem('ATENÇÃO!', 'O valor da Modalidade Faturado não pode ultrapassar o Valor Total da Venda!', ['&Ok']);
      pSetFocus(arrModalidades[ 1 ].edtCampo);
      Exit;
    End;

  End;

  pStep(pgbStatus);
  {*****************************************}
  {* PERMITE DAR TROCO                     *}
  {* UMA MODALIDADE                        *}
  {**************************************MA*}
  If ( fltDinheiro < ( fltTotDig - fltTotal ) ) Then
  Begin
    fMensagem('ATENÇÃO!', 'O Valor do Troco não pode ser maior que a Modalidade Dinheiro!', ['&Ok']);
    pSetFocus(arrModalidades[ 1 ].edtCampo);
    Exit;
  End;

  pStep(pgbStatus);

  {*****************************************}
  {* ABATE DO DINHEIRO O VALOR DO TROCO    *}
  {* PARA SALVAR SOMENTE O VALOR FINAL     *}
  {* DO DINHEIRO QUE ENTROU NO CAIXA       *}
  {**************************************MA*}
  fltDinheiro := ( fltDinheiro - ( fltTotDig - fltTotal ) );

  If (Not blnMosMod) Or (fMensagem('', 'Confirma?', ['&Sim', '&Não' ], 1) = 1) Then
  Begin

    Try

      {*****************************************}
      {* IMPRIME CUPOM FISCAL                  *}
      {**************************************MA*}
      If blnModoTeste Or fImprimeCupom( strSeqGer, pgbStatus ) Then
      Begin
        pStep(pgbStatus);

        {*************************************************}
        {* DEVE SER CHAMADO ANTES DA TRANSACAO PRINCIPAL *}
        {*********************************************JC**}
        fRetSequencialMovCar('MOVCAR', VS_strCodEmp, arrCartoes);

        {*******************************************}
        {* REALIZA GRAVAÇÃO DO CARTÃO              *}
        {****************************************MA*}
        If (fCfgSis('USACTC', varBoolean)) And (Length(arrCartoes) > 0) Then
        Begin

          For intContador := 0 To Length(arrCartoes) -1 Do
          Begin

            LTipoParcelamento := '';

            {$IFNDEF LINUX}
              LTipoParcelamento := fCampoTabela('CAR_ARRPAR', 'CADCAR', ['CAR_CODCAR'], [arrCartoes[intContador].strCodCar]);

              If (arrCartoes[intContador].strTipCar = 'POS') And (LTipoParcelamento <> 'N') Then
                objArredondaParcela := TArredondaParCartaoPos.fArredondamentoParcelas(arrCartoes[intContador].strCodCar)
              Else
                objArredondaParcela := fArredondamentoParcelas(arrCartoes[intContador].strCodCar);
            {$ELSE}
              objArredondaParcela := fArredondamentoParcelas(arrCartoes[intContador].strCodCar);
            {$ENDIF LINUX}

            fDigDuplicVar(arrCartoes[intContador].strCndPag, 0, arrCartoes[intContador].fltValDig, False, False, False, VS_Date, False, arrDuplicata, 0, 'N', False, False, 0, objArredondaParcela);
            SetLength(arrDuplicFat, Length(arrDuplicata));

            For intContCopia := 0 To Length(arrDuplicata) - 1 Do
              arrDuplicFat[intContCopia] := arrDuplicata[intContCopia];

            fDigDuplicVar(arrCartoes[intContador].strCndPag, 0, arrCartoes[intContador].fltValDes, False, False, False, VS_Date, False, arrDuplicata, 0, 'N', False, False, 0, objArredondaParcela);

            intContador2 := 0;
            While (intContador2 < Length(arrDuplicata))                 And
                  (Not fEmptyStr(arrDuplicata[intContador2].strSequen)) Do
            Begin

              blnRetorno := fGravaMovCar(Self.Name,
                                         'INCLUSÃO',
                                         arrCartoes[intContador].strNumDup,
                                         strCodCli,
                                         arrDuplicata[intContador2].strSequen,
                                         VS_strCodEmp,
                                         arrCartoes[intContador].strCodCar,
                                         VS_Date,
                                         StrToDate(arrDuplicata[intContador2].dtaDtaVen),
                                         arrDuplicata[intContador2].curValor,
                                         arrDuplicata[intContador2].curValor,
                                         arrCartoes[intContador].strObsCar,
                                         '',
                                         arrCartoes[intContador].strCndPag,
                                         0,
                                         0.0,
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         arrCartoes[intContador].fltPerDes,
                                         arrDuplicFat[intContador2].curValor,
                                         arrDuplicFat[intContador2].curValor - arrDuplicata[intContador2].curValor,
                                         arrCartoes[intContador].strNumCcd,
                                         '',
                                         '',
                                         0,
                                         '',
                                         strCodOpe,
                                         True,
                                         '',
                                         'F',
                                         '',
                                         'TEF',
                                         0,0,0,0,
                                         arrCartoes[intContador].strNumNsu,
                                         '',
                                         0,0,0,0,
                                         strCodigoCaixa);

              Inc(intContador2);

              If (Not blnRetorno) Then
              Begin
                fRollBack;
                SetLength(arrCartoes, 0);
                Screen.Cursor := crDefault;
                Exit;
              End;

            End;

          End;

          SetLength(arrCartoes,0);
        End;

        pStep(pgbStatus);

        If (Assigned(cdsChqPre) And (Not cdsChqPre.IsEmpty)) Or
           (Assigned(cdsChqVis) And (Not cdsChqVis.IsEmpty)) Then
        Begin
          blnRetorno := fGravaCheques;

          If (Not blnRetorno) Then
          Begin
            fRollBack;
            cdsChqPre.EmptyDataSet;
            cdsChqVis.EmptyDataSet;
            Screen.Cursor := crDefault;
            Exit;
          End;

        End;

        Result := True;

      End;

    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[frmRcxConfCupomModal.btnConfirmaClick]');
      End;
    End;

    pStep(pgbStatus);

    If (Not Result) And (blnMosMod) Then
      pSetFocus(arrModalidades[ 1 ].edtCampo);

  End;

End;

{************************************}
{* DIGITAÇÃO DOS CARTÕES            *}
{*********************************MA*}
function TfrmRcxConfCupomModal.fDigitacaoCartoes(fltValor: Double; pgbStatus: TcxProgressBar): Boolean;
  Var
    fltTotCar: Double;
    intTamMat: Integer;
    intContador: Integer;
    intContador2: Integer;
    intContador3: Integer;

    strCodCar: String;
    strDesCar: String;
    fltValDig: Double;
    dtaDatTra: TDateTime;
    fltValDes: Double;
    fltPerDes: Double;
    strCndPag: String;
    strObsCar: String;
    strNumCcd: String;
    strTipCar: String;

    blnSaiFor: Boolean;

    stlDeletados: TStringList;
    frmRcxMostraCartoes : TfrmRcxMostraCartoes;
    frmRcxDigCartoes : TfrmRcxDigCartoes;
begin

  Result := True;

  If (fltValor = 0.0) Then
  Begin
    SetLength(arrCartoes, 0);
    Exit;
  End;

  fltTotCar := 0.0;
  fltValDig := 0.0;
  fltValDes := 0.0;
  fltPerDes := 0.0;
  dtaDatTra := 0;

  For intContador := 0 To Length(arrCartoes) -1 Do
  Begin
    fltTotCar := fltTotCar + arrCartoes[intContador].fltValDig;
  End;

  If (fltTotCar = fltValor) Then
  Begin

    Try
      pCriarFormularios(TfrmRcxMostraCartoes, frmRcxMostraCartoes);

      For intContador := 0 To Length(arrCartoes) -1 Do
      Begin
        frmRcxMostraCartoes.lsvCartoes.AddItem(arrCartoes[intContador].strCodCar + ' - ' +
                                               arrCartoes[intContador].strDesCar, Nil);
        frmRcxMostraCartoes.lsvCartoes.Items[intContador].SubItems.Add(FloatToStrF(arrCartoes[intContador].fltValDig, ffFixed, 12, 2));
        frmRcxMostraCartoes.lsvCartoes.Items[intContador].SubItems.Add(IntToStr(arrCartoes[intContador].intCodSeq));
      End;
      frmRcxMostraCartoes.lsvCartoes.Columns[2].Width := 0;

      frmRcxMostraCartoes.ShowModal;

      stlDeletados := frmRcxMostraCartoes.stlDeletados;

      For intContador := 0 To stlDeletados.Count -1 Do
      Begin

        blnSaiFor := False;

        For intContador2 := 0 To Length(arrCartoes) -1 Do
        Begin

          If (arrCartoes[intContador2].intCodSeq = StrToInt(stlDeletados[intContador])) Then
          Begin

            For intContador3 := intContador2 To Length(arrCartoes) - 2 Do
            Begin
              arrCartoes[intContador3] := arrCartoes[intContador3+1];
            End;
            SetLength(arrCartoes, Length(arrCartoes)-1);
            blnSaiFor := True;
          End;

          If (blnSaiFor) Then
            Break;

        End;

      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[frmRcxConfCupomModal.fDigitacaoCartoes]');
      End;
    End;

    pFreeAndNil(frmRcxMostraCartoes);

  End;

  fltTotCar := 0.0;
  For intContador := 0 To Length(arrCartoes) -1 Do
  Begin
    fltTotCar := fltTotCar + arrCartoes[intContador].fltValDig;
  End;

  If fltValor < fltTotCar Then
  Begin
    fltTotCar := 0.0;
    SetLength(arrCartoes,0);
  End;

  While (fltTotCar < fltValor) Do
  Begin

    Try
      pCriarFormularios(TfrmRcxDigCartoes, frmRcxDigCartoes);
      frmRcxDigCartoes.fltTotDig := fltTotCar;
      frmRcxDigCartoes.fltTotGer := fltValor;
      frmRcxDigCartoes.fltMaxDig := (fltValor - fltTotCar);
      frmRcxDigCartoes.arrCartoes := arrCartoes;
      frmRcxDigCartoes.ShowModal;

      strCodCar := frmRcxDigCartoes.edtCodCar.Text;
      strDesCar := frmRcxDigCartoes.edtDesCar.Text;
      fltValDig := frmRcxDigCartoes.fltValDig;
      dtaDatTra := frmRcxDigCartoes.dtaDatTra;
      fltValDes := frmRcxDigCartoes.fltValDes;
      strCndPag := frmRcxDigCartoes.mskCndPag.Text;
      strNumCcd := frmRcxDigCartoes.edtNumCcd.Text;
      strObsCar := frmRcxDigCartoes.edtObsCar.Text;
      fltPerDes := frmRcxDigCartoes.fltPerDes;
      strTipCar := IIF(frmRcxDigCartoes.blnTipPOS, 'POS', 'TEF');

      Result    := frmRcxDigCartoes.blnConfirma;

    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[frmRcxConfCupomModal.fDigitacaoCartoes_1]');
      End;
    End;
    
    pFreeAndNil(frmRcxDigCartoes);

    If (Result) Then
    Begin
      intTamMat := Length(arrCartoes);
      SetLength(arrCartoes, intTamMat+1);
      arrCartoes[intTamMat].intCodSeq := intTamMat;
      arrCartoes[intTamMat].strCodCar := strCodCar;
      arrCartoes[intTamMat].strDesCar := strDesCar;
      arrCartoes[intTamMat].fltValDig := fltValDig;
      arrCartoes[intTamMat].strCndPag := strCndPag;
      arrCartoes[intTamMat].strObsCar := strObsCar;
      arrCartoes[intTamMat].fltValDes := fltValDes;
      arrCartoes[intTamMat].strNumCcd := strNumCcd;
      arrCartoes[intTamMat].fltPerDes := fltPerDes;
      arrCartoes[intTamMat].strTipCar := strTipCar;
      arrCartoes[intTamMat].dtaDtaTra := dtaDatTra;

      fltTotCar := 0.0;
      For intContador := 0 To Length(arrCartoes) -1 Do
      Begin
        fltTotCar := fltTotCar + arrCartoes[intContador].fltValDig;
      End;

    End
    Else
    Begin
      SetLength(arrCartoes, 0);
      Break;
    End;

  End;

end;

{************************************}
{* CADASTRA CHEQUES A VISTA         *}
{*********************************MA*}
function TfrmRcxConfCupomModal.fChequeVis(strValor: String): Boolean;
  Var
    fltValCar: Double;
Begin
  Result := True;

  //pDeletaTemporaria(strTabTp2);

  If Not Assigned(cdsChqVis) Then cdsChqVis := fCriaCdsCheques(Self);

  With cdsChqVis Do
  Begin
    First;

    fltValCar := fStrToFloat(strValor);

    Try
      pCriarFormularios(TfrmCadCheques,frmCadCheques);
      frmCadCheques.strCodOpe         := strCodOpe;
      frmCadCheques.blnResumida       := True;
      frmCadCheques.blnResCai         := True;
      frmCadCheques.blnGravacaoFisica := False;      
      frmCadCheques.fltValTot         := fltValCar;
      frmCadCheques.cdsChqRcx         := cdsChqVis;
      frmCadCheques.blnPrazo          := False;
      frmCadCheques.dbeDtaCad.Enabled := False;
      frmCadCheques.dbeDtaCad.TabStop := False;
      frmCadCheques.dbeDtaVen.Enabled := False;
      frmCadCheques.dbeDtaVen.TabStop := False;

      frmCadCheques.cdsChqOutroTip.Data := cdsChqPre.Data;

      frmCadCheques.RotinaChamada := 'CONFIRMAÇÃO DE CUPOM FISCAL';

      frmCadCheques.ShowModal;

      cdsChqVis.Data := frmCadCheques.cdsTabela.Data;

      If IsEmpty Or (Not frmCadCheques.blnConfima) Then
      Begin
        Result := False;
      End;

    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[frmRcxConfCupomModal.fChequeVis]');
      End;
    End;

    pFreeAndNil(frmCadCheques);

  End;

End;

{************************************}
{* CADASTRA OS CHEQUES PRE          *}
{*********************************MA*}
function TfrmRcxConfCupomModal.fChequePre(strValor: String): Boolean;
  Var
    fltValCar: Double;
Begin
  Result := True;

  //pDeletaTemporaria(strTabTmp);

  If Not Assigned(cdsChqPre) Then cdsChqPre := fCriaCdsCheques(Self);

  With cdsChqPre Do
  Begin
    First;

    fltValCar := fStrToFloat(strValor);

    Try
      pCriarFormularios(TfrmCadCheques,frmCadCheques);
      frmCadCheques.strCodOpe  := strCodOpe;
      frmCadCheques.blnResumida       := True;
      frmCadCheques.blnResCai  := True;
      frmCadCheques.blnGravacaoFisica := False;      
      frmCadCheques.fltValTot  := fltValCar;
      frmCadCheques.cdsChqRcx  := cdsChqPre;
      frmCadCheques.blnPrazo   := True;

      frmCadCheques.cdsChqOutroTip.Data := cdsChqVis.Data;

      frmCadCheques.RotinaChamada := 'CONFIRMAÇÃO DE CUPOM FISCAL';

      frmCadCheques.ShowModal;

      cdsChqPre.Data := frmCadCheques.cdsTabela.Data;      

      If IsEmpty Or (Not frmCadCheques.blnConfima) Then
      Begin
        Result := False;
      End;

    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[frmRcxConfCupomModal.fChequePre]');
      End;
    End;

    pFreeAndNil(frmCadCheques);

  End;

End;

{*************************************}
{* PEDE FATURADO                     *}
{**********************************MA*}
{function TfrmRcxConfCupomModal.fFaturado(fltValor: Double): Boolean;
  Var
    intContador: Integer;
    strConPag  : String;
Begin

  Result := True;

  {*****************************************}
  {* CHAMA A TELA DE CONDIÇÃO DE PAGAMENTO *}
  {**************************************MA*}
{  Try
    pCriarFormularios(TfrmDigCndPagamento, frmDigCndPagamento);
    frmDigCndPagamento.pnlForPag.Visible := False;
    frmDigCndPagamento.Height := frmDigCndPagamento.Height - frmDigCndPagamento.pnlForPag.Height;
    frmDigCndPagamento.mskCndPag.EditMask := '99.999.999.999.999.999.999.999.999.999.999.999;0;_';

    frmDigCndPagamento.edtCodCnd.Text := strCodCnd;
    frmDigCndPagamento.strCndPag      := strMskCnd;
    frmDigCndPagamento.mskCndPag.Text := strMskCnd;

    frmDigCndPagamento.showModal;
  Finally
    Result := frmDigCndPagamento.blnConfirma;

    If Result Then
    Begin

      strMskCnd := frmDigCndPagamento.strCndPag;
      strCodCnd := frmDigCndPagamento.edtCodCnd.Text;

      If Copy(frmDigCndPagamento.mskCndPag.Text,3,3) <= '000' Then
      Begin
        fMensagem('','A condição de pagamento deve ser a prazo!',['&OK']);
        Result := False;
      End;

    End;

   pFreeAndNil(frmDigCndPagamento);

    If Result Then
    Begin

      Repeat
        pZeraDigDuplic;
        Result := fDigDuplic(strMskCnd, 0, fltValor, True, True, False, VS_Date, False);

        If Not Result Then
          Break;

        intContador := 0;
        {*****************************************}
        {* REFAZ A CONDIÇÃO DE PAGAMENTO         *}
        {* E VERIFICA SE EH A VISTA              *}
        {**************************************MA*}
{        While (ArrDuplicata[intContador].dtaDtaVen <> '') And
              (intContador < 11)                          Do
        Begin

          SetLength(arrDatas, intContador + 1);
          arrDatas[intContador] := StrToDate(ArrDuplicata[intContador].dtaDtaVen);
          Inc(intContador);

        End;
        strConPag := fRetornaCndPag(arrDatas, VS_Date);

        If Copy(strConPag,3,3) <= '000' Then
        Begin
          fMensagem('','A condição de pagamento deve ser a prazo!',['&OK']);
          Result := False;
        End;

        If Result Then Break;

      Until False;

    End;

  End;

End;}

{************************************}
{* GRAVA CHEQUES CARREGADOS NA TEMP *}
{*********************************MA*}
function TfrmRcxConfCupomModal.fGravaCheques: Boolean;
  Var
    strTabela: String;
Begin
  Try
    Result := True;

    strTabela := 'CADCHQ'; 

    With cdsChqPre Do
    Begin

      If (Assigned(cdsChqPre)) And (Active) And (Not IsEmpty) Then
      Begin

        First;

        While (Not Eof) Do
        Begin
          Application.ProcessMessages;

          untCadChq.fGravaCheque(FieldByName('CHQ_CODBCO').AsString,
                                 FieldByName('CHQ_NUMAGE').AsString,
                                 FieldByName('CHQ_CONCOR').AsString,
                                 FieldByName('CHQ_NUMCHQ').AsString,
                                 FieldByName('CHQ_CODCLI').AsString,
                                 FieldByName('CHQ_NOMEMI').AsString,
                                 FieldByName('CHQ_ENDERE').AsString,
                                 FieldByName('CHQ_TELEMI').AsString,
                                 FieldByName('CHQ_CGCCPF').AsString,
                                 FieldByName('CHQ_C_G_C_').AsString,
                                 FieldByName('CHQ_HIST01').AsString,
                                 FieldByName('CHQ_HIST02').AsString,
                                 FieldByName('CHQ_CTADEP').AsString,
                                 FieldByName('CHQ_DOCDEP').AsString,
                                 FieldByName('CHQ_CODPOR').AsString,
                                 FieldByName('CHQ_CODCTA').AsString,
                                 FieldByName('CHQ_MOTDEV').AsString,
                                 FieldByName('CHQ_FORREP').AsString,
                                 FieldByName('CHQ_OBSREP').AsString,
                                 FieldByName('CHQ_CODEMP').AsString,
                                 FieldByName('CHQ_NUMNOT').AsString,
                                 FieldByName('CHQ_PORCUS').AsString,
                                 '',
                                 'N',
                                 FieldByName('CHQ_DTACAD').AsDateTime,
                                 FieldByName('CHQ_DTAVEN').AsDateTime,
                                 FieldByName('CHQ_DTADEP').AsDateTime,
                                 FieldByName('CHQ_DTADEV').AsDateTime,
                                 FieldByName('CHQ_DTARDP').AsDateTime,
                                 FieldByName('CHQ_DTAREP').AsDateTime,
                                 FieldByName('CHQ_DTACUS').AsDateTime,
                                 FieldByName('CHQ_VALCHQ').AsFloat,
                                 '',
                                 0,
                                 VS_strCodEmp,
                                 1,
                                 FieldByName('CHQ_TELCHE').AsString,
                                 FieldByName('CHQ_TELNUM').AsString,
                                 FieldByName('CHQ_CODOPE').AsString,
                                 FieldByName('CHQ_CODCMC').AsString,
                                 0,0,0,0,
                                 FieldByName('CHQ_PORCHQ').AsString,
                                 Self.Name,
                                 FieldByName('CHQ_NAODEP').AsString,
                                 FieldByName('CHQ_CODCID').AsString,
                                 strCodigoCaixa);

          Result := fLogChq(cdsChqPre, 1);

          Next;
        End;

      End;

      Close;
    End;

    cdsChqPre.EmptyDataSet;

   {************************************}
   {* CHEQUE A VISTA                   *}
   {*********************************MA*}
    With cdsChqVis Do
    Begin

      If (Assigned(cdsChqVis)) And (Active) And (Not IsEmpty) Then
      Begin

        First;

        While Not Eof Do
        Begin
          Application.ProcessMessages;

          untCadChq.fGravaCheque(FieldByName('CHQ_CODBCO').AsString,
                                 FieldByName('CHQ_NUMAGE').AsString,
                                 FieldByName('CHQ_CONCOR').AsString,
                                 FieldByName('CHQ_NUMCHQ').AsString,
                                 FieldByName('CHQ_CODCLI').AsString,
                                 FieldByName('CHQ_NOMEMI').AsString,
                                 FieldByName('CHQ_ENDERE').AsString,
                                 FieldByName('CHQ_TELEMI').AsString,
                                 FieldByName('CHQ_CGCCPF').AsString,
                                 FieldByName('CHQ_C_G_C_').AsString,
                                 FieldByName('CHQ_HIST01').AsString,
                                 FieldByName('CHQ_HIST02').AsString,
                                 FieldByName('CHQ_CTADEP').AsString,
                                 FieldByName('CHQ_DOCDEP').AsString,
                                 FieldByName('CHQ_CODPOR').AsString,
                                 FieldByName('CHQ_CODCTA').AsString,
                                 FieldByName('CHQ_MOTDEV').AsString,
                                 FieldByName('CHQ_FORREP').AsString,
                                 FieldByName('CHQ_OBSREP').AsString,
                                 FieldByName('CHQ_CODEMP').AsString,
                                 FieldByName('CHQ_NUMNOT').AsString,
                                 FieldByName('CHQ_PORCUS').AsString,
                                 '',
                                 'N',
                                 FieldByName('CHQ_DTACAD').AsDateTime,
                                 FieldByName('CHQ_DTAVEN').AsDateTime,
                                 FieldByName('CHQ_DTADEP').AsDateTime,
                                 FieldByName('CHQ_DTADEV').AsDateTime,
                                 FieldByName('CHQ_DTARDP').AsDateTime,
                                 FieldByName('CHQ_DTAREP').AsDateTime,
                                 FieldByName('CHQ_DTACUS').AsDateTime,
                                 FieldByName('CHQ_VALCHQ').AsFloat,
                                 '',
                                 0,
                                 VS_strCodEmp,
                                 1,
                                 FieldByName('CHQ_TELCHE').AsString,
                                 FieldByName('CHQ_TELNUM').AsString,
                                 FieldByName('CHQ_CODOPE').AsString,
                                 FieldByName('CHQ_CODCMC').AsString,
                                 0,0,0,0,
                                 FieldByName('CHQ_PORCHQ').AsString,
                                 Self.Name,
                                 FieldByName('CHQ_NAODEP').AsString,
                                 FieldByName('CHQ_CODCID').AsString,
                                 strCodigoCaixa);

          Result := fLogChq(cdsChqVis, 2);

          Next;
        End;

      End;

      Close;
    End;

    cdsChqVis.EmptyDataSet;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[fGravaCheques]');
      Result := False;
    End;
  End;

End;

function TfrmRcxConfCupomModal.fChequesCadastrados(fltValor: Double; blnPrazo: Boolean): Boolean;
  Var
    cdsTemp: TUniClientDataSet;
Begin
  fltTotal := 0.00;

  If blnPrazo Then cdsTemp := cdsChqPre Else cdsTemp := cdsChqVis;

  With cdsTemp Do
    If Assigned(cdsTemp) And (Not IsEmpty) Then
      fltTotal := TAggregateField(FieldByName('TOT_VALCHQ')).Value;

  Result := (fFormataFloat(fltValor, 2) = fFormataFloat(fltTotal, 2));
End;

{************************************}
{* EFETUA IMPRESSAO DO CUPOM FISCAL *}
{*********************************MA*}
function TfrmRcxConfCupomModal.fImprimeCupom( strSeqGer: String; pgbStatus: TcxProgressBar ): Boolean;
  Var
    strSQL     : String;
    ecfFiscal  : TUntFiscal;
    strCodErr  : String;
    strModDin  : String;
    strObserv  : String;
    strImpPag  : String;

    strNumeroSer: String;
    strNumeroCoo: String;

    qryGenDet : TUniQuery;

    blnImpPag: Boolean;
    impressorCupom: TImpressorCupomVelho;
    strBarCon : String;
    objCarnePagto : TCarnePagamento;
Begin

  blnImpPag := ((fltImpPag <> 0.00) And (fltPeImPg <> 0.00)) Or
               ((fltFedImp <> 0.00) And (fltPeImFd <> 0.00)) Or
               ((fltEstImp <> 0.00) And (fltPeImEs <> 0.00)) Or
               ((fltMunImp <> 0.00) And (fltPeImMn <> 0.00));

  If Not SameText(strCGCCPF,mskCgcCpf.Text) Then
    strCGCCPF := mskCgcCpf.Text;

  qryGenDet := fCriaQuery(Self);

  ecfFiscal := TUntFiscal.Create;

  ecfFiscal.strNumDoc := strNumDoc;
  ecfFiscal.strCodCli := strCodCli;
  ecfFiscal.strNomCli := strNomCli;
  ecfFiscal.strEndCli := strEndCli;
  ecfFiscal.strBaiCli := strBaiCli;
  ecfFiscal.strCepCli := strCepCli;
  ecfFiscal.strCidCli := strCidCli;
  ecfFiscal.strEstCli := strEstCli;
  ecfFiscal.strCgcCpf := strCgcCpf;
  ecfFiscal.strIesCli := strIesCli;
  ecfFiscal.strRG_Cli := strRG_Cli;
  ecfFiscal.strCodVen := strCodVen;
  ecfFiscal.strNomVen := strNomVen;

  If Not ecfFiscal.pSetModEcf( strModEcf ) Then
  Begin
    fMensagem('ATENÇÃO!', 'Não foi possivel setar o Modelo da Impressora. Verifique o Modelo Configurado!', ['&Ok']);
    Result := False;
    Exit;
  End;

  If Not ecfFiscal.fIniciaEcf( strCodErr, strPatIni, strPorta ) Then
  Begin
    fMensagem('ATENÇÃO!', ecfFiscal.fRetMensErro( strCodErr ), ['&Ok']);
    Result := False;
    Exit;
  End;

  If Not ecfFiscal.fRetImpLigada( strCodErr ) Then
  Begin
    fMensagem('ATENÇÃO!', ecfFiscal.fRetMensErro( strCodErr ), ['&Ok']);
    Result := False;
    Exit;
  End;
  
  //If Not ecfFiscal.fRetAliquotas( strCodErr, strAliquo ) Then
  //Begin
  //  fMensagem('ATENÇÃO!', ecfFiscal.fRetMensErro( strCodErr ), ['&Ok']);
  //  Exit;
  //End;
//  fltDesEsp := 0.00;

  strModDin := '01';
  strObserv := fPadr( '', 40 );

  Try

    With qryGenDet Do
    Begin

      {*****************************************}
      {* PEGA CUPOM DA VENDA                   *}
      {**************************************MA*}
      strSQL := '';
      strSQL := strSQL + ' SELECT ';
      strSQL := strSQL + '   DET_CODITE, ';
      strSQL := strSQL + '   CONCAT(IF(DET_IDEPRO <> "NOR", CONCAT(DET_IDEPRO, " - "), ""), DET_DESCRI) AS DET_DESCRI, ';
      strSQL := strSQL + '   DET_UNIDAD, ';
      strSQL := strSQL + '   DET_QTDITE, ';
      strSQL := strSQL + '   DET_UNITAR, ';
      strSQL := strSQL + '   DET_PREEMB, ';
      strSQL := strSQL + '   DET_PROEMB, ';
      strSQL := strSQL + '   DET_CODFIS, ';
      strSQL := strSQL + '   DET_ALQICM, ';
      strSQL := strSQL + '   DET_DESESP, ';
      strSQL := strSQL + '   DET_IDEPRO, ';
      strSQL := strSQL + '   DET_TOTITE, ';
      strSQL := strSQL + '   AUTOINCREM, ';
      strSQL := strSQL + '   DET_SEQTIN ';
      strSQL := strSQL + ' FROM ';
      strSQL := strSQL + '   ' + strNomArq + ' ';
      strSQL := strSQL + ' WHERE ';
      strSQL := strSQL + '   DET_SEQGER = :SEQGER ';

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('SEQGER').AsString := strSeqGer;
      Open;

      ecfFiscal.fltIcmDev := fltTotIcm;
      ecfFiscal.fltImpPag := fltImpPag;
      ecfFiscal.fltPeImPg := fltPeImPg;
      ecfFiscal.fltFedImp := fltFedImp;
      ecfFiscal.fltPeImFd := fltPeImFd;
      ecfFiscal.fltEstImp := fltEstImp;
      ecfFiscal.fltPeImEs := fltPeImEs;
      ecfFiscal.fltMunImp := fltMunImp;
      ecfFiscal.fltPeImMn := fltPeImMn;

      If IsEmpty() Then
      Begin
        fMensagem('ATENÇÃO!', 'Não foi encontrado nenhum Item para Impressão do Cupom!' , ['&Ok']);
        Result := False;
        Close;
        Exit;
      End;

      {*****************************************}
      {* VERIFICA SE A VENDA POSSUE ITENS      *}
      {* COM ALIQUOTAS NAO CADASTRADAS NA      *}
      {* IMPRESSORA                            *}
      {**************************************MA*}
      {First;
      While Not Eof Do
      Begin

        strAlqIte := FloatToStrF( FieldByName( 'DET_ALQICM' ).AsFloat, ffNumber, 4, 2 );
        strAlqIte := AnsiReplaceStr( strAlqIte, '.', '' );
        strAlqIte := AnsiReplaceStr( strAlqIte, ',', '' );

        If ( Pos( strAlqIte, strAliquo ) = 0 ) Then
        Begin
          fMensagem('ATENÇÃO!', 'Existem itens com aliquotas que não estão programadas na Impressora. Verifique!' , ['&Ok']);
          Result := False;
          Close;
          Exit;
        End;

        Next;
      End;
      }

    End;

    Result := False;

    If fCupomJaImpresso(strTabelaGer, strSeqGer) Then
    Begin
      fMensagem('ATENÇÃO!', 'Cupom já foi impresso por outra estação. Por favor verifique.', ['&Ok']);
      Exit;
    End;

    Try
      //*************************************************//
      // FORMATA AS VARIAVEIS STRCGCCPF E IESCLI         //
      //**********************************************ED*//
      strCGCCPF := fFormataCpfCgc(strCGCCPF, FPais);
      If Pos('/', strCGCCPF) > 0 Then
      Begin
        strCGCCPF := 'CNPJ: ' + strCGCCPF;
        strIESCli := 'IES.: ' + strIESCli;
      End
      Else
      Begin
        strCGCCPF := 'CPF: ' + strCGCCPF;
        strIESCli := 'RG.: ' + strRG_Cli;
      End;

      If Pos('-', strCepCli) = 0 Then
        strCepCli := FormatMaskText('99999-999;0;_', strCepCli);

      {*****************************************}
      {* MENSAGENS DA IMPRESSORA               *}
      {**************************************MA*}
      If Pos( ecfFiscal.fGetModEcf, 'SWEDA-9000' ) > 0 Then
      Begin

        strObserv := '';

        If blnImpPag Then
        Begin
          If Not fUsaImpostoFonteIBPT Then
          Begin
            If fltImpPag < 1000 Then
              strObserv := strObserv + '0' + fPadR('Vlr.Apr.Trib R$' + FormatFloat('#,##0.00', fltImpPag) +
                                                   '(' + FormatFloat('#,##0.00', fltPeImPg) + '%)', 40)
            Else
              strObserv := strObserv + '0' + fPadR('Vlr.Ap.Trib R$' + FormatFloat('#,##0.00', fltImpPag) +
                                                   '(' + FormatFloat('#,##0.00', fltPeImPg) + '%)', 40);
          End
          Else
          Begin
            strImpPag := '';
            strImpPag := strImpPag + VAL_APR_IBPT;

            If (fltFedImp <> 0.00) Then
              strImpPag := strImpPag + FormatFloat('#,##0.00', fltFedImp) + FEDERAL;

            If (fltEstImp <> 0.00) Then
              strImpPag := strImpPag + '/' + FormatFloat('#,##0.00', fltEstImp) + ESTADUAL;

            If (fltMunImp <> 0.00) Then
              strImpPag := strImpPag + '/' + FormatFloat('#,##0.00', fltMunImp) + MUNICIPAL;

            strImpPag := strImpPag + FONTE_IBPT;
            strObserv := strObserv + '0' + Copy(fPadR(strImpPag, 40), 1, 40);
          End;
        End;

        strObserv := strObserv + '0' + fPadR( fRetDocMaisTelParaIF(strNumDoc, strFone01, 40), 40 );
        strObserv := strObserv + '0' + fPadR( LeftStr( strNomCli, 31 ) + '-' + strCodCli, 40 );
        strObserv := strObserv + '0' + fPadR( strEndCli + ' - ' + strBaiCli, 40 );

        If Not blnImpPag Then
          strObserv := strObserv + '0' + fPadR( strCepCli + ' - ' + strCidCli + '-' + strEstCli, 40 );

        strObserv := strObserv + '0' + fPadR( strCGCCPF + ' - ' + strIESCli, 40 );
        strObserv := strObserv + '0' + fPadR( 'Vendedor: ' + strNomVen, 40 );

        If (fCadEmp('ESTADO') = 'MG') And
           (fCfgSis('MINLEG', varBoolean)) Then
          strObserv := strObserv + fPadR( 'MINAS LEGAL', 40)
        Else
        If fCfgSis('CUPMAN', varBoolean) Then
        Begin
          strObserv := strObserv + '0' + fPadR( 'VALIDO PARA O CUPOM MANIA', 40 );
          strObserv := strObserv + '0' + fPadR( 'ICMS DEVIDO: ' + FormatFloat('#0.00', ecfFiscal.fltIcmDev), 40 );
        End;
          
      End
      Else If Pos( ecfFiscal.fGetModEcf, 'SWEDA-7000' ) > 0 Then
      Begin
        strObserv := '';

        If blnImpPag Then
        Begin
          If Not fUsaImpostoFonteIBPT Then
          Begin
            If fltImpPag < 1000 Then
              strObserv := strObserv + '0' + fPadR(strMsgArreTribu40 + FormatFloat('#,##0.00', fltImpPag) +
                                                   '(' + FormatFloat('#,##0.00', fltPeImPg) + '%)', 40)
            Else
              strObserv := strObserv + '0' + fPadR(strMsgArreTribuRedz40 + FormatFloat('#,##0.00', fltImpPag) +
                                                   '(' + FormatFloat('#,##0.00', fltPeImPg) + '%)', 40);
          End
          Else
          Begin
            strImpPag := '';
            strImpPag := strImpPag + VAL_APR_IBPT;

            If (fltFedImp <> 0.00) Then
              strImpPag := strImpPag + FormatFloat('#,##0.00', fltFedImp) + FEDERAL;

            If (fltEstImp <> 0.00) Then
              strImpPag := strImpPag + '/' + FormatFloat('#,##0.00', fltEstImp) + ESTADUAL;

            If (fltMunImp <> 0.00) Then
              strImpPag := strImpPag + '/' + FormatFloat('#,##0.00', fltMunImp) + MUNICIPAL;

            strImpPag := strImpPag + FONTE_IBPT;
            strObserv := strObserv + '0' + Copy(fPadR(strImpPag, 40), 1, 40);
          End;
        End;

        strObserv := strObserv + '0' + fPadR( fRetDocMaisTelParaIF(strNumDoc, strFone01, 40), 40 );
        strObserv := strObserv + '0' + fPadR( LeftStr( strNomCli, 31 ) + '-' + strCodCli, 40 );
        strObserv := strObserv + '0' + fPadR( strEndCli + ' - ' + strBaiCli, 40 );

        If Not blnImpPag Then
          strObserv := strObserv + '0' + fPadR( strCepCli + ' - ' + strCidCli + '-' + strEstCli, 40 );
          
        strObserv := strObserv + '0' + fPadR( strCGCCPF + ' - ' + strIESCli, 40 );
        strObserv := strObserv + '0' + fPadR( 'Vendedor: ' + strNomVen, 40 );

        If fCfgSis('SIMNAC', varBoolean) Then
          strObserv := strObserv + '0' + fPadR( 'ICMS A SER REC. CONF. LC 123/2006 - SIMPLES NAC', 40 );

        If (fCadEmp('ESTADO') = 'MG') And
           (fCfgSis('MINLEG', varBoolean)) Then
          strObserv := strObserv + fPadR( 'MINAS LEGAL', 40)
        Else
        If fCfgSis('CUPMAN', varBoolean) Then
          strObserv := strObserv + '0' + fPadR( 'VALIDO P/CUPOM MANIA.ICMS DEV: ' + FormatFloat('#0.00', ecfFiscal.fltIcmDev), 40 );

      End
      Else
      Begin
        strObserv := '';

        If blnImpPag Then
        Begin
          If Not fUsaImpostoFonteIBPT Then
          Begin
            If fltImpPag < 1000 Then
              strObserv := strObserv + fPadR('Vlr Aprox do Tributo "R$' + FormatFloat('#,##0.00', fltImpPag) +
                                             '(' + FormatFloat('#,##0.00', fltPeImPg) + '%)', 48)
            Else
              strObserv := strObserv + fPadR('Vlr Apr Tributos "R$' + FormatFloat('#,##0.00', fltImpPag) +
                                             '(' + FormatFloat('#,##0.00', fltPeImPg) + '%)', 48);
          End
          Else
          Begin
            strImpPag := '';
            strImpPag := strImpPag + VAL_APR_IBPT;

            If (fltFedImp <> 0.00) Then
              strImpPag := strImpPag + FormatFloat('#,##0.00', fltFedImp) + FEDERAL;

            If (fltEstImp <> 0.00) Then
              strImpPag := strImpPag + '/' + FormatFloat('#,##0.00', fltEstImp) + ESTADUAL;

            If (fltMunImp <> 0.00) Then
              strImpPag := strImpPag + '/' + FormatFloat('#,##0.00', fltMunImp) + MUNICIPAL;

            strImpPag := strImpPag + FONTE_IBPT;
            strObserv := strObserv + '0' + Copy(fPadR(strImpPag, 48), 1, 48);
          End;
        End;

        strObserv := strObserv + fPadR( fRetDocMaisTelParaIF(strNumDoc, strFone01, 48), 48 );
        strObserv := strObserv + fPadR( LeftStr( strNomCli, 31 ) + '-' + strCodCli, 48 );
        strObserv := strObserv + fPadR( strEndCli + ' - ' + strBaiCli, 48 );

        If Not blnImpPag Then
          strObserv := strObserv + fPadR( strCepCli + ' - ' + strCidCli + '-' + strEstCli, 48 );
          
        strObserv := strObserv + fPadR( strCGCCPF + ' - ' + strIESCli, 48 );
        strObserv := strObserv + fPadR( 'Vendedor: ' + strNomVen, 48 );

        If fCfgSis('SIMNAC', varBoolean) Then
          strObserv := strObserv + fPadR( 'ICMS A SER REC. CONF. LC 123/2006 - SIMPLES NAC', 48 );

        If (fCadEmp('ESTADO') = 'MG') And
           (fCfgSis('MINLEG', varBoolean)) Then
          strObserv := strObserv + fPadR( 'MINAS LEGAL', 40)
        Else
        If fCfgSis('CUPMAN', varBoolean) Then
          strObserv := strObserv + fPadR( 'VALIDO PARA O CUPOM MANIA.ICMS DEVIDO: ' + FormatFloat('#0.00', ecfFiscal.fltIcmDev), 48);

      End;

      impressorCupom := TImpressorCupomVelho.Create(ecfFiscal, pImprimeModalidades, fltTotal, strObserv);
      impressorCupom.pAdicionaParametro(pgbStatus);
      Try
        impressorCupom.pImprimirCupom(strNumDoc,  'IF', VS_strCodEmp, strCodCli, strSerie);
        Result := True;
      Finally
        FreeAndNil(impressorCupom);
      End;      

      strNumeroCoo := fstrEspaco(' ', 6);;
      If (Not ecfFiscal.fRetornaCoo(strNumeroCoo, strCodErr)) Then
      Begin
        pCancelaCupomNoEcf(ecfFiscal);
        fMensagem('ATENÇÃO!', 'Retorna COO: ' + #13#10 + ecfFiscal.fRetMensErro( strCodErr ), ['&Ok']);
        Result := False;
        Exit;
      End;

      strNumeroSer := fstrEspaco(' ', 20);
      If (Not ecfFiscal.fNumeroSerie(strNumeroSer, strCodErr)) Then
      Begin
        pCancelaCupomNoEcf(ecfFiscal);
        fMensagem('ATENÇÃO!', 'Retorna Número de Série: ' + #13#10 + ecfFiscal.fRetMensErro( strCodErr ), ['&Ok']);
        Result := False;
        Exit;
      End;

      {*****************************************}
      {* MARCA COMO JA FATURADO                *}
      {**************************************NC*}
      strNumCoo := strNumeroCoo;
      strNumSer := strNumeroSer;

      pMarcaCupomImpresso(strSeqGer, strNumDoc, strEspDoc, strCodEmp, strCodCli,
                                    strSerie, strNumSer, strNumCoo, strNumCcf, strTabelaGer);

      If chkEndEnt.Checked Then
        fImprimeEnderecoEntrega(strDesMod, ecfFiscal, strNumeroCoo, qryGenDet);

      If fCfgSis('IMPGAR',varBoolean) Then
        fImprimeDadosGarantia(ecfFiscal);

      If (fCfgSis('SISCRE', VarBoolean)) And (fCfgSis('IMPCAR', VarBoolean)) And
         (fCfgSis('ESPCAR', VarString) <> '2') Then
      Begin
        strBarCon := fCampoTabela('CTR_BARCON', 'CADREC', ['CTR_NUMDUP', 'CTR_ESPDOC', 'CTR_CODEMP', 'CTR_CODCLI'], [strNumDoc, strEspDoc, strCodEmp, strCodCli]);

        If (Not fEmptyStr(strBarCon)) Then
        Begin
          objCarnePagto := TCarnePagamento.Create(nil, strBarCon);
          Try
            objCarnePagto.fImprimirContrato;
            objCarnePagto.fImprimirCarneRecibo;
          Finally
            FreeAndNil(objCarnePagto);
          End;
        End;
      End;

      {*******************************************}
      {* ABRE GAVETA                             *}
      {****************************************MV*}
      If fCfgSis('ABRGAV', varBoolean) Then
      Begin
        If (Not ecfFiscal.fAbreGaveta(strCodErr)) Then
        Begin
          fMensagem('ATENÇÃO!', ecfFiscal.fRetMensErro( strCodErr ), ['&Ok']);
          Exit;
        End;
      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message,'[fImprimeCupom]');
        Result := False;
        Exit;
      End;
    End;

  Finally
    ecfFiscal.fFinalizaEcf( strCodErr );
    ecfFiscal.Free;
    FreeAndNil(qryGenDet);
  End;

End;

function TfrmRcxConfCupomModal.fImprimeDadosGarantia(
  ecfFiscal: TUntFiscal): Boolean;
  Var
    objImpGar: TImpDadosGarantia;
begin
  objImpGar := TImpDadosGarantia.Create(Self, ecfFiscal);
  Result    := objImpGar.fImprimirGarantia(strNumDoc, 'IF', strCodEmp, strCodCli);

  FreeAndNil(objImpGar);
end;

procedure TfrmRcxConfCupomModal.pImprimeModalidades(objFiscal: TUntFiscal; arrParametros: Array Of TObject);
  Var
    intContado2:integer;
    strModDin: String;
    strVencim: String;
    strCodErr: String;
begin
  strModDin := '01';
  {*****************************************}
  {* INFORMA AS MODALIDADES DE PAGAMENTO   *}
  {**************************************MA*}
  For intContado2 := 1 To intMaxModalidades Do
  Begin

    If ( arrModalidades[ intContado2 ].edtCampo = Nil ) Then
      Break;

    If ( fStrToFloat(arrModalidades[ intContado2 ].edtCampo.Text ) > 0 ) Then
    Begin

      If arrModalidades[ intContado2 ].strIdentifMod = '01' Then
        strModDin := fStrZero( intContado2, 2 );

      strVencim := '';
      If ( arrModalidades[ intContado2 ].strInfAdi = 'S' ) Then
        strVencim := fRetVencimentos( strConPag, dtaDtaEnt );

      If Not objFiscal.fPagamento(  strCodErr,
                                    arrModalidades[ intContado2 ].strCodigoMod,
                                    arrModalidades[ intContado2 ].strModalidade,
                                    fStrToFloat( arrModalidades[ intContado2 ].edtCampo.Text ), //arrModalidades[ intContado2 ].fltValor
                                    False,
                                    strVencim ) Then
      Begin
        pCancelaCupomNoEcf(objFiscal);
        fMensagem('ATENÇÃO!', 'Formas de Pagamento: ' + #13#10 + objFiscal.fRetMensErro( strCodErr ), ['&Ok']);
        Abort;
      End;

    End;
  End;

  pStep(TcxProgressBar(arrParametros[0]));
end;


{************************************}
{* MONTA OS VENCIMENTOS             *}
{*********************************MA*}
function TfrmRcxConfCupomModal.fRetVencimentos( strConPag: String; dtaDtaEnt: TDateTime ): String;
Var
  intQtdPar: Integer;
  intQtdDia: Integer;
  intContador: Integer;
  strPar001 : String;
  strPar002 : String;
Begin

  Result := '';

  strPar001 := 'Vencimento: ';
  strPar002 := '   ';

  strConPag := Trim( strConPag );
  intQtdPar := StrToInt( LeftStr( strConPag, 2 ) );

  If intQtdPar > 7 Then    //Permite apenas 7 parcelas
    intQtdPar := 7;

  For intContador := 1 to intQtdPar Do
  Begin

    intQtdDia := StrToInt( Copy( strConPag, ( intContador * 3 ), 3 ) );

    If intQtdDia <= 0 Then
      Continue;

    If Length( strPar001 + FormatDateTime( 'dd/mm/yy', dtaDtaEnt + intQtdDia ) + ' ' ) > 48 Then
      strPar002 := strPar002 + FormatDateTime( 'dd/mm/yy', dtaDtaEnt + intQtdDia ) + ' '
    Else
      strPar001 := strPar001 + FormatDateTime( 'dd/mm/yy', dtaDtaEnt + intQtdDia ) + ' '

  End;

  Result := fPadr( strPar001, 48 ) + fPadr( strPar002, 32 );

  If Length( strPar001 ) = 12 Then
    Result := '';

End;

procedure TfrmRcxConfCupomModal.FormCreate(Sender: TObject);
begin
  inherited;
  strCodOpe := '';
  strPatIni := fCfgSis('DIRINI');
  strCodEcf := fArqIniLocal(0, 'IMPRESSORA_FISCAL', 'IMPRESSORA'   , '', strPatIni + '/opcoes_fiscal.ini' );
  strModEcf := fArqIniLocal(0, 'IMPRESSORA_FISCAL', 'MODELO'       , '', strPatIni + '/opcoes_fiscal.ini' );
  strPorta  := fArqIniLocal(0, 'IMPRESSORA_FISCAL', 'PORTA'        , '', strPatIni + '/opcoes_fiscal.ini' );

  FPais := fSetaPais;

  //fltTotal     := 0;

  //fltDinheiro  := 0;
  fltCartao    := 0;
  fltChequeVis := 0;
  fltChequePre := 0;
  fltFaturado  := 0;
  fltOutros    := 0;

  strCOdigoCaixa := '';

  If fEmptyStr( strCodEcf ) Then
  Begin
    fMensagem('ATENÇÃO!', 'A impressora fiscal que será utilizada não foi setada nas Configurações do Sistema. Verifique!', ['&Ok']);
    frmRcxConfCupomModal.Close;
    Exit;
  End;

  If Not fCarregaModalidades Then
  Begin
    fMensagem('ATENÇÃO!', 'Não há nenhuma modalidade cadastrada para a Impressora Configurada. Verifique!', ['&Ok']);
    frmRcxConfCupomModal.Close;
    Exit;
  End;

end;

procedure TfrmRcxConfCupomModal.pSetaModalidade(strCodMod: String;
  fltValor: Double);
  Var
    intContador: Integer;
    blnAchou: Boolean;
begin

  blnAchou := False;
  For intContador := Low(arrModalidades) To High(arrModalidades) Do
  Begin

    If arrModalidades[intContador].strIdentifMod = strCodMod Then
    Begin
      arrModalidades[intContador].edtCampo.Text := FloatToStr(fltValor);
      blnAchou := True;
      Break;
    End;

  End;

  If (strCodMod <> '1') And (Not blnAchou) Then
  Begin
    pSetaModalidade('1', fltValor);
  End;

end;

Function TfrmRcxConfCupomModal.fTemModalidadeVinculado: Boolean;
  Var
    intContador: Integer;
begin
  Result := False;

  For intContador := Low(arrModalidades) To High(arrModalidades) Do
    If (fStrToFloat(arrModalidades[intContador].edtCampo.Text) > 0) And
       (arrModalidades[intContador].strIdentifMod <> '01') And
       (arrModalidades[intContador].strIdentifMod <> '1') Then
    Begin
      strDesMod := arrModalidades[intContador].strModalidade;
      Result := True;
      Exit;
    End;
end;

Procedure TfrmRcxConfCupomModal.pMensagemVinculado(ecfFiscal: TUntFiscal; strMensagem: String);
  Var
    stlMensagem: TStringList;
    intContador: Integer;
    strCodErr: String;
Begin
  stlMensagem := TStringList.Create;
  stlMensagem.Text := strMensagem;

  If Not fEmptyStr(strMensagem) Then
  Begin
    ecfFiscal.fUsaCupomVinculado(strCodErr, fPadR( '', 48));
    For intContador := 0 To stlMensagem.Count - 1 Do
      ecfFiscal.fUsaCupomVinculado(strCodErr,fPadR( stlMensagem[intContador], 48 ));
  End;

  FreeAndNil(stlMensagem);
End;

Function TfrmRcxConfCupomModal.fImprimeEnderecoEntrega(strDesMod: String;
  ecfFiscal: TUntFiscal; strNumCOO: String; qryItens: TUniQuery): Boolean;
  Var
    strCodErr: String;
    intContador: Integer;
    strLinItem: String;
    
    strDescri,
    strQtdIte,
    strUnitar: String;

    fltDesEsp: Double;
    fltTotPro: Double;

    stlMen001: TStringList;
    stlMen002: TStringList;

    arrDuplicata: TarrDuplicata;
Begin
  Result := FALSE;
  pZeraDigDuplic(arrDuplicata);

  If Not ecfFiscal.fAbreCupomVinculado(strCodErr, strDesMod, 0, '') Then
    Exit;

  stlMen001 := TStringList.Create;
  stlMen002 := TStringList.Create;

  If Not fEmptyStr(strMen001) Then
    stlMen001.Text := WrapText(strMen001, 45);

  If Not fEmptyStr(strMen002) Then
    stlMen002.Text := WrapText(strMen002, 45);

  If Pos('-', strCepEnt) = 0 Then
    strCepEnt := FormatMaskText('99999-999;0;_', strCepEnt);

  ecfFiscal.fUsaCupomVinculado(strCodErr, fPadR('', 48, '-'));

  If fCfgSis('IMPCAC', varBoolean) Then
    ecfFiscal.fUsaCupomVinculado(strCodErr, fPadC('Cupom Fiscal: ' + strNumDoc + '-IF',48))
  Else
    ecfFiscal.fUsaCupomVinculado(strCodErr, fPadC('COO Cupom Fiscal: ' + strNumCOO, 48));
  
  ecfFiscal.fUsaCupomVinculado(strCodErr,fPadC('DADOS DO CLIENTE',48));

  ecfFiscal.fUsaCupomVinculado(strCodErr, fPadR( LeftStr( strNomCli, 31 ) + '-' + strCodCli, 48 ));
  ecfFiscal.fUsaCupomVinculado(strCodErr, fPadR( strEndCli + ' - ' + strBaiCli, 48 ));
  ecfFiscal.fUsaCupomVinculado(strCodErr, fPadR('CEP: ' +  strCepCli + ' - ' + strCidCli + '-' + strEstCli, 48 ));
  ecfFiscal.fUsaCupomVinculado(strCodErr, fPadR( strCGCCPF + ' - ' + strIESCli, 48 ));

  ecfFiscal.fUsaCupomVinculado(strCodErr, fPadR('', 48, '-'));
  ecfFiscal.fUsaCupomVinculado(strCodErr, fPadC('ENDERECO DE ENTREGA',48));

  If fEmptyStr(strEndEnt) Then
  Begin
    ecfFiscal.fUsaCupomVinculado(strCodErr, fPadR( strEndCli + ' - ' + strBaiCli, 48 ));
    ecfFiscal.fUsaCupomVinculado(strCodErr, fPadR('CEP: ' + strCepCli + ' - ' + strCidCli + '-' + strEstCli, 48 ));
  End Else
  Begin
    ecfFiscal.fUsaCupomVinculado(strCodErr, fPadR( strEndEnt + ' - ' + strBaiEnt, 48 ));
    ecfFiscal.fUsaCupomVinculado(strCodErr, fPadR('CEP: ' + strCepEnt + ' - ' + strCidEnt + '-' + strEstEnt, 48 ));
  End;

  If fCfgSis('IMPDCE', varBoolean) Then
  Begin
    ecfFiscal.fUsaCupomVinculado(strCodErr, fPadR('', 48, '-'));
    ecfFiscal.fUsaCupomVinculado(strCodErr, fPadC('ITENS DO CUPOM',48));
    ecfFiscal.fUsaCupomVinculado(strCodErr, fPadR('ITEM CÓDIGO DESCRIÇÃO QTD.UN.UNIT(R$)  TOTAL(R$)', 48));
    ecfFiscal.fUsaCupomVinculado(strCodErr, fPadR('', 48, '-'));

    With qryItens Do
    Begin
      intContador := 0;

      fltDesEsp   := 0;
      fltTotPro   := 0;

      Open;
      First;

      While Not Eof Do
      Begin
        Inc(intContador);

        strDescri := fPadR(FieldByName('DET_DESCRI').AsString, 38);
        strQtdIte := fFloatToStrVirgula(FieldByName('DET_QTDITE').AsFloat, 6, 2);
        strUnitar := fFloatToStrVirgula(IIF(FieldByName('DET_PROEMB').AsString = 'S',
                                            FieldByName('DET_PREEMB').AsFloat / FieldByName('DET_QTDITE').AsFloat,
                                            FieldByName('DET_UNITAR').AsFloat), 7, 3);


        strLinItem := '';
        strLinItem := strLinItem + fStrZero(intContador, 3) + ' ';
        strLinItem := strLinItem + FieldByName('DET_CODITE').AsString + ' ';
        strLinItem := strLinItem + strDescri;

        ecfFiscal.fUsaCupomVinculado(strCodErr, fPadR( strLinItem, 48 ));

        strLinItem := fPadR('', 13);
        strLinItem := strLinItem + fPadL(strQtdIte, 08);
        strLinItem := strLinItem + fRetSiglaUnidadeIF(FieldByName('DET_UNIDAD').AsString) + ' x ';
        strLinItem := strLinItem + fPadR(strUnitar, 11);
        strLinItem := strLinItem + fPadL(fFloatToStrVirgula(FieldByName('DET_TOTITE').AsFloat, 8, 2), 11);

        ecfFiscal.fUsaCupomVinculado(strCodErr, fPadR( strLinItem, 48 ));

        fltDesEsp := fltDesEsp + FieldByName('DET_DESESP').AsFloat;
        fltTotPro := fltTotPro + FieldByName('DET_TOTITE').AsFloat;

        Next;
      End;

      Close;

      If fltDesEsp > 0 Then
      Begin
        ecfFiscal.fUsaCupomVinculado(strCodErr, fPadR( 'Subtotal R$' + fPadL(fFloatToStrVirgula(fltTotPro, 8, 2), 37), 48 ));
        ecfFiscal.fUsaCupomVinculado(strCodErr, fPadR( 'Desconto   ' + fPadL(fFloatToStrVirgula(-fltDesEsp, 8, 2), 37), 48 ));
      End;

      ecfFiscal.fUsaCupomVinculado(strCodErr, fPadR( 'Total R$   ' + fPadL(fFloatToStrVirgula(fltTotal, 8, 2), 37), 48 ));

      For intContador := 1 To intMaxModalidades Do
      Begin

        If ( arrModalidades[ intContador ].edtCampo = Nil ) Then
          Break;

        If ( fStrToFloat( arrModalidades[ intContador ].edtCampo.Text ) > 0 ) Then
        Begin

          strLinItem := fPadR(Trim(arrModalidades[ intContador ].strModalidade), 30);
          strLinItem := strLinItem + fPadL(fFloatToStrVirgula(fStrToFloat( arrModalidades[ intContador ].edtCampo.Text ), 8, 2), 18);

          ecfFiscal.fUsaCupomVinculado(strCodErr, fPadR( strLinItem, 48 ));

        End;

      End;

    End;

  End;

  ecfFiscal.fUsaCupomVinculado(strCodErr, fPadR('', 48, '-'));

  ecfFiscal.fUsaCupomVinculado(strCodErr, fPadC('CONDICAO DE PAGAMENTO',48));
  ecfFiscal.fUsaCupomVinculado(strCodErr, fPadR('VENCIMENTO VALOR DA PARCELA', 48 ));

  fDigDuplic(arrDuplicata, strConPag, 0, fltTotal, False, False, False, VS_Date, False);

  For intContador := 0 to 23 Do
    arrDuplicata[intContador].curValor := arrDuplicOri[intContador].curValor;

  For intContador := 0 to 23 Do
    With arrDuplicata[intContador] Do
    If curValor > 0 Then
      ecfFiscal.fUsaCupomVinculado(strCodErr, fPadR(dtaDtaVen + '  ' + FloatToStrF( curValor, ffFixed, 12, 2 ), 48 ))
    Else
      Break;

  If (fStatusCndPag(strConPag) <> A_VISTA) Then
    pMensagemVinculado(ecfFiscal, fCfgSis('MPRAF8'))
  Else
    pMensagemVinculado(ecfFiscal, fCfgSis('MVISF8'));
  
  If (stlMen001.Count > 0) Or (stlMen002.Count > 0) Then
  Begin
    ecfFiscal.fUsaCupomVinculado(strCodErr, fPadR( '', 48 ));

    For intContador := 0 To stlMen001.Count -1 Do
    Begin
      ecfFiscal.fUsaCupomVinculado(strCodErr, fPadR( stlMen001[intContador], 48 ));
    End;

    For intContador := 0 To stlMen002.Count -1 Do
    Begin
      ecfFiscal.fUsaCupomVinculado(strCodErr, fPadR( stlMen002[intContador], 48 ));
    End;
  End;

  ecfFiscal.fUsaCupomVinculado(strCodErr, fPadR( '', 48 ));
  ecfFiscal.fUsaCupomVinculado(strCodErr, fPadR( '', 48 ));
  ecfFiscal.fUsaCupomVinculado(strCodErr, fPadR( '', 48 ));
  ecfFiscal.fUsaCupomVinculado(strCodErr, fPadC( '____________________________________', 48 ));
  ecfFiscal.fUsaCupomVinculado(strCodErr, fPadC( 'Assinatura', 48 ));

  If Not ecfFiscal.fFechaCupomVinculado(strCodErr) Then
    Exit;

  Result := TRUE;
End;

function TfrmRcxConfCupomModal.fLogChq(cdsLog: TUniClientDataSet; intOpcao: Integer): Boolean;
  Var
    repCadChq: TCadChqRepository;
begin

  Try
    Result := True;

    repCadChq := TCadChqRepository.Create;
    With cdsLog Do
    Begin
      repCadChq.pGravaLog(FieldByName('CHQ_CODBCO').AsString, FieldByName('CHQ_NUMAGE').AsString,
                          FieldByName('CHQ_CONCOR').AsString, FieldByName('CHQ_NUMCHQ').AsString,
                          'INSERINDO CHQ. '+ IIF(intOpcao = 1,'PRE. ', 'VIS. ') + '(frmRcxConfCupomModal.fLogChq)');
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '');
    End;
  End;
  FreeAndNil(repCadChq);

end;

procedure TfrmRcxConfCupomModal.pPosicionaModalidadeDefault(
  strCodFpg: String);
  Var
    intContador: Integer;
    strIdenti: String;
    edtModalidade: TEdit;
begin

  If (strcodfpg = '009') Then
    Exit;

  strIdenti := fCampoTabela('ECF_CODMOD', 'FPGECF', ['FPG_CODIGO','ECF_CODECF'], [strCodFpg, strCodEcf], False);

  If fEmptyStr(strIdenti) Then
  Begin
    fMensagem('ATENÇÃO!', 'Forma de pagamento não configurada. Favor verificar.', ['&Ok']);
    Exit;
  End;

  edtModalidade := Nil;
  For intContador := Low(arrModalidades) To High(arrModalidades) Do
  Begin

    If fStrZero(arrModalidades[intContador].strCodigoMod, 2) = strIdenti Then
    Begin
      edtModalidade := arrModalidades[intContador].edtCampo;
      arrModalidades[intContador].fltValor := fltTotal;
      edtModalidade.Text := FloatToStrF(fltTotal, ffNumber, 12, 2);
    End
    Else
    Begin
      arrModalidades[intContador].fltValor := 0;
      arrModalidades[intContador].edtCampo.Text := FloatToStrF(0, ffNumber, 12, 2);
    End;

  End;

  If (Not Assigned(edtModalidade)) Then
  Begin
    fMensagem('ATENÇÃO!', 'Forma de pagamento não configurada. Favor verificar.', ['&Ok']);
    arrModalidades[1].fltValor := fltTotal;
    arrModalidades[1].edtCampo.Text := FloatToStrF(fltTotal, ffNumber, 12, 2);
  End
  Else
    pSetFocus(edtModalidade);
end;

procedure TfrmRcxConfCupomModal.pCancelaCupomNoEcf(ecfFiscal: TUntFiscal);
  Var
    strCodErr: String;
begin
  While (Not ecfFiscal.fRetImpLigada(strCodErr)) Do
  Begin
    fMensagem('ATENÇÃO', 'A impressora está desligada. Favor ligá-la.', ['&Ok']);
    Application.ProcessMessages;
  End;
  
  ecfFiscal.fCancelaCupom(strCodErr);
end;


end.
