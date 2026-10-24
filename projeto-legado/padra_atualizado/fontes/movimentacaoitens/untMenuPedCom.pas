
unit untMenuPedCom;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, ComCtrls, Buttons, ExtCtrls,
  EditFocus, Menus, StrUtils {Qt,}, Uni, untGiroDeEstoque, AppEvnts;

type
  TfrmMenuPedCom = class(TfrmPaiSimples)
    edtNumPed: TEditFocus;
    lblPedOrc: TLabel;
    pnlFundo: TPanel;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    btnHeranca: TBitBtn;
    rdgOpcoes: TRadioGroup;
    btnCarrTxtFornecedor: TBitBtn;
    lblEmpresa: TLabel;
    edtCodEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure edtNumPedKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnHerancaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCarrTxtFornecedorClick(Sender: TObject);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpresaExit(Sender: TObject);
  private
    { Private declarations }

    strCodGru: String;
    strCodFor: String;
    strCodMar: String;
    intQtdDia: Integer;
    blnAllIte: Boolean;

    blnNovoReg: Boolean;
    blnUsarGiro: Boolean;

    lstArquivos: TStringList;
    strPedMlj: String;

    procedure pChamaTelaPedido;
    procedure pCarregaEmpresa;

    function fCarregaPedCom(intNumPed: Integer; strEspDoc: String): Boolean;
    function fChamaCalculoGiro: Boolean;
    function fVerificaNotImpEmitida(strNumPed, strEspDoc, strCodEmp: String): Boolean;
    function fRetornaEmpresaDestino(strNumPed, strEspDoc, strCodEmp: String): String;

    procedure OnIdle(Sender: TObject; Var Done: Boolean);

    function fComparaEmpresa: Boolean;

  protected
    procedure pEscapePressed; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    strEspDoc: String;
    strDocOri: String;
    blnConfirma: Boolean;
    //intMesGir: Integer;
    intOpcGir: Integer;
    blnArredSug: Boolean;  // Arredonda quantidade de sugestão
    blnConsMCom: Boolean;  // Considera múltiplo de compra
    blnConsTLoj: Boolean;  // Considera todas as lojas somadas
    intOrdem   : Integer;  // Ordenação: 1-descricao e 2-marca+descricao
    blnConsEMin: Boolean;  // Considera estoque minimo para sugestão

    // variáveis utilizadas na impressão do pedido
    blnSemPre: Boolean;
    blnOrdDig: Boolean;
    blnImprim: Boolean;
    blnImpRes: Boolean;

    strCodEmp: String;

  end;

var
  frmMenuPedCom: TfrmMenuPedCom;

implementation

uses untFuncoes, untfuncoesSimples, untPedidoCompra, DB,
  untDigGiroEstoque, untPai, untConstantes, untModuloPcmGer,
  untConsultaPedidoCompra, untModuloSPR, 
  untEntImportaPedFornc, untPedidoCompraImpr, untModuloCadEmp,
  untPedidoCompraTXT, untPedOpcoes;

{$R *.dfm}

procedure TfrmMenuPedCom.FormCreate(Sender: TObject);
begin
  inherited;
  strEspDoc   := 'PD';
  blnConfirma := False;

  edtCodEmpresa.Text := VS_strCodEmp;
  edtDesEmpresa.Text := fRetNomeEmpresa;
  strCodEmp := VS_strCodEmp;

  If Not fCfgSis('ALPDOL', varBoolean) Then
    edtCodEmpresa.Enabled := False
  Else
    edtCodEmpresa.Enabled := True;

  Application.OnIdle := Self.OnIdle;
end;

function TfrmMenuPedCom.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    strSQL     : String;
    qryGen     : TUniQuery;
    strPedOrc  : String;
    intOpcao   : Integer;
    strPathArq : String;
    strArqSuv  : String;
    strArqCoral: String;
    strDtaPed  : String;
    strDtaEnt  : String;
    strNumPed  : String;
    intContador: Integer;
    fltQtdIte  : Double;
    fltUnitar  : Double;
    strUnitar  : String;
    intSeqCor  : Integer;
    strCndPag  : String;
    strEmpDes  : String;
    lstTexto   : TStringList;
    strLinha   : String;
    intFoco    : Integer;
    blnConfirma: Boolean;
begin
  Result      := True;
  blnNovoReg  := True;
  blnUsarGiro := False;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtNumPed) Then
    Begin

      edtNumPed.Enabled := False;

      If fEmptyStr(edtCodEmpresa.Text) Then
      Begin
        edtCodEmpresa.Text := VS_strCodEmp;
        strCodEmp          := VS_strCodEmp;
        pCarregaEmpresa;
      End;

      If rdgOpcoes.ItemIndex = 0 Then
      Begin
        strPedOrc := 'pedido';
        strEspDoc := 'PD';
      End
      Else
      Begin
        strPedOrc := 'orçamento';
        strEspDoc := 'OR';
      End;

      If Not fEmptyStr(edtNumPed.Text) Then
      Begin
        If fCarregaPedCom(StrToInt(edtNumPed.Text), strEspDoc) Then
          blnNovoReg := False
        Else
        Begin
          fMensagem('ATENÇÃO!', 'Esse ' + strPedOrc + ' não está cadastrado!', ['&O k']);
          edtNumPed.Enabled := True;
          Result := False;
        End;
      End
      Else
      Begin
        Result := fComparaEmpresa;
        fFecharTabela(frmModuloPcmGer.qryPcmGer);
      End;

      {*****************************************}
      {* VERIFICA SE O PEDIDO ESTÁ JÁ ESTA     *}
      {* BAIXADA                               *}
      {**************************************MV*}
      If (Result) And (Not blnNovoReg) Then
      Begin
        If Not fVerificaPedidoBaixado(edtNumPed.Text, strEspDoc, strCodEmp) Then
          Result := True
        Else
        Begin
          Result := False;
          edtNumPed.Enabled := True;
          fMensagem('ATENÇÃO!', 'Esse pedido já está baixado!', ['&O k']);
        End;
      End;

      If (Result) Then
      Begin
        If (fVerificaNotImpEmitida(edtNumPed.Text, strEspDoc, strCodEmp)) Then
        Begin
          Result := False;
          edtNumPed.Enabled := True;
          fMensagem('ATENÇÃO!', 'A nota de importação referente a esse pedido ' + #13#10 +
                                'já foi emitida, portanto não é possível altera-lo!', ['&O k']);
        End;
      End;

      strPedMlj := fCfgSis('PEDMLJ');
      If (Result) And (blnNovoReg) Then
      Begin

        If fCfgSis('PEDMLJ') = 'S' Then
          intFoco := 0
        Else
          intFoco := 1;

        Try
          Application.CreateForm(TfrmPedOpcoes, frmPedOpcoes);
          frmPedOpcoes.rdgMultiLoja.ItemIndex := intFoco;
          frmPedOpcoes.ShowModal;
        Finally
          blnUsarGiro := frmPedOpcoes.blnGiro;
          blnConfirma := frmPedOpcoes.blnConfirma;
          If frmPedOpcoes.blnMultiLoja Then
            strPedMlj := 'S'
          Else
            strPedMlj := 'N';
          pFreeAndNil(frmPedOpcoes);
        End;

        If Not blnConfirma Then
        Begin
          edtNumPed.Enabled := True;
          Result := False;
          Exit;
        End;

        If blnUsarGiro Then
        Begin
          Result := fChamaCalculoGiro;
          If (Result) Then
            Exit;
        End;

      End;


      If Result Then
      Begin

        If Not blnNovoReg Then
        Begin
          If fMensagem('', 'Opção:', ['&Alterar', '&Imprimir']) = 1 Then
          Begin
            {*****************************************}
            {* CHAMA A TELA DE PEDIDO DE COMPRAS     *}
            {**************************************AF*}
            If (Not blnNovoReg) Or (Not blnUsarGiro) Then
            Begin
              If (strDocOri <> 'TE') And (strDocOri <> 'NF') Then
                pChamaTelaPedido
              Else
              Begin
                fMensagem('', 'Não é permitido alterar pedido de compra das filiais!', ['&O k']);
                edtNumPed.Enabled := True;
                exit;
              End;
            End;
          End
          Else
          Begin

            {*****************************************}
            {* IMPRIME PEDIDO DE COMPRA              *}
            {**************************************LU*}
            Try
              {*************************************************************************}
              {* CASO USE TINTA DE MAQUINA, NÃO PERGUNTA SE EXPORTA PARA SUVINIL/CORAL *}
              {* SENÃO VAI PARA A IMPRESSORA DIRETO.                                   *}
              {**********************************************************************LU*}
              Application.CreateForm(TfrmPedidoCompraImpr, frmPedidoCompraImpr);
              If (VS_strUsaTmq = 'N') Then
              Begin
                frmPedidoCompraImpr.Height := frmPedidoCompraImpr.Height - frmPedidoCompraImpr.gbOpcao.Height;
                frmPedidoCompraImpr.gbOpcao.Visible := False;
                intOpcao := 1;
              End
              Else
              Begin
                frmPedidoCompraImpr.Height := 338;
                frmPedidoCompraImpr.gbOpcao.Visible := True;
              End;

              frmPedidoCompraImpr.ShowModal;
              blnImprim := frmPedidoCompraImpr.blnImprim;
              blnImpRes := frmPedidoCompraImpr.blnImpRes;
              blnSemPre := frmPedidoCompraImpr.blnSemPre;
              blnOrdDig := frmPedidoCompraImpr.blnOrdDig;
              intOpcao  := frmPedidoCompraImpr.intOpcao;

            Finally
              pFreeAndNil(frmPedidoCompraImpr);
            End;

            If blnImprim Then
            Begin

              strNumPed := edtNumPed.Text;

              {****************************************}
              {* LOCALIZA A EMPRESA DESTINO DO PEDIDO *}
              {*************************************LU*}
              strEmpDes := fRetornaEmpresaDestino(strNumPed, strEspDoc, edtCodEmpresa.Text);
              If fEmptyStr(strEmpDes) Then
                strEmpDes := VS_strCodEmp;

              Case intOpcao Of
                1: Begin
                     Try
                       frmModuloPcmGer.pImprimePedidoCompra(strNumPed, strEspDoc, blnSemPre, blnOrdDig, blnImpRes);
                     Except
                     End;
                   End;

                2: Begin
                     qryGen := fCriaQuery(Self);

                     Application.CreateForm(TfrmPedidoCompraTXT, frmPedidoCompraTXT);
                     frmPedidoCompraTXT.intOpcao := intOpcao;
                     frmPedidoCompraTXT.ShowModal;
                     strPathArq := frmPedidoCompraTXT.strPathArq;
                     pFreeAndNil(frmPedidoCompraTXT);

                     {*****************************************}
                     {* GERA ARQUIVO PEDIDO DE COMPRA SUVINIL *}
                     {**************************************LB*}
                     strArqSuv := strPathArq + '\' +
                                  'synex_' + fCfgSis('SHORTS') + '_001_' +
                                  'basf_001_' + FormatDateTime('ddmmyyyy',VS_Date) + '_' +
                                  FormatDateTime('hhmmss',Time) + '.cli';

                     lstTexto := TStringList.Create;

                     {******************************}
                     {* CARREGA OS DADOS DO PEDIDO *}
                     {***************************LU*}
                     fCarregaPedCom(StrToInt(edtNumPed.Text), strEspDoc);

                     {***************************************}
                     {* ITP - CABEÇALHO DO ARQVUIVO SUVINIL *}
                     {************************************LB*}
                     strLinha := '';
                     strLinha := strLinha + 'ITP';                                                                                    //001..003
                     strLinha := strLinha + '001';                                                                                    //004..006
                     strLinha := strLinha + fPadR(fCfgSis('CDINTS',varString,strEmpDes),8);                                           //007..014
                     strLinha := strLinha + fPadR(fCadEmpDes('NOMEMP',strEmpDes),25);                                                 //015..039
                     strLinha := strLinha + fPadR(fCadEmpDes('C_G_C_',strEmpDes),15);                                                 //040..054
                     strLinha := strLinha + fPadR(fCadEmpDes('I_E_S_',strEmpDes),15);                                                 //055..069
                     strLinha := strLinha + fPadR(fCadEmpDes('ENDERE',strEmpDes) + ', ' + fCadEmpDes('ENDNUM',strEmpDes),50);         //070..119
                     strLinha := strLinha + fPadR(fCadEmpDes('BAIRRO',strEmpDes),30);                                                 //120..149
                     strLinha := strLinha + fPadR(fCadEmpDes('NOMCID',strEmpDes),25);                                                 //150..174
                     strLinha := strLinha + fPadR(fCadEmpDes('ESTADO',strEmpDes),2);                                                  //175..176
                     strLinha := strLinha + fPadR(fTiraCaracEspeciais(fCadEmpDes('C_E_P_',strEmpDes)),8);                             //177..184
                     strLinha := strLinha + fPadR('',8);                                                                              //185..193
                     strLinha := strLinha + fPadR(fRetNomFornecedor(frmModuloPcmGer.qryPcmGer.FieldByName('PCG_CODFOR').AsString),25);//194..216
                     strLinha := strLinha + fPadR(fCadFor('C_G_C_',frmModuloPcmGer.qryPcmGer.FieldByName('PCG_CODFOR').AsString),15); //217..231
                     strLinha := strLinha + fPadR(fCadFor('I_E_S_',frmModuloPcmGer.qryPcmGer.FieldByName('PCG_CODFOR').AsString),15); //232..246

                     lstTexto.Add(strLinha);

                     {********************************}
                     {* AE1 - PEDIDO ARQUIVO SUVINIL *}
                     {*****************************LB*}
                     strDtaPed := frmModuloPcmGer.qryPcmGer.FieldByName('PCG_DTAPED').AsString;
                     strDtaPed := FormatDateTime('yyyymmdd',StrToDate(strDtaPed));
                     strCndPag := fFormataCondPag(frmModuloPcmGer.qryPcmGer.FieldByName('PCG_CONPAG').AsString);
                     strCndPag := AnsiReplaceStr(strCndPag, '(', '');
                     strCndPag := AnsiReplaceStr(strCndPag, ')', '/');
                     strCndPag := AnsiReplaceStr(strCndPag, '.', '/');

                     strLinha := '';
                     strLinha := strLinha + 'AE1';                                    //001..003
                     strLinha := strLinha + fPadL(strNumPed,20);                      //004..023
                     strLinha := strLinha + fPadR(strDtaPed,8);                       //024..031
                     strLinha := strLinha + fPadR('',15);                             //032..046
                     strLinha := strLinha + fPadR(fCadEmpDes('C_G_C_',strEmpDes),15); //047..061
                     strLinha := strLinha + fPadR('',15);                             //062..076
                     strLinha := strLinha + fPadR(fCadEmpDes('C_G_C_',strEmpDes),15); //077..091
                     strLinha := strLinha + fPadR('',15);                             //092..106
                     strLinha := strLinha + fPadR(fCadEmpDes('C_G_C_',strEmpDes),15); //107..121
                     strLinha := strLinha + fPadR(strCndPag,30);                      //122..151
                     strLinha := strLinha + fPadR('',200);                            //152..351
                     lstTexto.Add(strLinha);

                     {*****************************************}
                     {* AE2 - ITENS DO PEDIDO ARQUIVO SUVINIL *}
                     {**************************************LB*}
                     strSQL := '';
                     strSQL := strSQL + ' SELECT ';
                     strSQL := strSQL + '   PCD_QTDITE, ';
                     strSQL := strSQL + '   PCD_UNITAR, ';
                     strSQL := strSQL + '   ITE_CODFAB, ';
                     strSQL := strSQL + '   ITE_CODBAR ';
                     strSQL := strSQL + ' FROM ';
                     strSQL := strSQL + '   PCMDET ';
                     strSQL := strSQL + '   JOIN CADITE ON (PCD_CODITE=ITE_CODITE) ';
                     strSQL := strSQL + ' WHERE ';
                     strSQL := strSQL + '   PCD_NUMPED = :NUMPED AND ';
                     strSQL := strSQL + '   PCD_ESPDOC = :ESPDOC AND ';
                     strSQL := strSQL + '   PCD_CODEMP = :CODEMP ';

                     With qryGen do
                     Begin
                       Close;
                       SQL.Clear;
                       SQL.Add(strSQL);
                       ParamByName('NUMPED').AsString := strNumPed;
                       ParamByName('ESPDOC').AsString := strEspDoc;
                       ParamByName('CODEMP').AsString := edtCodEmpresa.Text;
                       Open;

                       First;
                       intContador := 0;
                       While Not Eof Do
                       Begin

                         fltQtdIte := Int(FieldByName('PCD_QTDITE').AsFloat);
                         fltUnitar := fFormataFloat(FieldByName('PCD_UNITAR').AsFloat, 2);
                         strUnitar := AnsiReplaceStr(FloatToStrF(fltUnitar, ffFixed, 12, 2), ',', '.');

                         Inc(intContador);
                         strLinha := '';
                         strLinha := strLinha + 'AE2';                                        //001..003
                         strLinha := strLinha + fPadL(strNumPed,20, '0');                     //004..023
                         strLinha := strLinha + fPadL(IntToStr(intContador),8, '0');          //024..031
                         strLinha := strLinha + fPadR('',15);                                 //032..046
                         strLinha := strLinha + fPadR('',15);                                 //047..061
                         strLinha := strLinha + fPadR(FieldByName('ITE_CODFAB').AsString,15); //062..076
                         strLinha := strLinha + fPadR(FieldByName('ITE_CODBAR').AsString,15); //077..091
                         strLinha := strLinha + fPadL(FloatToStr(fltQtdIte),12, '0');         //092..103
                         strLinha := strLinha + fPadL(strUnitar,8, '0');                      //104..111
                         strLinha := strLinha + fPadR('',20);                                 //112..131
                         strLinha := strLinha + '00.00';                                      //132..136
                         strLinha := strLinha + fPadR('',200);                                //137..336

                         lstTexto.Add(strLinha);
                         Next;
                       End;

                       lstTexto.SaveToFile(strArqSuv);
                       fMensagem('','Arquivo gerado com sucesso!',['&OK']);

                       fFecharTabela(frmModuloPcmGer.qryPcmGer);
                       FreeAndNil(lstTexto);
                     End;
                     FreeAndNil(qryGen);
                   End;

                3: Begin
                     qryGen := fCriaQuery(Self);

                     Application.CreateForm(TfrmPedidoCompraTXT, frmPedidoCompraTXT);
                     frmPedidoCompraTXT.intOpcao := intOpcao;
                     frmPedidoCompraTXT.ShowModal;
                     strPathArq := frmPedidoCompraTXT.strPathArq;
                     pFreeAndNil(frmPedidoCompraTXT);

                     {******************************}
                     {* CARREGA OS DADOS DO PEDIDO *}
                     {***************************LU*}
                     fCarregaPedCom(StrToInt(edtNumPed.Text), strEspDoc);

                     {***************************************}
                     {* GERA ARQUIVO PEDIDO DE COMPRA CORAL *}
                     {************************************LB*}
                     {**************************************************}
                     {* SE O CAMPO CFG_SEQCOR NO BANCO FOR NULO OU     *}
                     {* A DATA DO DIA FOR DIFERENTE A QUE ESTA         *}
                     {* GRAVADA nO BANCO O CONTADOR DO ARQUIVO É ZERADO*}
                     {***********************************************LB*}
                     fLock_Unlock('Coral Imobiliaria',True);

                     If fEmptyStr(fCfgSis('SQCORC')) Then
                     Begin
                       intSeqCor := 0;
                       fAtuCfgSis('SQCORC',IntToStr(intSeqCor));
                     End;

                     If fCfgSis('DTASQC') <> FormatDateTime('yyyy/mm/dd',VS_Date) Then
                     Begin
                       fAtuCfgSis('DTASQC',FormatDateTime('yyyy/mm/dd',VS_Date));
                       intSeqCor := 0;
                       fAtuCfgSis('SQCORC',IntToStr(intSeqCor));
                     End;

                     intSeqCor := StrToInt(fCfgSis('SQCORC'));
                     Inc(intSeqCor);
                     fAtuCfgSis('SQCORC',IntToStr(intSeqCor));

                     fLock_Unlock('Coral Imobiliaria',False);

                     {********************}
                     {* CRIA ARQUIVO TXT *}
                     {*****************LB*}
                     strArqCoral := strPathArq + '\' + 'PEDI' + FormatDateTime('ddmm',VS_Date) + fCfgSis('SQCORC') + '.TXT' ;

                     strDtaPed := frmModuloPcmGer.qryPcmGer.FieldByName('PCG_DTAPED').AsString;
                     strDtaPed := FormatDateTime('yyyymmdd',StrToDate(strDtaPed));
                     strDtaEnt := frmModuloPcmGer.qryPcmGer.FieldByName('PCG_DTAENT').AsString;
                     strDtaEnt := FormatDateTime('yyyymmdd',VS_Date);

                     lstTexto := TStringList.Create;

                     strLinha := '';
                     strLinha := strLinha + fPadR(fCadEmpDes('NOMEMP',strEmpDes),40);
                     strLinha := strLinha + FormatDateTime('yyyymmdd',VS_Date);
                     strLinha := strLinha + FormatDateTime('hh:mm:ss',Time);

                     lstTexto.Add(strLinha);

                     {***********************************}
                     {* 01 - CABEÇALHO DO ARQUIVO CORAL *}
                     {********************************LB*}
                     strLinha := '';
                     strLinha := strLinha + '01';                                                     //001..002
                     strLinha := strLinha + fPadR('PEDEDI',8);                                        //003..010
                     strLinha := strLinha + 'I';                                                      //011..011
                     strLinha := strLinha + fPadR(strNumPed,20);                                      //012..031
                     strLinha := strLinha + fPadR(strDtaPed,8);                                       //032..039
                     strLinha := strLinha + fPadR(strDtaEnt,8);                                       //040..047
                     strLinha := strLinha + fPadR(fCfgSis('EANCLI'),13);                              //048..060
                     strLinha := strLinha + fPadR(fCfgSis('EANCLI'),13);                              //061..073
                     strLinha := strLinha + fPadR(fCfgSis('EANCLI'),13);                              //074..086
                     strLinha := strLinha + fpadR(fCfgSis('CNPJRC'),14);                              //087..100
                     strLinha := strLinha + fPadR(fCfgSis('CNPJRC'),14);                              //101..114
                     strLinha := strLinha + fpadR(fCfgSis('CNPJRC'),14);                              //115..128
                     strLinha := strLinha + fPadR('',120);                                            //129..248
                     strLinha := strLinha + fpadR('',96);                                             //249..344

                     lstTexto.Add(strLinha);

                     {************************}
                     {* 02 - ITENS DO PEDIDO *}
                     {*********************LB*}
                     strSQL := '';
                     strSQL := strSQL + ' SELECT ';
                     strSQL := strSQL + '   PCD_QTDITE, ';
                     strSQL := strSQL + '   PCD_UNITAR, ';
                     strSQL := strSQL + '   ITE_CODFAB, ';
                     strSQL := strSQL + '   ITE_CODBAR ';
                     strSQL := strSQL + ' FROM ';
                     strSQL := strSQL + '   PCMDET ';
                     strSQL := strSQL + '   JOIN CADITE ON (PCD_CODITE=ITE_CODITE) ';
                     strSQL := strSQL + ' WHERE ';
                     strSQL := strSQL + '   PCD_NUMPED = :NUMPED AND ';
                     strSQL := strSQL + '   PCD_ESPDOC = :ESPDOC AND ';
                     strSQL := strSQL + '   PCD_CODEMP = :CODEMP ';

                     With qryGen do
                     Begin
                       Close;
                       SQL.Clear;
                       SQL.Add(strSQL);
                       ParamByName('NUMPED').AsString := strNumPed;
                       ParamByName('ESPDOC').AsString := strEspDoc;
                       ParamByName('CODEMP').AsString := edtCodEmpresa.Text;
                       Open;
                       First;

                       While Not EOF Do
                       Begin
                         strLinha := '';
                         strLinha := strLinha + '02';                                                        //001..002
                         strLinha := strLinha + fPadR('ITEEDI',8);                                           //003..010
                         strLinha := strLinha + 'I';                                                         //011..011
                         strLinha := strLinha + fPadR(fCfgSis('EANCLI'),13);                                  //012..024
                         strLinha := strLinha + fPadR(fCfgSis('CNPJRC'),14);                                  //025..038
                         strLinha := strLinha + fPadR(strNumPed,20);                                         //039..058
                         strLinha := strLinha + fStrZero(fCfgSis('SQCORC'),3);                                //059..061
                         strLinha := strLinha + fPadR(FieldByName('ITE_CODBAR').AsString,13);                //062..074
                         strLinha := strLinha + fValNumForm(FieldByName('PCD_QTDITE').AsFloat,6);            //075..080

                         lstTexto.Add(strLinha);
                         Next;
                       End;

                       lstTexto.SaveToFile(strArqCoral);
                       fMensagem('','Arquivo gerado com sucesso!',['&OK']);

                       fFecharTabela(frmModuloPcmGer.qryPcmGer);
                       FreeAndNil(lstTexto);
                     End;
                     FreeAndNil(qryGen);
                   End;
              End; // fim do case

            End;
            edtNumPed.Clear;
            edtNumPed.Enabled := True;

          End;
        End
        Else
        Begin

          {*****************************************}
          {* CHAMA A TELA DE PEDIDO DE COMPRAS     *}
          {**************************************MV*}
          If (Not blnNovoReg) Or (Not blnUsarGiro) Then
            pChamaTelaPedido;

        End;

      End;
      Result := False;

    End

    Else If (Sender = edtCodEmpresa) Then
    Begin
      If (fEmptyStr(edtCodEmpresa.Text)) Then
        edtDesEmpresa.Text := 'TODAS'
      Else
      Begin
        pCarregaEmpresa;
        If (fEmptyStr(edtDesEmpresa.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa não encontrada!', ['&Ok']);
          Result := False;
        End;
      End;
    End;

  End;

  If Not Result Then
  Begin
    If (Sender.Enabled) And (Sender.Visible) Then
      Sender.SetFocus;
  End;

end;

function TfrmMenuPedCom.fCarregaPedCom(intNumPed: Integer;
  strEspDoc: String): Boolean;
begin

  Result := True;
  With frmModuloPcmGer.qryPcmGer Do
  Begin
    Close;
    ParamByName('NUMPED').AsString := edtNumPed.Text;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('CODEMP').AsString := strCodEmp;
    Open;

    If IsEmpty Then
      Result := False;
  End;

end;

procedure TfrmMenuPedCom.pEscapePressed;
begin
  If (ActiveControl = edtNumPed) Then
  Begin
    //rdgOpcoes.SetFocus;
    SelectNext(edtNumPed, False, True);
  End
  Else
  Begin
    inherited;
  End;
end;

procedure TfrmMenuPedCom.edtNumPedKeyPress(Sender: TObject; var Key: Char);
  Var
    stlIndicePed, stlDesIndPed: TStringList;
    strSQL    : String;
    strEspDoc : String;
    strFormAnt: String;
    qryConGen : TUniQuery;

    blnFiltraTecla: Boolean;
    intMinDigitos : Integer;
    blnIniciaVazio: Boolean;
begin
  inherited;

  qryConGen := fCriaQuery;

  If fEntraCons(Key) Then
  Begin
    stlIndicePed := TStringList.Create;
    stlDesIndPed := TStringList.Create;

    Key := #0;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  PCG_NUMPED AS "Pedido", ';
    strSQL := strSQL + '  PCG_CODEMP AS "Emp.", ';
    strSQL := strSQL + '  PCG_ESPDOC AS "Espécie", ';
    strSQL := strSQL + '  PCG_CODFOR AS "Cód. Forn.", ';
    strSQL := strSQL + '  FOR_NOMFOR AS "Fornecedor", ';
    strSQL := strSQL + '  PCG_DTAENT AS "Dta. Ped.", ';
    strSQL := strSQL + '  PCG_DTAPED AS "Dta. Entrega", ';
    strSQL := strSQL + '  PCG_CONPAG AS "Cond. Pagto.", ';
    strSQL := strSQL + '  FORMAT(PCG_TOTITE, 2) AS "Total Itens", ';
    strSQL := strSQL + '  FORMAT(PCG_TOTIPI, 2) AS "Total IPI", ';
    strSQL := strSQL + '  FORMAT(PCG_TOTSUB, 2) AS "Total SUB", ';
    strSQL := strSQL + '  FORMAT(PCG_TOTGER, 2) AS "Total Pedido", ';
    strSQL := strSQL + '  PCMGER.AUTOINCREM AS "AUTOINCREM", ';
    strSQL := strSQL + '  FORMAT(SUM((PCD_QTDITE * ';
    strSQL := strSQL + '      (SELECT UNI_PESLIT ';
    strSQL := strSQL + '       FROM CADUNI ';
    strSQL := strSQL + '       JOIN CADITE ON (UNI_CODUNI=ITE_CODUNI) ';
    strSQL := strSQL + '       WHERE ITE_CODITE = PCD_CODITE))),2) AS "Litragem", ';
    strSQL := strSQL + '  PCG_DOCORI AS "Doc. Orig.", ';
    strSQL := strSQL + '  IF(PCG_EMPDES IS NULL, "", PCG_EMPDES) AS "Emp. Destino" ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  PCMGER, ';
    strSQL := strSQL + '  CADFOR, ';
    strSQL := strSQL + '  PCMDET ';
    strSQL := strSQL + 'WHERE ';

    If rdgOpcoes.ItemIndex = 0 Then
    Begin
      strSQL    := strSQL + '  PCG_ESPDOC = "PD" ';
      strEspDoc := 'PD';
    End
    Else
    Begin
      strSQL    := strSQL + '  PCG_ESPDOC = "OR" ';
      strEspDoc := 'OR';
    End;

    strSQL := strSQL + '  AND PCG_NUMCTN = 0 ';
    strSQL := strSQL + '  AND FOR_CODFOR = PCG_CODFOR ';
    strSQL := strSQL + '  AND PCG_NUMPED = PCD_NUMPED ';
    strSQL := strSQL + '  AND (PCG_BAIXAD = FALSE OR PCG_BAIXAD IS NULL) ';

    If Not fEmptyStr(edtCodEmpresa.Text) Then
      strSQL := strSQL + '  AND PCG_CODEMP  = ' + QuotedStr(edtCodEmpresa.Text) + ' ';

    strSQL := strSQL + '  GROUP BY PCG_NUMPED, PCG_ESPDOC, PCG_CODEMP ';

    stlIndicePed.Add('PCG_NUMPED');
    stlIndicePed.Add('PCG_DTAPED+PCG_CODFOR');
    stlIndicePed.Add('FOR_NOMFOR');
    stlIndicePed.Add('PCG_DOCORI');
    stlIndicePed.Add('PCG_EMPDES');

    stlDesIndPed.Add('Pedido');
    stlDesIndPed.Add('Dta. Ped./Cód. Forn.');
    stlDesIndPed.Add('Fornecedor');
    stlDesIndPed.Add('Doc. Orig.');
    stlDesIndPed.Add('Emp. Destino');

    strFormAnt := Self.Name;
    Self.Name := Self.Name + strEspDoc;
    utcRegistros.Limpar(Self.Name + 'frmConsultaPedidoCompra' + 'PCMGER');

    If (fCfgSis('PDPACO', varInteger) = 1) Then
    Begin
      blnFiltraTecla := True;
      intMinDigitos  := -1;
      blnIniciaVazio := False;
    End
    Else
    Begin
      blnFiltraTecla := False;
      intMinDigitos  := 1;
      blnIniciaVazio := False;
    End;

    Application.CreateForm(TfrmConsultaPedidoCompra, frmConsultaPedidoCompra);
    frmConsultaPedidoCompra.strCodEmp  := edtCodEmpresa.Text;
    frmConsultaPedidoCompra.strEspecie := strEspDoc;

    If pConsultaEspecifica(Self, frmConsultaPedidoCompra, qryConGen,
      'PCMGER', strSQL, stlIndicePed, stlDesIndPed, '', blnFiltraTecla, True, intMinDigitos, blnIniciaVazio) Then
    Begin
      edtNumPed.Text     := qryConGen.FieldByName('PCG_NUMPED').AsString;
      edtCodEmpresa.Text := qryConGen.FieldByName('PCG_CODEMP').AsString;

      If fEmptyStr(edtCodEmpresa.Text) Then
      Begin
        edtCodEmpresa.Text := VS_strCodEmp;
      End;

      strDocOri := copy(qryConGen.FieldByName('PCG_DOCORI').AsString,7,2);
      strCodEmp := edtCodEmpresa.Text;
      edtDesEmpresa.Text := fRetNomeEmpresa(strCodEmp);
    End;

    pFreeAndNil(frmConsultaPedidoCompra);

    Self.Name := strFormAnt;

    FreeAndNil(stlIndicePed);
    FreeAndNil(stlDesIndPed);
  End;
end;

function TfrmMenuPedCom.fChamaCalculoGiro: Boolean;
  Var
    intQtdMes: Integer;
    strFilGir: String;
begin

  intQtdMes := 0;

  Try
    Application.CreateForm(TfrmDigGiroEstoque, frmDigGiroEstoque);
    frmDigGiroEstoque.showModal;
  Finally
    strCodGru := frmDigGiroEstoque.strCodGru;
    strCodFor := frmDigGiroEstoque.strCodFor;
    strCodMar := frmDigGiroEstoque.strCodMar;
    intQtdDia := frmDigGiroEstoque.intQtdDia;
    intOpcGir := frmDigGiroEstoque.intOpcGir;
    strFilGir := frmDigGiroEstoque.edtFilGir.Text;
    blnAllIte := frmDigGiroEstoque.blnAllIte;
    blnArredSug := frmDigGiroEstoque.chkArredQtdeSugest.Checked;
    blnConsMCom := frmDigGiroEstoque.chkMultCompra.Checked;
    blnConsTLoj := frmDigGiroEstoque.chkTdsLojas.Checked;
    blnConsEMin := frmDigGiroEstoque.chkEstMin.Checked;
    intOrdem  := frmDigGiroEstoque.intOrdem;
    Result    := frmDigGiroEstoque.blnConfirma;

    pFreeAndNil(frmDigGiroEstoque);
  End;

  If Result Then
  Begin

    pnlNomeForm.Width := 86;
    pnlInfo.Width     := 197;
    rdgOpcoes.Enabled := False;
    btnHeranca.Enabled := False;
    btnCarrTxtFornecedor.Enabled := False;
    pnlInfo.Caption   := 'Aguarde, calculando giro de estoque...';

    If intOpcGir = GIR_03MESES Then
      intQtdMes := 03
    Else if intOpcGir = GIR_06MESES Then
      intQtdMes := 06
    Else If intOpcGir = GIR_12MESES Then
      intQtdMes := 12;

    {*****************************************}
    {* CRIA A TABELA TEMPORARIA PARA O GIRO  *}
    {**************************************MV*}
    Result := fCriarTmpPedCom(intQtdMes);

    If Result Then
    Begin
      {*****************************************}
      {* CALCULA O GIRO DE ESTOQUE             *}
      {**************************************MV*}
      fCalculaGiroDeEstoque(strCodGru, strCodFor, strCodMar, intQtdDia, intOpcGir,
        strFilGir, intMesGir, blnAllIte, blnArredSug, blnConsMCom, blnConsTLoj, blnConsEMin, intOrdem);
      pChamaTelaPedido;
    End;

    rdgOpcoes.Enabled := True;
    btnHeranca.Enabled := True;
    btnCarrTxtFornecedor.Enabled := True;
    rdgOpcoes.SetFocus;

  End
  Else
  Begin
    edtNumPed.Enabled := True;
    blnUsarGiro := False;
  End;

end;

procedure TfrmMenuPedCom.pChamaTelaPedido;
begin

  pnlInfo.Caption   := '';
  pnlNomeForm.Width := 138;
  pnlInfo.Width     := 149;

  If fEmptyStr(strCodEmp) Then
    strCodEmp := VS_strCodEmp;

  Try
    Application.CreateForm(TfrmPedidoCompra, frmPedidoCompra);
    frmPedidoCompra.blnNovoReg     := blnNovoReg;
    frmPedidoCompra.blnModoHeranca := (btnHeranca.Tag = 1);
    frmPedidoCompra.strNumPed      := edtNumPed.Text;
    frmPedidoCompra.strEspDoc      := strEspDoc;
    frmPedidoCompra.intMesGir      := intMesGir;
    frmPedidoCompra.intDiaCom      := intQtdDia;
    frmPedidoCompra.blnUsarGiro    := blnUsarGiro;
    frmPedidoCompra.blnConsMCom    := blnConsMCom;
    frmPedidoCompra.blnArredSug    := blnArredSug;
    frmPedidoCompra.stlArquivos    := lstArquivos;
    frmPedidoCompra.strCodEmp      := strCodEmp;
    frmPedidoCompra.intOrdem       := intOrdem;
    frmPedidoCompra.strPedMlj      := strPedMlj;
    frmPedidoCompra.showModal;
  Finally
    pFreeAndNil(frmPedidoCompra);
  End;
  edtNumPed.Clear;

  fDeletaTmpPedCom;
  edtNumPed.Enabled := True;
  blnUsarGiro := False;
  intMesGir := 0;
  intQtdDia := 0;
end;

procedure TfrmMenuPedCom.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_F3) Then
  Begin
    btnHeranca.Click;
  End
  Else If (Key = VK_F5) Then
  Begin
    btnCarrTxtFornecedor.Click;
  End
  Else If (Key = VK_ESCAPE) Then
  Begin
    If (ActiveControl <> Nil) And (ActiveControl.Name = '') Then
    Begin
      Close;
    End;
  End
  Else If (Key = VK_RETURN) Then
  Begin
    If (ActiveControl <> Nil) And (ActiveControl.Name = '') Then
    Begin
      If edtCodEmpresa.Enabled Then
        edtCodEmpresa.SetFocus
      Else
        edtNumPed.SetFocus;
    End;
  End;

end;

procedure TfrmMenuPedCom.btnHerancaClick(Sender: TObject);
begin
  inherited;
  
  If (Not rdgOpcoes.Enabled) Then
    Exit;

  If (btnHeranca.Tag = 0) Then
  Begin
    btnHeranca.Caption := AnsiReplaceStr(btnHeranca.Caption, 'INATIVO', 'ATIVO');
    btnHeranca.Tag := 1;
  End
  Else
  Begin
    btnHeranca.Caption := AnsiReplaceStr(btnHeranca.Caption, 'ATIVO', 'INATIVO');
    btnHeranca.Tag := 0;
  End;

  If edtCodEmpresa.Enabled Then
    edtCodEmpresa.SetFocus
  Else
  Begin
    If (edtNumPed.Enabled) Then
      edtNumPed.SetFocus;
  End;

end;

procedure TfrmMenuPedCom.OnIdle(Sender: TObject; var Done: Boolean);
begin

  If (rdgOpcoes.ItemIndex = 0) Then
  Begin
    lblPedOrc.Caption := 'Pedido para alterar:';
  End
  Else
  Begin
    lblPedOrc.Caption := 'Orçamento para alterar:';
  End;

end;

procedure TfrmMenuPedCom.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Application.OnIdle := Nil;
end;

function TfrmMenuPedCom.fVerificaNotImpEmitida(strNumPed, strEspDoc,
  strCodEmp: String): Boolean;
  Var
    strSQL   : String;
    qryGenGer: TUniQuery;

begin
  Try

    qryGenGer := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  COUNT(*) ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  PCMGER ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  PCG_NUMPED = :NUMPED AND ';
    strSQL := strSQL + '  PCG_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '  PCG_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  PCG_NUMCTN > 0 AND ';
    strSQL := strSQL + '  PCG_JAEMIT = 1 ';

    With qryGenGer Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMPED').AsString := strNumPed;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODEMP').AsString := strCodEmp;
      Open;
      Result := Fields[0].AsInteger > 0;
      Close;
    End;

  Finally
    FreeAndNil(qryGenGer);
  End;

end;

procedure TfrmMenuPedCom.btnCarrTxtFornecedorClick(Sender: TObject);
begin
  inherited;

  If (Not btnCarrTxtFornecedor.Enabled) Then
    Exit;

  rdgOpcoes.ItemIndex := 0;
  edtNumPed.Clear;

  Try
    Application.CreateForm(TfrmEntImportaPedFornc, frmEntImportaPedFornc);
    If (frmEntImportaPedFornc.ShowModal = mrOk) Then
    Begin
      lstArquivos := frmEntImportaPedFornc.stlArquivos;
    End
    Else
      If (Assigned(lstArquivos)) Then
        FreeAndNil(lstArquivos);
  Finally
    pFreeAndNil(frmEntImportaPedFornc);
  End;

  If (Assigned(lstArquivos)) Then
  Begin
    blnNovoReg := True;
    pChamaTelaPedido;
  End;

  If edtCodEmpresa.Enabled Then
    edtCodEmpresa.SetFocus
  Else
  Begin
    If (edtNumPed.Enabled) Then
      edtNumPed.SetFocus;
  End;

end;

procedure TfrmMenuPedCom.edtCodEmpresaKeyPress(Sender: TObject;
  var Key: Char);
  Var
    stlIndiceEmp: TStringList;
    stlDesIndEmp: TStringList;
    stlCamposEmp: TStringList;
    qryGenEmp   : TUniQuery;

begin
  inherited;

  If fEntraCons(Key) Then
  Begin
    stlIndiceEmp := TStringList.Create;
    stlDesIndEmp := TStringList.Create;
    stlCamposEmp := TStringList.Create;

    Key := #0;

    stlCamposEmp.Add('EMP_CODEMP');
    stlCamposEmp.Add('EMP_NOMEMP');
    stlCamposEmp.Add('AUTOINCREM');

    stlIndiceEmp.Add('EMP_NOMEMP');
    stlIndiceEmp.Add('EMP_CODEMP');
    stlDesIndEmp.Add('Nome');
    stlDesIndEmp.Add('Código');

    qryGenEmp := frmModuloCadEmp.qryCadEmp;
    If pConsultaRapida(Self, qryGenEmp, 'CADEMP', stlIndiceEmp, stlDesIndEmp, stlCamposEmp) Then
    Begin
      edtCodEmpresa.Text := qryGenEmp.FieldByName('EMP_CODEMP').AsString;
      If fEmptyStr(edtCodEmpresa.Text) Then
      Begin
        edtCodEmpresa.Text := VS_strCodEmp;
      End;
      Self.SelectNext(ActiveControl, True, True);
    End;

    pCarregaEmpresa;

    FreeAndNil(stlIndiceEmp);
    FreeAndNil(stlDesIndEmp);
    FreeAndNil(stlCamposEmp);
  End;

end;

procedure TfrmMenuPedCom.pCarregaEmpresa;
Begin
  If Not (fEmptyStr(edtCodEmpresa.Text)) Then
    edtDesEmpresa.Text := fRetNomeEmpresa(edtCodEmpresa.Text)
  Else
    edtDesEmpresa.Text := '';
End;

procedure TfrmMenuPedCom.edtCodEmpresaExit(Sender: TObject);
begin
  inherited;
  strCodEmp := edtCodEmpresa.Text;
end;

function TfrmMenuPedCom.fComparaEmpresa: Boolean;
begin

  Result := True;

  If (VS_strCodEmp <> edtCodEmpresa.Text) Then
  Begin
    fMensagem('ATENÇÃO!', 'A Empresa do Pedido deverá ser a mesma do Sistema!', ['&O k']);
    edtNumPed.Enabled := True;
    Result := False;
  End;

end;

function TfrmMenuPedCom.fRetornaEmpresaDestino(strNumPed, strEspDoc, strCodEmp: String): String;
Var
  strSQL: String;
  qryGen: TUniQuery;
begin
  Try

    qryGen := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  PCG_EMPDES ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  PCMGER ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  PCG_NUMPED = :NUMPED AND ';
    strSQL := strSQL + '  PCG_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '  PCG_CODEMP = :CODEMP ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMPED').AsString := strNumPed;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODEMP').AsString := strCodEmp;
      Open;
      Result := Fieldbyname('PCG_EMPDES').AsString;
      Close;
    End;

  Finally
    FreeAndNil(qryGen);
  End;

end;


end.

