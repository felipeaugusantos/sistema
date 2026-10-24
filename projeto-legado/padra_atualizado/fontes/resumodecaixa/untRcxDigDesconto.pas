unit untRcxDigDesconto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, ComCtrls, StdCtrls, Buttons, ExtCtrls, EditFocus,
  Menus, AppEvnts, UniClientDataSet, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, untLiberacao,
  untMsgLiberacao; //MF: 285995 - 30/05/2023

type
  TfrmRcxDigDesconto = class(TfrmPaiSimples)
    pnlGeral: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edtTotGer: TEditFocus;
    edtPerDes: TEditFocus;
    edtTotDes: TEditFocus;
    edtDesEsp: TEditFocus;
    edtTotLiq: TEditFocus;
    lblMotivo: TLabel;
    edtMotivo: TEditFocus;
    btnConfirmaDados: TBitBtnLocked;
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtPerDesChange(Sender: TObject);
    procedure edtMotivoExit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    objLiberacao : TLiberacao;
    { Private declarations }
    function fVerificaPerDes(fltPerDes: Double): Boolean;
    function fVerificaDescontoMaximo: Boolean;

    procedure pAbateDesconto(fltAbaDes: Double);
    procedure pMontaMensagemLib(strDuplicata: String; fltValOri, fltDescon,
      fltPerDes, fltValRec: Double; strCodCli, sMsgTitulo: String; objTabela: TRegistroMsgLiberaTabela; cdsTmp: TUniClientDataSet);
    function fVerificaDescontoFaturaVencida: Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    intQtdSel: Integer;
    strCodOpe: String;
    blnTemParCre: Boolean;
    blnConfirma: Boolean;
    cdsDados: TUniClientDataSet;
    blnBolAdt : Boolean;
    blnTemDupVen : Boolean;//MF: 285995 - 30/05/2023
  end;


implementation

uses untfuncoesSimples, untPai, DB, untFuncFat, untTypesSistema,
  untFuncoesGenerica, untConstantes;

{$R *.dfm}

{ TfrmRcxDigDesconto }

function TfrmRcxDigDesconto.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (Sender = edtPerDes) Then
  Begin

    If (fEmptyStr(edtPerDes.Text)) Then
    Begin
      edtPerDes.Text := '0,00';
    End;

    If (fStrToFloat(edtPerDes.Text) < 0) Then
    Begin
      edtPerDes.Text := '0,00';
    End;

    Result := fVerificaPerDes(fStrToFloat(edtPerDes.Text));

    If Result And blnBolAdt And (fStrToFloat(edtPerDes.Text) > 0) Then
    Begin
      fMensagem('ATENÇÃO!','Não é permitido dar desconto para duplicatas de espécie PD cujos boletos foram emitidos!', ['&Ok']);
      Result := False;
    End;


  End

  Else If (Sender = edtDesEsp) Then
  Begin

    If (fEmptyStr(edtDesEsp.Text)) Then
    Begin
      edtDesEsp.Text := '0,00';
    End

    Else If (fStrToFloat(edtDesEsp.Text) < 0) Then
    Begin
      edtDesEsp.Text := '0,00';
    End

    Else If (fStrToFloat(edtDesEsp.Text) >= fStrToFloat(edtTotDes.Text)) Then
    Begin
      fMensagem('ATENÇÃO', 'O desconto especial deve ser menor que o valor total!', ['&Ok']);
      Result := False;
    End

    Else If (fStrToFloat(edtPerDes.Text) > 0.0) Or (fStrToFloat(edtDesEsp.Text) > 0.0) Then
    Begin

      If (blnTemParCre) Then
      Begin
        fMensagem('ATENÇÃO!', 'Não é possível dar desconto para duplicatas parcialmente' + #13#10 +
                              'ou para duplicatas de crédito!', ['&Ok']);
        Result := False;
      End;

    End;

    If Result And blnBolAdt And (fStrToFloat(edtDesEsp.Text) > 0)  Then
    Begin
      fMensagem('ATENÇÃO!','Não é permitido dar desconto para duplicatas de espécie PD cujos boletos foram emitidos!', ['&Ok']);
      Result := False;
    End;


    If (Result) Then
    Begin
      edtTotLiq.Text := FloatToStrF(fStrToFloat(edtTotDes.Text) - fStrToFloat(edtDesEsp.Text), ffFixed, 12, 2)
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

function TfrmRcxDigDesconto.fVerificaPerDes(fltPerDes: Double): Boolean;
  Var
    fltTotGer: Double;
begin

  fltTotGer := fStrToFloat(edtTotGer.Text);
  If (fltPerDes <= 0) Then
  Begin
    edtTotDes.Text := FloatToStrF(fltTotGer, ffFixed, 12, 2);
    Result := True;
    Exit;
  End;

  fltTotGer := fltTotGer - fFormataFloat(fltTotGer * (fltPerDes / 100), 2);
  edtTotDes.Text := FloatToStrF(fltTotGer, ffFixed, 12, 2);

  Result := True;
end;

//MF: 285995 - 30/05/2023 - retirei a pMontaMensagem para fora da função fVerificaDescontoMaximo para poder ser consumida compartilhadamente
procedure TfrmRcxDigDesconto.pMontaMensagemLib(strDuplicata : String; fltValOri, fltDescon,
fltPerDes, fltValRec : Double; strCodCli, sMsgTitulo : String; objTabela: TRegistroMsgLiberaTabela; cdsTmp: TUniClientDataSet);
var
  objLinha: TLinhaMsgLibera;
Begin
  if objLiberacao.objMsgLibera.isEmpty then
  begin
    objLiberacao.objMsgLibera.pAddTexto(sMsgTitulo);
    objLiberacao.objMsgLibera.pAddTextoCaption('Duplicata'               , strDuplicata                                                                                 , 25);
    objLiberacao.objMsgLibera.pAddTextoCaption('Valor original'          , FormatFloat('#,##0.00', fltValOri)                                                           , 25);
    objLiberacao.objMsgLibera.pAddTextoCaption('Valor desconto concedido', FormatFloat('#,##0.00', fltDescon)                                                           , 25);
    objLiberacao.objMsgLibera.pAddTextoCaption('% Desconto concedido'    , FormatFloat('0.00'    , fltPerDes) + '%'                                                     , 25);
    objLiberacao.objMsgLibera.pAddTextoCaption('Valor recebido'          , FormatFloat('#,##0.00', fltValRec)                                                           , 25);
    objLiberacao.objMsgLibera.pAddTextoCaption('Cliente'                 , strCodCli + ' - ' + fRetNomCliente(strCodCli)                                                , 25);
    objLiberacao.objMsgLibera.pAddTextoCaption('CPF/CNPJ'                , fFormataCpfCgc(fCampoTabela('CLI_C_G_C_', 'CADCLI', ['CLI_CODCLI'], [strCodCli]), fSetaPais) , 25);
  end
  else
  begin
    (objLiberacao.objMsgLibera.lstRegistros[1] as TRegistroMsgLiberaTextoCaption).strTexto := 'MAIS DE UMA DUPLICATA'                 ;
    (objLiberacao.objMsgLibera.lstRegistros[2] as TRegistroMsgLiberaTextoCaption).strTexto := FormatFloat('#,##0.00', fltValOri)      ;
    (objLiberacao.objMsgLibera.lstRegistros[3] as TRegistroMsgLiberaTextoCaption).strTexto := FormatFloat('#,##0.00', fltDescon)      ;
    (objLiberacao.objMsgLibera.lstRegistros[4] as TRegistroMsgLiberaTextoCaption).strTexto := FormatFloat('0.00'    , fltPerDes) + '%';
    (objLiberacao.objMsgLibera.lstRegistros[5] as TRegistroMsgLiberaTextoCaption).strTexto := FormatFloat('#,##0.00', fltValRec)      ;

    if Copy((objLiberacao.objMsgLibera.lstRegistros[6] as TRegistroMsgLiberaTextoCaption).strTexto,1,8) <> strCodCli then
    begin
      (objLiberacao.objMsgLibera.lstRegistros[6] as TRegistroMsgLiberaTextoCaption).strTexto   := 'MAIS DE UM CLIENTE';
      (objLiberacao.objMsgLibera.lstRegistros[7] as TRegistroMsgLiberaTextoCaption).strCaption := '';
      (objLiberacao.objMsgLibera.lstRegistros[7] as TRegistroMsgLiberaTextoCaption).strTexto   := '';
    end;
  end;


  if objTabela.isEmpty Then
  Begin

    objLinha  := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlCabecalho;
    objLinha.pAddColuna(''  , 'DOCUMENTO'       , 17 , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'EMP'             , 4  , alCentro   , teAutcom);
    objLinha.pAddColuna(''  , 'CLIENTE'         , 42 , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'DT.VENC.'        , 8  , alCentro   , teAutcom);
    objLinha.pAddColuna(''  , 'DT.CAD.'         , 8  , alCentro   , teAutcom);
    objLinha.pAddColuna(''  , 'VR.DUPLICATA'    , 13 , alDireita  , teAutcom);
    objLinha.pAddColuna(''  , 'VR.CORRIGIDO(*)' , 16 , alDireita  , teAutcom);
    objLinha.pAddColuna(''  , 'NOSSO NUMERO'    , 12 , alDireita  , teAutcom);
    objLinha.pAddColuna(''  , 'BCO'             , 3  , alDireita  , teAutcom);
    objTabela.lstLinhas.Add(objLinha);

  End;


  objLinha  := TLinhaMsgLibera.Create;
  objLinha.enuTipoLinha := tlValor;
  objLinha.pAddColuna('DOCUMENTO'       ,  fPadR(cdsTmp.FieldByName('CTR_NUMDUP').AsString,12)
                                         + cdsTmp.FieldByName('CTR_PARCEL').AsString + '-'
                                         + cdsTmp.FieldByName('CTR_ESPDOC').AsString                              , 17 , alEsquerda );
  objLinha.pAddColuna('EMP'             ,  cdsTmp.FieldByName('CTR_CODEMP').AsString                              , 4  , alCentro   );
  objLinha.pAddColuna('CLIENTE'         ,  cdsTmp.FieldByName('CTR_NOMCLI').AsString                              , 42 , alEsquerda );
  objLinha.pAddColuna('DT.VENC.'        ,  FormatDateTime('dd/mm/yy',cdsTmp.FieldByName('CTR_DTAVEN').AsDateTime) , 8  , alCentro   );
  objLinha.pAddColuna('DT.CAD.'         ,  FormatDateTime('dd/mm/yy',cdsTmp.FieldByName('CTR_DTACAD').AsDateTime) , 8  , alCentro   );
  objLinha.pAddColuna('VR.DUPLICATA'    ,  FloatToStrF(cdsTmp.FieldByName('CTR_VALDUP').AsFloat, ffNumber, 9, 2)  , 13 , alDireita  );
  objLinha.pAddColuna('VR.CORRIGIDO(*)' ,  FloatToStrF(cdsTmp.FieldByName('CTR_VALCOR').AsFloat, ffNumber, 9, 2)  , 16 , alDireita  );
  objLinha.pAddColuna('NOSSO NUMERO'    ,  cdsTmp.FieldByName('CTR_NOSNUM').AsString                              , 12 , alDireita  );
  objLinha.pAddColuna('BCO'             ,  cdsTmp.FieldByName('CTR_BCOBOL').AsString                              , 3  , alDireita  );
  objTabela.lstLinhas.Add(objLinha);

End;

function TfrmRcxDigDesconto.fVerificaDescontoMaximo: Boolean;
  Var
    fltPerDes  : Double;
    fltPerMax  : Double;

    fltTotSel: Double;
    fltTotGer: Double;

    cdsTmp   : TUniClientDataSet;

    blnNivel2: Boolean;
    strSenNv2,
    strCliCod: String;

    objTabela : TRegistroMsgLiberaTabela;
    //MF: 285995 - 30/05/2023 - retirei a pMontaMensagem para fora do escopo dessa função para poder ser consumida compartilhadamente
begin
  cdsTmp := TUniClientDataSet.Create(Self);
  Try

    Result := True;

    fltTotSel := fStrToFloat(edtTotGer.Text);
    fltTotGer := fStrToFloat(edtTotLiq.Text);
    fltPerMax := fCfgSis('RCXDES', varDouble);

    fltPerDes := fFormataFloat( ( 100 * ( 1 - ( fltTotGer / fltTotSel ) ) ), 2);

    If (fFormataFloat(fltPerDes, 2) > fFormataFloat(fltPerMax, 2)) Then
    Begin

      cdsTmp.Data := cdsDados.Data;

      cdsTmp.First;
      cdsTmp.Filter := 'CTR_MARDES = ' + QuotedStr('M');
      cdsTmp.Filtered := True;

      objLiberacao.Clear;
      objTabela := TRegistroMsgLiberaTabela.Create;
      While not cdsTmp.Eof Do
      Begin
        pMontaMensagemLib(cdsTmp.FieldByName('CTR_NUMDUP').AsString +
                       cdsTmp.FieldByName('CTR_PARCEL').AsString + '-' +
                       cdsTmp.FieldByName('CTR_ESPDOC').AsString + '-' +
                       cdsTmp.FieldByName('CTR_CODEMP').AsString,
                       fltTotSel,
                       fltTotSel - fltTotGer,
                       fltPerDes,
                       fltTotGer,
                       cdsTmp.FieldByName('CTR_CODCLI').AsString,
                       'O valor do desconto é maior que o permitido.', //MF: 285995 - 30/05/2023
                       objTabela,//MF: 285995 - 30/05/2023
                       cdsTmp);//MF: 285995 - 30/05/2023

        cdsTmp.Next;
      End;



      if fEmptyStr((objLiberacao.objMsgLibera.lstRegistros[7] as TRegistroMsgLiberaTextoCaption).strTexto) Then
      begin
        (objLiberacao.objMsgLibera.lstRegistros[7] as TRegistroMsgLiberaTextoCaption).strCaption := 'Desconto máximo permitido';
        (objLiberacao.objMsgLibera.lstRegistros[7] as TRegistroMsgLiberaTextoCaption).strTexto   := FormatFloat('#,##0.00',fltPerMax) + '%';
      end
      Else
        objLiberacao.objMsgLibera.pAddTextoCaption('Desconto máximo permitido', FormatFloat('#,##0.00',fltPerMax) + '%', 25);

      objLiberacao.objMsgLibera.pAddQuebra;
      objLiberacao.objMsgLibera.pAddSeparador(142);
      objLiberacao.objMsgLibera.pAddTexto('RESUMO DOS TÍTULOS SELECIONADOS', alCentro, teAmbos, '',142);
      objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

      Result := False;

      blnNivel2 := fltPerDes > fCfgSis('RCXDE2', varDouble);
      strSenNv2 := fCfgSis('SENDE2');

      strCliCod := IIF(cdsTmp.RecordCount = 1, cdsTmp.FieldByName('CTR_CODCLI').AsString, ''); // Será gravado somente se houver UM registro
      While (True) Do
      Begin
        objLiberacao.strDirAce              := 'RCXDESMAX';
        objLiberacao.strSenLib              := fCfgSis('SENDES');
        objLiberacao.strMsgSen              := 'Desconto Máximo';
        objLiberacao.blnMosMen              := True;
        objLiberacao.strCodOpe              := strCodOpe;
        objLiberacao.strCodDig              := strCodOpe;
        objLiberacao.strDirAceNv2           := 'RCXDESMA2';
        objLiberacao.strSenLibNv2           := strSenNv2;
        objLiberacao.blnNivel2              := blnNivel2;
        objLiberacao.objMsgLibera.strTitulo := 'O valor do desconto é maior que o permitido.';
        objLiberacao.strCliente             := strCliCod;


        If (objLiberacao.fLibera) Then
        Begin
          Result := True;
          Break;
        End;

        If (fMensagem('', 'Senha Incorreta!', ['&Novamente', '&Desistir']) = 2) Then
          Break;

      End;

    End;
  Finally
    FreeAndNil(cdsTmp);
  End;

end;

//MF: 285995 - 30/05/2023 - verifica se tem faturas vencidas e está sendo concedido desconto
function TfrmRcxDigDesconto.fVerificaDescontoFaturaVencida: Boolean;
Var
  cdsTmp   : TUniClientDataSet;
  strCliCod: String;
  objTabela : TRegistroMsgLiberaTabela;
begin
  cdsTmp := TUniClientDataSet.Create(Self);
  Try
    Result := True;

    if (blnTemDupVen) And ((fStrToFloat(edtPerDes.Text) > 0) Or (fStrToFloat(edtDesEsp.Text) > 0)) Then
    Begin
      If (Not fVerificaAcessoSistema('DDUPVE', strCodOpe)) then
      Begin
        cdsTmp.Data := cdsDados.Data;

        cdsTmp.First;
        cdsTmp.Filter := 'CTR_MARDES = ' + QuotedStr('M');
        cdsTmp.Filtered := True;

        objLiberacao.Clear;
        objTabela := TRegistroMsgLiberaTabela.Create;
        While not cdsTmp.Eof Do
        Begin
          pMontaMensagemLib(cdsTmp.FieldByName('CTR_NUMDUP').AsString +
                           cdsTmp.FieldByName('CTR_PARCEL').AsString + '-' +
                           cdsTmp.FieldByName('CTR_ESPDOC').AsString + '-' +
                           cdsTmp.FieldByName('CTR_CODEMP').AsString,
                           fStrToFloat(edtTotGer.Text),
                           fStrToFloat(edtTotGer.Text) - fStrToFloat(edtTotLiq.Text),
                           fFormataFloat( ( 100 * ( 1 - ( fStrToFloat(edtTotLiq.Text) / fStrToFloat(edtTotGer.Text) ) ) ), 2),
                           fStrToFloat(edtTotLiq.Text),
                           cdsTmp.FieldByName('CTR_CODCLI').AsString,
                           'Autorização para desconto em duplicata vencida', //MF: 285995 - 30/05/2023
                           objTabela,//MF: 285995 - 30/05/2023
                           cdsTmp);//MF: 285995 - 30/05/2023

          cdsTmp.Next;
        End;

        objLiberacao.pInformaNumDocEspDocCodEmp(cdsTmp.FieldByName('CTR_NUMDUP').AsString +
                                                cdsTmp.FieldByName('CTR_PARCEL').AsString,
                                                cdsTmp.FieldByName('CTR_ESPDOC').AsString,
                                                cdsTmp.FieldByName('CTR_CODEMP').AsString);

        objLiberacao.objMsgLibera.pAddQuebra;
        objLiberacao.objMsgLibera.pAddSeparador(142);
        objLiberacao.objMsgLibera.pAddTexto('RESUMO DOS TÍTULOS SELECIONADOS', alCentro, teAmbos, '',142);
        objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

        Result := False;

        strCliCod := IIF(cdsTmp.RecordCount = 1, cdsTmp.FieldByName('CTR_CODCLI').AsString, '');
        While (True) Do
        Begin
          objLiberacao.strDirAce              := 'DDUPVE';
          objLiberacao.strMsgSen              := 'Usuário sem autorização para desconto em duplicata vencida';
          objLiberacao.blnMosMen              := True;
          objLiberacao.strCodOpe              := strCodOpe;
          objLiberacao.strCodDig              := strCodOpe;
          objLiberacao.objMsgLibera.strTitulo := 'Autorização para desconto em duplicata vencida';
          objLiberacao.strCliente             := strCliCod;

          If (objLiberacao.fLibera) Then
          Begin
            Result := True;
            Break;
          End;

          If (fMensagem('', 'Senha Incorreta!', ['&Novamente', '&Desistir']) = 2) Then
            Break;
        End;
        pRemoveLiberacao('DDUPVE','');
      End;

    End;
  Finally
    FreeAndNil(cdsTmp);
  End;

end;

procedure TfrmRcxDigDesconto.btnConfirmaDadosClick(Sender: TObject);
  Var
    fltAbaDes: Double;
begin
  inherited;

  If (fVerificaCampos) Then
  Begin
    If (fStrToFloat(edtPerDes.Text) > 0) Then
    Begin
      If (fEmptyStr(edtMotivo.Text)) And (edtMotivo.Visible) Then
      Begin
        fMensagem('ATENÇÃO', 'O motivo do desconto deve ser preenchido!', ['&Ok']);
        pSetFocus(edtMotivo);
        Exit;
      End;

    End;

    If (Not fVerificaDescontoMaximo) Then
    Begin
      Exit;
    End;

    If (Not fVerificaDescontoFaturaVencida) Then
    Begin
      Exit;
    End;

    fltAbaDes := fFormataFloat(fStrToFloat(edtTotGer.Text) - fStrToFloat(edtTotLiq.Text), 2);
    If (fltAbaDes > 0.0) Then
      pAbateDesconto(fltAbaDes);

    blnConfirma := True;
    Close;

  End;

end;

procedure TfrmRcxDigDesconto.pAbateDesconto(fltAbaDes: Double);
  Var
    fltTotDes: Double;
    intPosFin: Integer;
    fltValRec: Double;
    blnAbaDes: Boolean;

    fltPerCor: Double;
    fltValDes: Double;
begin

  fltTotDes := 0.0;
  intPosFin := 0;
  fltValRec := fStrToFloat(edtTotGer.Text);
  blnAbaDes := False;

  With cdsDados Do
  Begin

    DisableControls;
    First;

    While (Not Eof) Do
    Begin

      If (FieldByName('CTR_MARDES').AsString <> 'M') Or
         (FieldByName('CTR_VALRES').AsFloat > 0.0)   Or
         (FieldByName('CTR_VALREC').AsFloat < 0.0)   Then
      Begin
        Next;
        Continue;
      End;

      intPosFin := RecNo;

      Next;
    End;

    First;

    While (Not Eof) Do
    Begin

      If (FieldByName('CTR_MARDES').AsString <> 'M') Or
         (FieldByName('CTR_VALRES').AsFloat > 0.0)   Or
         (FieldByName('CTR_VALREC').AsFloat < 0.0)   Then
      Begin
        Next;
        Continue;
      End;

      Edit;

      fltPerCor := FieldByName('CTR_VALREC').AsFloat / fltValRec;

      If RecNo = intPosFin Then
        fltValDes := fFormataFloat(fltAbaDes - fltTotDes, 2)
      Else
        fltValDes := fFormataFloat(fltPerCor * fltAbaDes, 2);

      {*******************************************************************}
      {* Caso tenha selecionada várias duplicatas e o desconto especial  *}
      {* seja muito baixo, pode dar diferença de centavos no final por   *}
      {* conta do arredondamento feito em cada duplicata. Por essa razão *}
      {* o sistema verifica se o valor do desconto foi atingido e caso   *}
      {* tenha sido ultrapassado faz o ajuste.                           *}
      {*******************************************************************}
      if fltTotDes = fltAbaDes Then
        fltValDes := 0
      else
      if (fFormataFloat(fltTotDes + fltValDes, 2) > fFormataFloat(fltAbaDes, 2)) Then
        fltValDes := fFormataFloat(fltAbaDes - fltTotDes, 2);

      fltTotDes := fFormataFloat(fltTotDes + fltValDes, 2);

      If (FieldByName('CTR_VALJUR').AsFloat > 0.0) Then
      Begin

        If (fltValDes <= FieldByName('CTR_VALJUR').AsFloat) Then
        Begin
          FieldByName('CTR_VALJUR').AsFloat := FieldByName('CTR_VALJUR').AsFloat - fltValDes;
        End
        Else
        Begin
          FieldByName('CTR_VALDES').AsFloat := IIF(FieldByName('CTR_VALDES').AsFloat <> 0, FieldByName('CTR_VALDES').AsFloat, 0) +
                                               fFormataFloat(fltValDes - FieldByName('CTR_VALJUR').AsFloat, 2);
          FieldByName('CTR_VALJUR').AsFloat := 0.0;
        End;

      End
      Else
      Begin
        FieldByName('CTR_VALDES').AsFloat := FieldByName('CTR_VALDES').AsFloat + fltValDes;
      End;

      If (fltValDes > 0.0) Then
        FieldByName('CTR_VALREC').Value := fFormataFloat(FieldByName('CTR_VALREC').Value, 2) - fFormataFloat(fltValDes, 2);

      Post;

      blnAbaDes := True;

      Next;
    End;

    If (Not blnAbaDes) Then
    Begin
      fMensagem('', 'O Desconto concedido não foi abatido nas duplicatas.' + #13#10 +
                    'Somente será abatido para duplicatas que não sejam baixadas parcial!', ['&Ok']);
    End;

    EnableControls;

  End;

end;

procedure TfrmRcxDigDesconto.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtPerDes);
end;

procedure TfrmRcxDigDesconto.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if Assigned(objLiberacao) then
    FreeAndNil(objLiberacao);
end;

procedure TfrmRcxDigDesconto.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
  objLiberacao := TLiberacao.Create;
end;

procedure TfrmRcxDigDesconto.btnSairClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmRcxDigDesconto.FormShow(Sender: TObject);
begin
  inherited;

  If fCfgSis('MDERCX', varBoolean)Then
  Begin
    lblMotivo.Visible := True;
    edtMotivo.Visible := True;
    Self.Height := 232;
  End
  Else
  Begin
    lblMotivo.Visible := False;
    edtMotivo.Visible := False;
    Self.Height := 204;
  End;

end;

procedure TfrmRcxDigDesconto.edtPerDesChange(Sender: TObject);
begin
  inherited;

  If (fStrToFloat(edtPerDes.Text) > 0) Or
     (fStrToFloat(edtDesEsp.Text) > 0) Then
    edtMotivo.Enabled := True
  Else
  Begin
    edtMotivo.Clear;
    edtMotivo.Enabled := False;
  End;
  
end;

procedure TfrmRcxDigDesconto.edtMotivoExit(Sender: TObject);
begin
  inherited;

  If (fStrToFloat(edtPerDes.Text) > 0) Then
  Begin
    If fEmptyStr(edtMotivo.Text) Then
    Begin
      fMensagem('ATENÇÃO', 'O motivo do desconto deve ser preenchido!', ['&Ok']);
      pSetFocus(edtMotivo);
    End;

  End;

end;

end.

