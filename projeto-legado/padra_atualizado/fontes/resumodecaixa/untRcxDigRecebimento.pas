unit untRcxDigRecebimento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, ComCtrls, StdCtrls, Buttons, ExtCtrls, EditFocus,
  Menus, StrUtils, Uni, AppEvnts, DB, UniClientDataSet,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade, untFuncoesGenerica,
  untLiberacao, untFuncFat, untMargemLucro,
  untMsgLiberacao;//MF: 285995 - 31/05/2023

type
  TfrmRcxDigRecebimento = class(TfrmPaiSimples)
    pnlGeral: TPanel;
    pnlCabecalho: TPanel;
    pnlValores: TPanel;
    lblLabel1: TLabel;
    edtNumDup: TEditFocus;
    Label1: TLabel;
    edtValCor: TEditFocus;
    Label6: TLabel;
    edtValRec: TEditFocus;
    Label2: TLabel;
    edtValJur: TEditFocus;
    edtValDes: TEditFocus;
    Label3: TLabel;
    edtValRes: TEditFocus;
    Label4: TLabel;
    lblRomaneio: TLabel;
    edtRomaneio: TEditFocus;
    lblMotivo: TLabel;
    edtMotivo: TEditFocus;
    btnConfirma: TBitBtnLocked;
    btnMostraMargem: TBitBtnLocked;
    pnlJuros: TPanel;
    Label5: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    edtTotalizaValOri: TEditFocus;
    edtTotalizaJurSuj: TEditFocus;
    edtTotalizaDesSuj: TEditFocus;
    edtTotalizaValJur: TEditFocus;
    edtTotalizaValDes: TEditFocus;
    edtTotalizaValFin: TEditFocus;
    Label12: TLabel;
    edtValCob: TEditFocus;
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure edtRomaneioKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtValDesChange(Sender: TObject);
    procedure btnMostraMargemClick(Sender: TObject);
    procedure edtMotivoExit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure edtValRecEnter(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    fatVenda : TFatVenda;

    fltPerDes: Double;

    fltValJur: Double;
    fltValDes: Double;
    fltValRes: Double;
    fltValOri: Double;
    fltDupOri: Double;
    fltValDup: Double;
    fltJurSuj: Double;
    fltDesSuj: Double;

    blnBaiPar: Boolean;

    fltValDespon : Double; //Desconto Pontualidade   CFG_DESPON
    objLiberacao : TLiberacao;

    FValorNovaDuplicata,
    FJurosNovaDuplicata,
    FDescontoNovaDuplicata,
    FDespesasNovaDuplicata,
    FValorBaixaDuplicata,
    FJurosBaixaDuplicata,
    FDescontoBaixaDuplicata,
    FDespesasBaixaDuplicata,
    FFatorBaixaDuplicata,
    FFatorJurosDuplicata,
    FFatorDescontoDuplicata,
    FFatorDespesasDuplicata,
    FValorDespesasDigitado: Double;

    blnDupTemDespCob : Boolean;
    blnDesCob_Alterada : Boolean;

    blnValidouBxParcial : Boolean;
    blnValidouDescontoPermitido : Boolean;

    function fValidaValorRecebido(fltValRec: Double): Boolean;
    function fRetornaDescontoTotal(ADescontoPontualidade: Double): Double;
    function fVerificaRomaneio(strNumRom: String): Boolean;
    procedure pMostraMargem;
    function fGetSQLDocumento: String;
    function fVerificaDescontoFaturaVencida: Boolean;
    procedure pMontaMensagemLib(strDuplicata : String; fltValOri, fltDescon, fltPerDes, fltValRec : Double; strCodCli, strMsg : String; objTabela : TRegistroMsgLiberaTabela);
    procedure pAlteraValorDespCob;
    function fCalculaJurosDupAlt(fltValDuplic: Double; VarPercenJur: Double = 9999): Double;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    fltValRecAnt: Double;
    blnDigValor: Boolean;
    blnConfirma: Boolean;

    strCodEmp: String;
    strEspDoc: String;
    strNumDoc: String;

    fltValCob: Double;
    fltPercMultAplic,
    fltPercJuroAplic : Double;

    strCodOpe: String;
    cdsDados: TUniClientDataSet;

    blnDescFinanSomenteAteVenc: Boolean;
    blnBolAdt : Boolean;

    fltValCobCtr : Double;
    fltValCobAnt : Double;

    fltPercJurAplInicial : Double;
    dtaDtaVen: TDate;

    property ValorNovaDuplicata:    Double read FValorNovaDuplicata;
    property JurosNovaDuplicata:    Double read FJurosNovaDuplicata;
    property DescontoNovaDuplicata: Double read FDescontoNovaDuplicata;
    property DespesasNovaDuplicata : Double read FDespesasNovaDuplicata;
    property ValorBaixaDuplicata:   Double read FValorBaixaDuplicata;
    property JurosBaixaDuplicata   : Double read FJurosBaixaDuplicata;
    property FatorBaixaDuplicata:   Double read FFatorBaixaDuplicata;
    property FatorJurosDuplicata:   Double read FFatorJurosDuplicata;

  end;


implementation

uses  untfuncoesSimples, untPai, untTypesSistema, untFatMostraMargemNovo,
      untConsultas, untConstantes;

{$R *.dfm}

{ TfrmRcxDigRecebimento }

function TfrmRcxDigRecebimento.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (Sender = edtValRec) And (edtValRec.Enabled) Then
  Begin

    If (fEmptyStr(edtValRec.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O valor recebido deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      Result      := fValidaValorRecebido(fStrToFloat(edtValRec.Text));
      blnDigValor := Result;
    End;

  End

  Else If (Sender = edtValCob) And (edtValCob.Enabled) Then
  Begin

    If (fltValCob <> fStrToFloat(edtValCob.Text)) Then
        pAlteraValorDespCob();

    Result      := fValidaValorRecebido(fStrToFloat(edtValRec.Text));
    blnDigValor := Result;

  End

  Else If (Sender = edtRomaneio) Then
  Begin

    If (Not fEmptyStr(edtRomaneio.Text)) Then
    Begin

      If (Not fVerificaRomaneio(edtRomaneio.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Este romaneio não é válido!', ['&Ok']);
        Result := False;
      End;

    End;

  End

  Else If (Sender = edtValDes) Then
  Begin

    If (fEmptyStr(edtValDes.Text)) Then
    Begin
      edtValDes.Text := '0,00';
    End;

    If (fStrToFloat(edtValDes.Text) < 0) Then
    Begin
      edtValDes.Text := '0,00';
    End;

    If blnBolAdt And (fStrToFloat(edtValDes.Text) > 0) Then
    Begin
      fMensagem('ATENÇÃO!','Não é permitido dar desconto para duplicatas de espécie PD cujos boletos foram emitidos!', ['&Ok']);
      Result := False;
    End;

  End;
  If (Not Result) Then
    pSetFocus(Sender);

end;

//MF: 285995 - 31/05/2023 - retirei a pMontaMensagem para fora do escopo dessa função para poder ser consumida compartilhadamente
procedure TfrmRcxDigRecebimento.pMontaMensagemLib(strDuplicata : String; fltValOri, fltDescon, fltPerDes, fltValRec : Double; strCodCli, strMsg : String; objTabela : TRegistroMsgLiberaTabela);
var
  objLinha: TLinhaMsgLibera;
Begin
  if objLiberacao.objMsgLibera.isEmpty then
  begin
    objLiberacao.objMsgLibera.pAddTexto(strMsg);
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

  With cdsDados Do
  begin
    objLinha  := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlValor;
    objLinha.pAddColuna('DOCUMENTO'       ,  fPadR(FieldByName('CTR_NUMDUP').AsString,12)
                                           + FieldByName('CTR_PARCEL').AsString + '-'
                                           + FieldByName('CTR_ESPDOC').AsString                              , 17 , alEsquerda );
    objLinha.pAddColuna('EMP'             ,  FieldByName('CTR_CODEMP').AsString                              , 4  , alCentro   );
    objLinha.pAddColuna('CLIENTE'         ,  FieldByName('CTR_NOMCLI').AsString                              , 42 , alEsquerda );
    objLinha.pAddColuna('DT.VENC.'        ,  FormatDateTime('dd/mm/yy',FieldByName('CTR_DTAVEN').AsDateTime) , 8  , alCentro   );
    objLinha.pAddColuna('DT.CAD.'         ,  FormatDateTime('dd/mm/yy',FieldByName('CTR_DTACAD').AsDateTime) , 8  , alCentro   );
    objLinha.pAddColuna('VR.DUPLICATA'    ,  FloatToStrF(FieldByName('CTR_DUPORI').AsFloat, ffNumber, 9, 2)  , 13 , alDireita  );
    objLinha.pAddColuna('VR.CORRIGIDO(*)' ,  FloatToStrF(FieldByName('CTR_VALCOR').AsFloat, ffNumber, 9, 2)  , 16 , alDireita  );
    objLinha.pAddColuna('NOSSO NUMERO'    ,  FieldByName('CTR_NOSNUM').AsString                              , 12 , alDireita  );
    objLinha.pAddColuna('BCO'             ,  FieldByName('CTR_BCOBOL').AsString                              , 3  , alDireita  );
    objTabela.lstLinhas.Add(objLinha);

  end;

End;



{******************************************************}
{* AGORA CALCULANDO COM DESCONTO DE PONTUALIDADE      *}
{* E CALCULA JUROS E DESCONTO CORRETAMENTE  PARA QQ   *}
{* VALOR QUE O USUARIO DIGITAR                        *}
{REQ 42920 - 42778**********************************LE*}
function TfrmRcxDigRecebimento.fValidaValorRecebido(
  fltValRec: Double): Boolean;
  Var
    strSenha   : String;
    fltAlvo    : Double;
    fltValDesponTemp : Double;  // Desconto de pontualidade
    blnNivel2: Boolean;
    strSenNv2,
    strCliCod: String;
    objTabela : TRegistroMsgLiberaTabela;
    fltValMultaCalc,
    LDiferenca : Double;
    lPerguntaPadraoBaixaParcial: Integer;

    //MF: 285995 - 31/05/2023 - retirei a pMontaMensagem para fora do escopo dessa função para poder ser consumida compartilhadamente
begin
  If fltValRec = 0 Then
  Begin
    Result := False;
    fMensagem('', 'Não é possível baixar um valor igual a zero!', ['&Ok']);
    Exit;
  End;

  If (fltValRec > 0) And (fFormataFloat({fStrToFloat(edtValCor.Text)} fltValdup, 2) < 0) Then
  Begin
    Result := False;
    fMensagem('', 'O valor recebido deve ser menor que zero!', ['&Ok']);
    Exit;
  End;

  If (fltValRec < 0) And (fFormataFloat({fStrToFloat(edtValCor.Text)} fltValdup, 2) > 0) Then
  Begin
    Result := False;
    fMensagem('', 'O valor recebido deve ser maior que zero!', ['&Ok']);
    Exit;
  End;

  If (fltValDup < 0) And (fltValRec < fltValDup) Then
  Begin
    Result := False;
    fMensagem('', 'O valor recebido em duplicata negativa deve ser maior ou igual ao valor da duplicata!', ['&Ok']);
    Exit;
  End;

  Result := True;

  If (fFormataFloat(fStrToFloat(edtValRec.Text), 2) = fFormataFloat(fltValRecAnt, 2)) and
     (fFormataFloat(fStrToFloat(edtValCob.Text), 2) = fFormataFloat(fltValCobAnt, 2)) Then
    Exit;

  fltPerDes := 0.0;
  fltValRes := 0.0;
  fltValDesponTemp := 0.0;
  fltValMultaCalc := 0.0;

  fltAlvo   := fStrToFloat(edtValCor.Text);

  //Desconto de Pontualidade
  If (fCfgSis('DESPON', varBoolean))  And (cdsDados.FieldByName('CTR_PERDPO').AsFloat > 0)  Then
  Begin

    //Caso sejam iguais quer dizer que
    //não vai ter o desconto de pontualidade..
    If fStrToFloat(edtTotalizaValOri.Text) = fltValRec Then
    Begin
      fltAlvo      :=  fltAlvo + fltValDespon;
      fltValDesponTemp := 0;
    End
    Else
      fltValDesponTemp := fltValDespon;

  End;


  fltValDes := fRetornaDescontoTotal(fltValDesponTemp);

  fltValJur := fStrToFloat(edtTotalizaJurSuj.Text) + (fltAlvo - (fltDupOri + fStrToFloat(edtTotalizaJurSuj.Text) -
                                                                            fltValDes + fltValCob));

  If fltPercMultAplic > 0 Then
     fltValMultaCalc := ((fltPercMultAplic * fltValDup)/100);

  If (fltPercJurAplInicial = 0) and (fltValJur > 0) Then
     fltPercJurAplInicial := fFormataFloat(( (100 * ( (fltValJur - fltValMultaCalc) - fStrToFloat(edtTotalizaJurSuj.Text)) ) / fltValDup),2);

  //Caso o usuario digite o mesmo valor da duplicata original, ele tem que recalcular
  If (fFormataFloat(fltValRec,2) = fFormataFloat(fltDupOri,2)) And
  (fltValRec > 0) Then
    fltValDes := (fltDupOri - fltValRec) + fFormataFloat(fltValJur,2) + fFormataFloat(fltValCob,2);

  FJurosNovaDuplicata     := 0.00;
  FDescontoNovaDuplicata  := 0.00;
  FValorNovaDuplicata     := 0.00;
  FValorBaixaDuplicata    := 0.00;
  FJurosBaixaDuplicata    := 0.00;
  FDescontoBaixaDuplicata := 0.00;
  FDespesasBaixaDuplicata := 0.00;
  FFatorJurosDuplicata    := 0.0000000;
  FFatorBaixaDuplicata    := 0.0000000;
  FFatorDescontoDuplicata := 0.0000000;
  FFatorDespesasDuplicata := 0.0000000;

  If fFormataFloat(fltValRec,2) > 0 Then
  Begin

    If fFormataFloat(fltValRec,2) < fFormataFloat(fltAlvo,2) Then
    Begin
      lPerguntaPadraoBaixaParcial := IIf(fCfgSis('SUGPAR') = 'S',2,1);
      If Not blnValidouBxParcial Then
        blnBaiPar :=  fHabilitaBaixaParcial(strCodOpe) And
                    (fMensagem('', 'É baixa parcial?', ['&Não', '&Sim'],lPerguntaPadraoBaixaParcial) = 2);

      If blnBaiPar And blnBolAdt Then
      Begin
        fMensagem('ATENÇÃO!','Não é possível realizar baixa parcial de duplicatas de espécie PD cujos boletos foram emitidos!', ['&Ok']);
        Result := False;
        Exit;
      End;

      If Not blnValidouBxParcial Then
         If blnBaiPar And (Not fValidaBaixaParcial(strCodOpe, strLoginUsuarioLogado)) Then
         Begin
           Result := False;
           Exit;
         End
         Else
           blnValidouBxParcial := True;

      If (blnBaiPar) Then
      Begin
        blnDesCob_Alterada := False;
        FValorDespesasDigitado := 0;

        // O valor do desconto é revertido para garantir que não possua juros ou despesa cobrança inseridos anteriormente
        fltValDes := fRetornaDescontoTotal(fltValDesponTemp);

        // desc. cob alterada
        If (fFormataFloat(fltValCob,2) <> fStrToFloat(edtValCob.Text)) And (edtValCob.Text <> '') Then
        Begin
           fltValCob := fStrToFloat(edtValCob.Text);
           fltAlvo :=(fltAlvo - fltValCobAnt) + fltValCob;
           FValorDespesasDigitado := fltValCob;
           blnDesCob_Alterada := True;
        End;

        If fltValJur < 0 Then
          fltValJur := 0;

        FFatorBaixaDuplicata    := fltDupOri / fltAlvo;
        FFatorJurosDuplicata    := fltValJur / fltAlvo;
        FFatorDescontoDuplicata := fltValDes / fltAlvo;
        FFatorDespesasDuplicata := fltValCob / fltAlvo;

        FValorBaixaDuplicata    := fFormataFloat(fltValRec * FFatorBaixaDuplicata, 2);
        FJurosBaixaDuplicata    := fFormataFloat(fltValRec * FFatorJurosDuplicata, 2);
        FDescontoBaixaDuplicata := fFormataFloat(fltValRec * FFatorDescontoDuplicata, 2);
        FDespesasBaixaDuplicata := fFormataFloat(fltValRec * FFatorDespesasDuplicata, 2);

        LDiferenca := fFormataFloat(fltValRec -
                                    (FValorBaixaDuplicata + FJurosBaixaDuplicata + FDespesasBaixaDuplicata - FDescontoBaixaDuplicata), 2);

        FValorBaixaDuplicata := FValorBaixaDuplicata + (LDiferenca);

        FValorNovaDuplicata    := fFormataFloat(fltDupOri - FValorBaixaDuplicata, 2);
        FJurosNovaDuplicata    := fFormataFloat(fltValJur - FJurosBaixaDuplicata, 2);
        FDescontoNovaDuplicata := fFormataFloat(fltValDes - FDescontoBaixaDuplicata, 2);
        FDespesasNovaDuplicata := fFormataFloat(fltValCob - FDespesasBaixaDuplicata, 2);

        fltValRes := fltAlvo - fltValRec;
        fltValDes := FDescontoBaixaDuplicata;
        fltValJur := FJurosBaixaDuplicata;
        fltValCob := FDespesasBaixaDuplicata;

        edtValcor.text :=  FormatFloat('#,##0.00',fltAlvo);
      End
      Else
      	fltValDes := (fltDupOri - fltValRec) + fFormataFloat(fltValJur,2) + fFormataFloat(fltValCob,2);
    End
    Else If fFormataFloat(fltValRec,2) > fFormataFloat(fltDupOri,2) Then
      fltValJur := (fltValRec - fltDupOri) + fFormataFloat(fltValDes,2) - fFormataFloat(fltValCob,2)
    Else If fFormataFloat(fltValRec,2) < fFormataFloat(fltDupOri,2) Then
      fltValDes := (fltDupOri - fltValRec) +  fFormataFloat(fltValJur,2) + fFormataFloat(fltValCob,2);

    {*******************************************}
    {* CASO SEJA DADO DESCONTO SUPERIOR AO     *}
    {* CONFIGURADO, AVISA E PEDE SENHA DE LIBE-*}
    {* RAÇÃO                                   *}
    {****************************************MV*}
    fltPerDes := fFormataFloat((100 * fltValDes) / fltValDup, 2);

    If (fFormataFloat(fltPerDes, 2) > fFormataFloat(fCfgSis('RCXDES', varDouble), 2)) And (Not blnValidouDescontoPermitido) Then
    Begin
      strSenha := '';
      fMensagem('', 'O valor de desconto é maior que o permitido!', ['&Ok']);

      objLiberacao.Clear;
      objTabela := TRegistroMsgLiberaTabela.Create;

      pMontaMensagemLib(cdsDados.FieldByName('CTR_NUMDUP').AsString +
                        cdsDados.FieldByName('CTR_PARCEL').AsString + '-' +
                        cdsDados.FieldByName('CTR_ESPDOC').AsString + '-' +
                        cdsDados.FieldByName('CTR_CODEMP').AsString,
                        fltDupOri,
                        fltValDes,
                        fltPerDes,
                        fltValRec,
                        cdsDados.FieldByName('CTR_CODCLI').AsString,
                        'O valor do desconto é maior que o permitido.',//MF: 285995 - 31/05/2023
                        objTabela);//MF: 285995 - 31/05/2023

      if fEmptyStr((objLiberacao.objMsgLibera.lstRegistros[7] as TRegistroMsgLiberaTextoCaption).strTexto) Then
      begin
        (objLiberacao.objMsgLibera.lstRegistros[7] as TRegistroMsgLiberaTextoCaption).strCaption := 'Desconto máximo permitido';
        (objLiberacao.objMsgLibera.lstRegistros[7] as TRegistroMsgLiberaTextoCaption).strTexto   := FormatFloat('#,##0.00',fCfgSis('RCXDES', varDouble)) + '%';
      end
      Else
        objLiberacao.objMsgLibera.pAddTextoCaption('Desconto máximo permitido', FormatFloat('#,##0.00',fCfgSis('RCXDES', varDouble)) + '%', 25);


      objLiberacao.objMsgLibera.pAddQuebra;
      objLiberacao.objMsgLibera.pAddSeparador(142);
      objLiberacao.objMsgLibera.pAddTexto('RESUMO DOS TÍTULOS SELECIONADOS', alCentro, teAmbos, '',142);
      objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

      Result := False;

      blnNivel2 := fltPerDes > fCfgSis('RCXDE2', varDouble);
      strSenNv2 := fCfgSis('SENDE2');
      strCliCod := cdsDados.FieldByName('CTR_CODCLI').AsString;

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
        objLiberacao.objMsgLibera.strTitulo := 'O valor de desconto é maior que o permitido!';
        objLiberacao.strCliente             := strCliCod;

        If (objLiberacao.fLibera) Then
        Begin
          Result := True;
          blnValidouDescontoPermitido := True;
          Break;
        End
        Else
          Result := False;

        If (fMensagem('', 'Senha Incorreta!', ['&Novamente', '&Desistir']) = 2) Then
          Break;

      End;

    End;

  End
  {*******************************************}
  {* CASO SEJA BAIXA PARCIAL DE CRÉDITO      *}
  {****************************************RV*}
  Else If (fFormataFloat(fltValRec,2) < 0) And (fFormataFloat(fltValRec,2) <> fFormataFloat(fltValDup,2)) Then
  Begin
    blnBaiPar :=  True;

    If blnBaiPar And (Not fValidaBaixaParcial(strCodOpe, strLoginUsuarioLogado)) Then
    Begin
      Result := False;
      Exit;
    End;

    fltValRes := fltValDup + Abs(fltValRec);
    FValorBaixaDuplicata := fltValRec;
  End;

  If (Not Result) Then
    Exit;

  If fCfgSis('MDERCX', varBoolean) Then
  Begin

    If fltValJur > 0 Then
      edtMotivo.Enabled := True
    Else edtMotivo.Enabled := False;

    If fltValDes > 0 Then
      edtMotivo.Enabled := True;

  End;

  edtValJur.Text := FloatToStrF(fltValJur, ffFixed, 12, 2);
  edtValCob.Text := FloatToStrF(fltValCob, ffFixed, 12, 2);
  edtValDes.Text := FloatToStrF(fltValDes, ffFixed, 12, 2);
  edtValRes.Text := FloatToStrF(fltValRes, ffFixed, 12, 2);
  fltValRecAnt   := fStrToFloat(edtValRec.Text);
  fltValCobAnt   := fStrToFloat(edtValCob.Text);
  edtTotalizaValJur.Text := FloatToStrF(fStrToFloat(edtValJur.Text) - fStrToFloat(edtTotalizaJurSuj.Text), ffNumber, 12, 2);
  edtTotalizaValDes.Text := FloatToStrF(fStrToFloat(edtValDes.Text) - fStrToFloat(edtTotalizaDesSuj.Text), ffNumber, 12, 2);

  If fStrToFloat(edtTotalizaValJur.Text) < 0 Then edtTotalizaValJur.Text := '0,00';
  If fStrToFloat(edtTotalizaValDes.Text) < 0 Then edtTotalizaValDes.Text := '0,00';

  edtTotalizaValFin.Text := FloatToStrF(fStrToFloat(edtValRec.Text), ffNumber, 12, 2);
end;

function TfrmRcxDigRecebimento.fRetornaDescontoTotal(ADescontoPontualidade: Double): Double;
begin
  Result := ADescontoPontualidade + fStrToFloat(edtTotalizaDesSuj.Text);
end;

//MF: 285995 - 30/05/2023 - verifica se tem faturas vencidas e está sendo concedido desconto
function TfrmRcxDigRecebimento.fVerificaDescontoFaturaVencida: Boolean;
Var
  objTabela : TRegistroMsgLiberaTabela;
begin
  Result := True;

  If (fStrToFloat(edtValDes.Text) > 0) and (cdsDados.FieldByName('DIASATRASO').AsInteger > 0) Then
  Begin
    If (Not fVerificaAcessoSistema('DDUPVE', strCodOpe)) then
    Begin
      fltPerDes := fFormataFloat((100 * fStrToFloat(edtValDes.Text)) / fStrToFloat(edtValCor.Text), 2);

      objLiberacao.Clear;
      objTabela := TRegistroMsgLiberaTabela.Create;
      pMontaMensagemLib(cdsDados.FieldByName('CTR_NUMDUP').AsString +
                        cdsDados.FieldByName('CTR_PARCEL').AsString + '-' +
                        cdsDados.FieldByName('CTR_ESPDOC').AsString + '-' +
                        cdsDados.FieldByName('CTR_CODEMP').AsString,
                        fStrToFloat(edtValCor.Text),
                        fStrToFloat(edtValCor.Text) - fStrToFloat(edtValRec.Text),
                        fltPerDes,
                        fStrToFloat(edtValRec.Text),
                        cdsDados.FieldByName('CTR_CODCLI').AsString,
                        'Autorização para desconto em duplicata vencida',
                        objTabela);

      objLiberacao.pInformaNumDocEspDocCodEmp(cdsDados.FieldByName('CTR_NUMDUP').AsString +
                                              cdsDados.FieldByName('CTR_PARCEL').AsString,
                                              cdsDados.FieldByName('CTR_ESPDOC').AsString,
                                              cdsDados.FieldByName('CTR_CODEMP').AsString);


      objLiberacao.objMsgLibera.pAddQuebra;
      objLiberacao.objMsgLibera.pAddSeparador(142);
      objLiberacao.objMsgLibera.pAddTexto('RESUMO DOS TÍTULOS SELECIONADOS', alCentro, teAmbos, '',142);
      objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

      Result := False;
      While (True) Do
      Begin
        objLiberacao.strDirAce              := 'DDUPVE';
        objLiberacao.strMsgSen              := 'Usuário sem autorização para desconto em duplicata vencida';
        objLiberacao.blnMosMen              := True;
        objLiberacao.strCodOpe              := strCodOpe;
        objLiberacao.strCodDig              := strCodOpe;
        objLiberacao.objMsgLibera.strTitulo := 'Autorização para desconto em duplicata vencida';
        objLiberacao.strCliente             := cdsDados.FieldByName('CTR_CODCLI').AsString;
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
  //MF: 285995 - 30/05/2023 - Permitir dar descontos no recebimento de duplicatas vencidas. - FIM
end;

procedure TfrmRcxDigRecebimento.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  If (Not blnDigValor) Then
  Begin
    fMensagem('ATENÇÃO', 'Digite e confirme com a tecla "ENTER" um valor de recebimento!', ['&Ok']);
    pSetFocus(edtValRec);
    Exit;
  End;

  If (Not fVerificaCampos) Then
    Exit;

  If (fStrToFloat(edtValDes.Text) > 0) And (fCfgSis('MDERCX') = 'S') Then
  Begin
    If fEmptyStr(edtMotivo.Text) Then
    Begin
      fMensagem('ATENÇÃO', 'O motivo do desconto deve ser preenchido!', ['&Ok']);
      pSetFocus(edtMotivo);
      Exit;
    End;
  End;

  //MF: 285995 - 30/05/2023 - Permitir dar descontos no recebimento de duplicatas vencidas. - INI
  if (Not fVerificaDescontoFaturaVencida) Then
  Begin
    fMensagem('', 'Não é permitida a aplicação de desconto em duplicata vencida!', ['&OK']);
    Exit;
  End;
    //MF: 285995 - 30/05/2023 - Permitir dar descontos no recebimento de duplicatas vencidas. - FIM

  With cdsDados Do
  Begin
    Edit;

    FieldByName('CTR_VALREC').AsFloat  := fStrToFloat(edtValRec.Text);
    FieldByName('CTR_VALRES').AsFloat  := fltValRes;
    FieldByName('CTR_MOTDES').AsString := edtMotivo.Text;

    //** Verifica se o desconto de cobrança foi alterado para adicionar o valor na duplicata;
    If blnDesCob_Alterada Then
       FieldByName('CTR_VALDUP').AsFloat := (FieldByName('CTR_VALDUP').AsFloat - FieldByName('CTR_DESCOB').AsFloat) + fStrToFloat(edtValCob.Text);

    FieldByName('CTR_VALCOR').AsFloat  := fStrToFloat(edtValCor.Text);
    FieldByName('CTR_DESCOB').AsFloat  := FValorDespesasDigitado;

    FieldByName('VALORBAIXADUPLICATA').AsFloat    := 0.00;
    FieldByName('DESPESASBAIXADUPLICATA').AsFloat := 0.00;
    FieldByName('VALORNOVADUPLICATA').AsFloat     := 0.00;
    FieldByName('JUROSNOVADUPLICATA').AsFloat     := 0.00;
    FieldByName('DESCONTONOVADUPLICATA').AsFloat  := 0.00;
    FieldByName('DESPESASNOVADUPLICATA').AsFloat  := 0.00;
    FieldByName('FATORBAIXADUPLICATA').AsFloat    := 0.000000;
    FieldByName('FATORJUROSDUPLICATA').AsFloat    := 0.000000;



    If (blnBaiPar) Then
    Begin
      FieldByName('CTR_VALJUR').AsFloat := fltValJur;
      FieldByName('CTR_VALDES').AsFloat := fltValDes;

      FieldByName('VALORBAIXADUPLICATA').AsFloat    := FValorBaixaDuplicata;
      FieldByName('DESPESASBAIXADUPLICATA').AsFloat := fltValCob;
      FieldByName('VALORNOVADUPLICATA').AsFloat     := FValorNovaDuplicata;
      FieldByName('JUROSNOVADUPLICATA').AsFloat     := FJurosNovaDuplicata;
      FieldByName('DESPESASNOVADUPLICATA').AsFloat  := FDespesasNovaDuplicata;
      FieldByName('DESCONTONOVADUPLICATA').AsFloat  := FDescontoNovaDuplicata;
      FieldByName('FATORBAIXADUPLICATA').AsFloat    := FFatorBaixaDuplicata;
      FieldByName('FATORJUROSDUPLICATA').AsFloat    := FFatorJurosDuplicata;
    End
    Else
    Begin
      FieldByName('CTR_VALJUR').AsFloat := fltValJur;
      FieldByName('CTR_VALDES').AsFloat := fltValDes;
    End;

    If Not fEmptyStr(edtRomaneio.Text) Then
      FieldByName('RCX_NUMROM').AsString := edtRomaneio.Text;

    FieldByName('CTR_BAIPAR').AsString := IIF(blnBaiPar, 'S', 'N');

    Post;
  End;

  blnConfirma := True;
  Close;

end;

procedure TfrmRcxDigRecebimento.FormShow(Sender: TObject);
begin
  inherited;

  fatVenda := TFatVenda.CreateInstance('VN');

  fltValRecAnt := 0.0;
  fltValCobAnt := 0.0;

  fltJurSuj := cdsDados.FieldByName('CTR_JURSUJ').AsFloat;
  fltDesSuj := cdsDados.FieldByName('CTR_DESSUJ').AsFloat;

  fltValDup := cdsDados.FieldByName('CTR_VALDUP').AsFloat;
  fltValOri := cdsDados.FieldByName('CTR_VALCOR').AsFloat;
  fltDupOri := cdsDados.FieldByName('CTR_DUPORI').AsFloat;

  fltValCobCtr := cdsDados.FieldByName('CTR_DESCOB').AsFloat;

  dtaDtaVen := cdsDados.FieldByName('CTR_DTAVEN').AsDateTime;

  fltPercJurAplInicial := 0;

  blnConfirma := False;

  blnValidouBxParcial := False;
  blnValidouDescontoPermitido := False;

  blnDupTemDespCob   := False;
  blnDesCob_Alterada := False;

  If fltValCob > 0 Then
     blnDupTemDespCob := True;

  //Pesquisa de romaneio ...
  If fCfgSis('RCXROM') = 'S' Then
  Begin
    edtRomaneio.Visible := True;
    lblRomaneio.Visible := True;
  end;
  {
  If (fStrToFloat(edtValRec.Text) < 0.0) Then
  Begin
    blnDigValor := True;
    edtValRec.Enabled := False;
    pSetFocus(btnConfirma);
  End;
  }
  If fCfgSis('MDERCX', varBoolean) Then
  Begin
    lblMotivo.Visible := True;
    edtMotivo.Visible := True;
  End
  Else
  Begin
    lblMotivo.Visible := False;
    edtMotivo.Visible := False;
  End;

  If fVerificaAcessoSistema('DIRRCXMA', strCodOpe) Then
    btnMostraMargem.Visible := True
  Else
    btnMostraMargem.Visible := False;

  edtTotalizaValOri.Text := FloatToStrF(cdsDados.FieldByName('CTR_DUPORI').AsFloat, ffFixed, 12, 2);
  edtTotalizaJurSuj.Text := FloatToStrF(fltJurSuj, ffFixed, 12, 2);
  edtTotalizaDesSuj.Text := FloatToStrF(fltDesSuj, ffFixed, 12, 2);

  If (fStrToFloat(edtValRec.Text) >= fltValOri) Then
  Begin
    edtTotalizaValJur.Text := FloatToStrF(fStrToFloat(edtValRec.Text) - cdsDados.FieldByName('CTR_DUPORI').AsFloat - fltJurSuj, ffFixed, 12, 2);
    edtTotalizaValDes.Text := '0,00';
  End
  Else
  Begin
    edtTotalizaValJur.Text := FloatToStrF(fltValOri - (cdsDados.FieldByName('CTR_DUPORI').AsFloat) - fltJurSuj, ffFixed, 12, 2);
    edtTotalizaValDes.Text := FloatToStrF(fltValOri - fStrToFloat(edtValRec.Text) - fltDesSuj, ffFixed, 12, 2);
  End;

  If fStrToFloat(edtTotalizaValJur.Text) < 0 Then edtTotalizaValJur.Text := '0,00';
  If fStrToFloat(edtTotalizaValDes.Text) < 0 Then edtTotalizaValDes.Text := '0,00';

  edtTotalizaValFin.Text := edtValRec.Text;

  fltValDespon     := fStrToFloat(edtValDes.Text);

  edtValJur.Enabled := (Copy(edtValRec.Text,1,1) <> '-');
  edtValDes.Enabled := edtValJur.Enabled;

  btnMostraMargem.Visible := (fVerificaAcessoSistema('DIRRCXMA', strCodOpe));

  edtValCob.enabled  := True;
  edtValCob.Readonly := False;
  edtValCob.TabStop  := True;

end;

procedure TfrmRcxDigRecebimento.btnSairClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmRcxDigRecebimento.edtRomaneioKeyPress(Sender: TObject;
  var Key: Char);
  Var
    qryConGen : TUniQuery;
    arrSel    : TConsultasArray;

begin
  inherited;

  qryConGen := fCriaQuery;

  If fPesqRomaneio(Self, edtRomaneio, qryConGen, Key, arrSel, 'CADREC') Then
  Begin
    If (fValidaCampos(edtRomaneio, True)) Then
    Begin
      SelectNext(ActiveControl, True, True);
    End;
  End;

  FreeAndNil(qryConGen);

end;

function TfrmRcxDigRecebimento.fVerificaRomaneio(
  strNumRom: String): Boolean;
  Var
    strSQL   : String;
    qryGenGer: TUniQuery;

begin
  Try

    qryGenGer := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  COUNT(*) AS QTD ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  ROMGERX, ';
    strSQL := strSQL + '  CADREC ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  GER_NUMDOC = ' + QuotedStr(cdsDados.FieldByName('CTR_NUMDUP').AsString) + ' AND ';
    strSQL := strSQL + '  CTR_NUMDUP = GER_NUMDOC AND ';
    strSQL := strSQL + '  CTR_DTAREC IS NULL AND ';
    strSQL := strSQL + '  GER_NUMROM = :NUMROM AND ';
    strSQL := strSQL + '  GER_EMPROM = :EMPROM ';

    With qryGenGer Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMROM').AsString := edtRomaneio.Text;
      ParamByName('EMPROM').AsString := VS_strCodEmp;
      Open;
      Result := (FieldByName('QTD').AsInteger > 0);
      Close;
    End;

  Finally
    FreeAndNil(qryGenGer);
  End;

end;

procedure TfrmRcxDigRecebimento.FormActivate(Sender: TObject);
begin
  inherited;
    pSetFocus(edtValRec);
end;

procedure TfrmRcxDigRecebimento.FormCreate(Sender: TObject);
begin
  inherited;
  objLiberacao := TLiberacao.Create;
end;

procedure TfrmRcxDigRecebimento.FormDestroy(Sender: TObject);
begin
  FreeAndNil(fatVenda);

  if Assigned(objLiberacao) then
    FreeAndNil(objLiberacao);
  inherited;
end;

procedure TfrmRcxDigRecebimento.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If Not fEmptyStr(edtRomaneio.Text) Then
    edtRomaneio.TabStop := False;
end;

procedure TfrmRcxDigRecebimento.edtValDesChange(Sender: TObject);
begin
  inherited;

  If fStrToFloat(edtValDes.Text) > 0 Then
    edtMotivo.Enabled := True
  Else
  Begin
    edtMotivo.Clear;
    edtMotivo.Enabled := False;
  End;

end;

procedure TfrmRcxDigRecebimento.edtValRecEnter(Sender: TObject);
begin
  inherited;
  fltValRecAnt := 0;
  fltValJur := 0.0;
  fltValDes := 0.0;
  fltValRes := 0.0;

end;

function TfrmRcxDigRecebimento.fGetSQLDocumento: String;
begin
  Result := '';
  Result := Result + 'SELECT SQL_NO_CACHE ';
  Result := Result + '  DET_CODITE AS ITE_CODITE, ';
  Result := Result + '  DET_UNIORI AS ITE_UNIORI, ';
  Result := Result + '  IF((LOCATE("ITEM ESPECIAL", I.ITE_DESITE) > 0) OR (DET_IDEPRO <> "NOR") OR (DET_PROACA = "S"), DET_DESCRI, I.ITE_DESITE) AS ITE_DESITE, ';
  Result := Result + '  IF(LEFT(DET_CLAFIS,1) < 5, -(DET_UNITAR), DET_UNITAR) AS ITE_UNITAR, ';
  Result := Result + '  IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTCUS), DET_TOTCUS) AS ITE_PRECUS, ';
  Result := Result + '  IF(LEFT(DET_CLAFIS,1) < 5, -(DET_QTDITE), DET_QTDITE) AS ITE_QTDITE, ';
  Result := Result + '  G.ITE_MARMIN, ';
  Result := Result + '  G.ITE_PRECUS AS ITE_CUSITE, ';
  Result := Result + '  G.ITE_PREMED, ';
  Result := Result + '  G.ITE_PREULT, ';
  Result := Result + '  IFNULL(T.DET_DESOPE, 0.00) * 100 / (DET_TOTITE - DET_DESESP + DET_TOTFRE + DET_DESACE) AS DET_DESOPE, ';
  Result := Result + '  IFNULL(T.DET_IMPFED, 0.00) * 100 / (DET_TOTITE - DET_DESESP + DET_TOTFRE + DET_DESACE) AS DET_IMPFED, ';
  Result := Result + '  IFNULL(T.DET_ICMSAI, 0.00) * 100 / (DET_TOTITE - DET_DESESP + DET_TOTFRE + DET_DESACE) AS DET_ICMSAI, ';
  Result := Result + '  IFNULL(T.DET_OUTVAL, 0.00) AS DET_OUTVAL, ';
  Result := Result + '  IFNULL(T.DET_IMPULT, 0.00) AS DET_IMPULT, ';
  Result := Result + '  DET_NUMLOT, ';
  Result := Result + '  DET_DESESP, ';
  Result := Result + '  DET_CODCLI, ';
  Result := Result + '  CLI_DESOPE  ';
  Result := Result + 'FROM ';
  Result := Result + '  MOVDET ';
  Result := Result + '  JOIN MOVGER ON MOVGER.AUTOINCREM = DET_SEQGER ';
  Result := Result + '  JOIN CADITE I ON DET_CODITE = I.ITE_CODITE ';
  Result := Result + '  JOIN CADCLI ON CLI_CODCLI = DET_CODCLI ';
  Result := Result + '  LEFT JOIN ITEGER G ON G.ITE_CODITE = I.ITE_CODITE ';
  Result := Result + '  LEFT JOIN MOVTRI T ON T.DET_SEQGER = MOVDET.AUTOINCREM ';
  Result := Result + 'WHERE ';
  Result := Result + '  LOCATE(DET_NUMDOC, :NUMDOC) AND ';
  Result := Result + '  LOCATE(DET_ESPDOC, :ESPDOC) AND ';
  Result := Result + '  DET_CODEMP = :CODEMP AND ';
  Result := Result + '  DET_CODCLI NOT IN (' + VS_strCliFil + ') AND ';
  Result := Result + '  (LOCATE(DET_ESPDOC, "TM_ML_PR_") <= 0) AND ';
  Result := Result + '  DET_PROEMB <> "S" AND ';
  Result := Result + '  DET_TIP_FC = "C"  AND ';
  Result := Result + '  G.ITE_CODEMP = :CODEMP ';
  Result := Result + ' UNION ALL ' +  AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(Result, 'MOVDET', 'NOTDET'), 'MOVGER', 'NOTGER'), 'MOVTRI', 'NOTTRI');
end;

procedure TfrmRcxDigRecebimento.btnMostraMargemClick(Sender: TObject);
begin
  inherited;
  If (btnMostraMargem.Enabled) And (btnMostraMargem.Visible) Then
  Begin
    pMostraMargem;
    pSetFocus(ActiveControl);
  End;
end;

procedure TfrmRcxDigRecebimento.pMostraMargem;
  Var
    fltDesEsp: Double;
    qryGen   : TUniQuery;
    frmMosMar : TfrmFatMostraMargemNovo;
    cdsItens : TUniClientDataSet;
    cdsVendaTmp : TUniClientDataSet;
begin
  qryGen := fCriaQuery(Self);
  cdsItens := TMargemLucro.fCriaEstruturaDadosMargemLucro;
  cdsVendaTmp := TUniClientDataSet.Create(Self);
  Try
    Try
      pCloneDataSet(cdsVendaTmp, cdsItens);

      With qryGen Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(fGetSQLDocumento);
        ParamByName('NUMDOC').AsString := strNumDoc;
        ParamByName('ESPDOC').AsString := strEspDoc;
        ParamByName('CODEMP').AsString := strCodEmp;
        Open;

        If Not IsEmpty Then
        Begin
          fatVenda.strCodCli := FieldByName('DET_CODCLI').AsString;
          fatVenda.fltDesOpeCli := FieldByName('CLI_DESOPE').AsFloat;

          With qryGen Do
          Begin
            fltDesEsp := 0;

            First;
            While Not Eof Do
            Begin
              fltDesEsp := fltDesEsp + FieldByName('DET_DESESP').AsFloat;

              cdsVendaTmp.Append;
              cdsVendaTmp.FieldByName('ITE_CODITE').AsString := FieldByName('ITE_CODITE').AsString;
              cdsVendaTmp.FieldByName('ITE_DESITE').AsString := FieldByName('ITE_DESITE').AsString;
              cdsVendaTmp.FieldByName('ITE_SIGUNI').AsString := fRetSiglaUnidadePorCodIte(FieldByName('ITE_CODITE').AsString);
              cdsVendaTmp.FieldByName('ITE_PRECUS').AsFloat := (FieldByName('ITE_PRECUS').AsFloat / FieldByName('ITE_QTDITE').AsFloat );
              cdsVendaTmp.FieldByName('ITE_QTDITE').AsFloat := FieldByName('ITE_QTDITE').AsFloat;
              cdsVendaTmp.FieldByName('ITE_UNITAR').AsFloat := FieldByName('ITE_UNITAR').AsFloat;
              cdsVendaTmp.FieldByName('ITE_UNIORI').AsFloat := FieldByName('ITE_UNIORI').AsFloat;
              cdsVendaTmp.FieldByName('ITE_CUSITE').AsFloat := FieldByName('ITE_CUSITE').AsFloat;
              cdsVendaTmp.FieldByName('ITE_PREMED').AsFloat := FieldByName('ITE_PREMED').AsFloat;
              cdsVendaTmp.FieldByName('ITE_PREULT').AsFloat := FieldByName('ITE_PREULT').AsFloat;
              cdsVendaTmp.FieldByName('ITE_IMPULT').AsFloat := FieldByName('DET_IMPULT').AsFloat;
              cdsVendaTmp.FieldByName('ITE_MARMIN').AsFloat := FieldByName('ITE_MARMIN').AsFloat;
              cdsVendaTmp.FieldByName('ITE_DESOPE').AsFloat := FieldByName('DET_DESOPE').AsFloat;
              cdsVendaTmp.FieldByName('ITE_IMPFED').AsFloat := FieldByName('DET_IMPFED').AsFloat;
              cdsVendaTmp.FieldByName('ITE_ICMSAI').AsFloat := FieldByName('DET_ICMSAI').AsFloat;
              cdsVendaTmp.FieldByName('ITE_OUTVAL').AsFloat := FieldByName('DET_OUTVAL').AsFloat;
              cdsVendaTmp.Post;

              cdsItens.Append;
              fatVenda.pPrepararDataSetParaCalculoDaMargem(cdsItens, cdsVendaTmp,
                                                           True, True, False, 0, False);
              cdsItens.Post;

              Next;
            End;
          End;

          fatVenda.pCalcularEPreencherMargemDataSet(cdsItens);

          frmMosMar := TfrmFatMostraMargemNovo.Create(Self,
                                                      Nil,
                                                      Nil,
                                                      strLoginUsuarioLogado,
                                                      False,
                                                      0,
                                                      False,
                                                      False,
                                                      Nil,
                                                      Nil,
                                                      fltDesEsp
                                                     );

          Try
            frmMosMar.cdsItens := cdsItens;
            frmMosMar.pCalcularTotais(cdsItens.Data, fatVenda);
            frmMosMar.ShowModal;
          Finally
            pFreeAndNil(frmMosMar);
          End;
        End
        Else
          fMensagem('', 'Documento não encontrado!', ['&Ok']);
      End;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[frmRcxDigRecebimento.pMostraMargem]');
    End;
  Finally
    FreeAndNil(qryGen);
    FreeAndNil(cdsItens);
    FreeAndNil(cdsVendaTmp);
  End;
end;

procedure TfrmRcxDigRecebimento.edtMotivoExit(Sender: TObject);
begin
  inherited;
  If (fStrToFloat(edtValDes.Text) > 0) Then
  Begin
    If fEmptyStr(edtMotivo.Text) Then
    Begin
      fMensagem('ATENÇÃO', 'O motivo do desconto deve ser preenchido!', ['&Ok']);
      pSetFocus(edtMotivo);
    End;
  End;
end;

Procedure TfrmRcxDigRecebimento.pAlteraValorDespCob();
 Var
     LDifDesCob    : Double;
     LNovoDesCob   : Double;
     vlrJuros      : Double;
     vlJurDuplicata: Double;
     fltJurCalc    : Double;
     varVlrMulta   : Double;
Begin

    If (Not blnBaiPar) Then
    Begin

       LNovoDesCob   := 0;
       blnDesCob_Alterada := False;

       If (blnDupTemDespCob) Then
       Begin

          If fltValCob > fStrToFloat(edtValCob.Text) Then
          Begin
             LDifDesCob  := fltValCob - fStrToFloat(edtValCob.Text);
             LNovoDesCob := fltValCob - LDifDesCob;
             blnDesCob_Alterada := True;
          End
          Else
          If fltValCob < fStrToFloat(edtValCob.Text) Then
          Begin
             LDifDesCob := fStrToFloat(edtValCob.Text) - fltValCob;
             LNovoDesCob := fltValCob + LDifDesCob;
             blnDesCob_Alterada := True;
          End;

       End
       Else
       Begin
          LNovoDesCob := fStrToFloat(edtValCob.Text);
          blnDesCob_Alterada := True;
       End;


       fltJurCalc := fCalculaJurosDupAlt( (fltDupOri + LNovoDesCob + fltJurSuj - fltValDes), fltPercJuroAplic );

       fltValCob  := LNovoDesCob;
       FValorDespesasDigitado := LNovoDesCob;

       vlJurDuplicata := fltJurCalc + fltJurSuj;

       // Verifica se tem Juros.
       If (vlJurDuplicata > 0) Or (fltValJur > 0) Then
       Begin
          varVlrMulta := 0.0;

          //calcula multa;
          If fltPercMultAplic > 0 Then
             varVlrMulta := ((fltValDup * fltPercMultAplic) / 100);

          vlrJuros := fltJurCalc;

          edtValrec.Text := FormatFloat('#,##0.00', (fltValDup - fltValCobCtr) + LNovoDesCob {- fltValDes - fltValJur} + vlrJuros + varVlrMulta);

          edtValcor.text := FormatFloat('#,##0.00', (fltValDup - fltValCobCtr) + LNovoDesCob {- fltValDes - fltValJur} + vlrJuros + varVlrMulta);
       End
       Else
       Begin
          edtValrec.Text := FormatFloat('#,##0.00', fltDupOri + fltJurSuj + LNovoDesCob - fltValDes);
          edtValcor.text := FormatFloat('#,##0.00', (fltValDup - fltValCobCtr) + LNovoDesCob);
       End;

    End;

End;

function TfrmRcxDigRecebimento.fCalculaJurosDupAlt(fltValDuplic: Double; VarPercenJur: Double = 9999): Double;
  Var
    fltDiaAtraso: Double;
    dtaDtaPag : TDateTime;

    VarintTolerancia : Integer;

begin

  Result := 0.0;

  dtaDtaPag := cdsDados.FieldByName('DATA_JUROS').AsDateTIme;

  If fltValDuplic > 0 Then
  Begin

      VarintTolerancia := fCfgSis('TOLATR', varInteger);

    If VarPercenJur = 9999 Then
       VarPercenJur := fCfgSis('JURATR', varDouble);

    fltDiaAtraso := dtaDtaPag - dtaDtaVen;

    If (dtaDtaVen < dtaDtaPag) And (fltDiaAtraso > VarintTolerancia) Then
    Begin
      Result := fltValDuplic * (((VarPercenJur / 30) * fltDiaAtraso) / 100);

      Result := fFormataFloat(Result, 2);
    End;

  End;

End;


end.

