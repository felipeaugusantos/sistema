{******************************************}
{* EXPORTAÇÃO DE ARQUIVOS - ACACIA SERVER *}
{***************************************LU*}

unit untTxtACACIAServer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, Uni, UniClientDataSet,
  UniDataSetProvider, Mask, DirectoryEditFocus, ClipBrd, ComCtrls, BitBtnLockedIncrem,
  frxClass, frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit, 
  untFrameDirectoryEditFocus;

type
  TfrmTxtACACIAServer = class(TfrmPai)
    Panel1: TPanel;
    chkAti: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label10: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label16: TLabel;
    chkCid: TSpeedButton;
    chkCli: TSpeedButton;
    chkMar: TSpeedButton;
    chkPro: TSpeedButton;
    chkReg: TSpeedButton;
    chkStC: TSpeedButton;
    chkStP: TSpeedButton;
    chkTit: TSpeedButton;
    chkTPe: TSpeedButton;
    chkTPr: TSpeedButton;
    SpeedButton13: TSpeedButton;
    chkGru: TSpeedButton;
    chkFPG: TSpeedButton;
    chkCnd: TSpeedButton;
    Label17: TLabel;
    tmrFecha: TTimer;
    pgbProgresso: TProgressBar;
    btnConfirma: TBitBtnLocked;
    dirPathExp: TfraDirectoryEditFocus;
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure tmrFechaTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;Override;    

  private
    { Private declarations }
    strPath: String;

    qryGenerica: TUniQuery;
    dspGenerica: TUniDataSetProvider;
    cdsGenerica: TUniClientDataSet;

    qryProduto: TUniQuery;
    dspProduto: TUniDataSetProvider;
    cdsProduto: TUniClientDataSet;

    qryCliente: TUniQuery;
    dspCliente: TUniDataSetProvider;
    cdsCliente: TUniClientDataSet;

    qryNotaFiscal: TUniQuery;
    dspNotaFiscal: TUniDataSetProvider;
    cdsNotaFiscal: TUniClientDataSet;

    qryPedido: TUniQuery;
    dspPedido: TUniDataSetProvider;
    cdsPedido: TUniClientDataSet;

    qryCndPgto: TUniQuery;
    dspCndPgto: TUniDataSetProvider;
    cdsCndPgto: TUniClientDataSet;

    qryItensPromocao: TUniQuery;    

    blnGerou: Boolean;        

    procedure pExp_Atividades;
    procedure pExp_Cidades;
    procedure pExp_Clientes;
    procedure pExp_ClienteNotaFiscal(strCodCli: String);
    procedure pExp_ClientePedido(strCodCli: String);
    procedure pExp_Marcas;
    procedure pExp_Produtos;
    procedure pExp_Regioes;
    procedure pExp_StatusCliente;
    procedure pExp_StatusProduto;
    procedure pExp_CondicaoPagto;
    procedure pExp_FormaPagto;
    procedure pExp_FormaCondPgto;
    procedure pExp_GrupoProduto;
    procedure pExp_TipoPedido;
    procedure pExp_TituloAberto;

    function fRetNroParcela(strParcel: String): String;
    procedure pCriaQueryPromocoes;
    procedure pProgresso(intPos, intMax: Integer);    
  public
    { Public declarations }
    {*******************************************************************}
    {* VARIAVEIS UTILIZADAS PARA OS ARQUIVOS DE NOTA FISCAL DO CLIENTE *}
    {****************************************************************LU*}
    strNomArqNF : String;
    strNomArqNFI: String;
    strLinhaNF  : String;
    strLinhaNFI : String;
    lstTextoNF  : TStringList;
    lstTextoNFI : TStringList;
    {**************************************************************}
    {* VARIAVEIS UTILIZADAS PARA OS ARQUIVOS DE PEDIDO DO CLIENTE *}
    {***********************************************************LU*}
    strNomArqPD : String;
    strNomArqPDI: String;
    strLinhaPD  : String;
    strLinhaPDI : String;
    lstTextoPD  : TStringList;
    lstTextoPDI : TStringList;

    blnGeracaoAut: Boolean;
  end;

implementation

uses  untFuncoesSimples, DB, StrUtils,
      untModulo;

{$R *.dfm}

procedure TfrmTxtACACIAServer.btnConfirmaClick(Sender: TObject);
Var
  strHr_Ini : String;
  strHr_Fin : String;
begin
  inherited;

  If fVerificaCampos Then
  Begin

    btnConfirma.Enabled := False;
    btnSair.Enabled := False;
    dirPathExp.Enabled := False;
    pnlInfo.Caption := 'Aguarde, exportando arquivos...';
    strHr_Ini := FormatDateTime('hh:mm:ss', fTime());

    strPath := dirPathExp.edtDirectory.text;

    pCriaQueryPromocoes;

    pgbProgresso.Visible := True;

    {*************************************}
    {* INICIA A EXPORTAÇÃO DOS ARQUIVOS  *}
    {**********************************LU*}
    pExp_Atividades;
    pExp_Cidades;
    pExp_Clientes;
    pExp_Marcas;
    pExp_Produtos;
    pExp_Regioes;
    pExp_StatusCliente;
    pExp_StatusProduto;
    pExp_CondicaoPagto;
    pExp_FormaPagto;
    pExp_FormaCondPgto;
    pExp_GrupoProduto;
    pExp_TipoPedido;
    pExp_TituloAberto;

    strHr_Fin := FormatDateTime('hh:mm:ss', fTime());
    pnlInfo.Caption := 'Exportação gerada com sucesso!';

    If (Not blnGeracaoAut) Then
      fMensagem('','Exportação OK. - Início: ' + strHr_Ini + ' - Término: ' + strHr_Fin,['&OK']);

    btnConfirma.Enabled := True;
    btnSair.Enabled := True;
    dirPathExp.Enabled := True;
    pSetFocus(dirPathExp);
  End;

  pgbProgresso.Visible := False;  

end;

{*****************************************}
{* TABELA ACACIA: T_CANALCLIENTE         *}
{**************************************LU*}
procedure TfrmTxtACACIAServer.pExp_Atividades;
Var
  strSQL   : String;
  strNomArq: String;
  strLinha : String;
  lstTexto : TStringList;
Begin

  Try
    {*******************}
    {* NOME DO ARQUIVO *}
    {****************LU*}
    strNomArq := 'CANAL' + FormatDateTime('yyyyMMdd',VS_Date)  + FormatDateTime('hhmmss', fTime()) + '.TXT';

    strSQL := '';
    strSQL := strSQL + ' SELECT        ';
    strSQL := strSQL + '   ATI_CODATI, ';
    strSQL := strSQL + '   ATI_DESATI  ';
    strSQL := strSQL + ' FROM          ';
    strSQL := strSQL + '   CADATI      ';

    With qryGenerica Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
    End;

    dspGenerica.DataSet := qryGenerica;
    cdsGenerica.Close;
    cdsGenerica.SetProvider(dspGenerica);
    cdsGenerica.Open;

    With cdsGenerica Do
    Begin

      If Not IsEmpty Then
      Begin
        lstTexto := TStringList.Create;

        While Not Eof Do
        Begin
          Application.ProcessMessages;
          strLinha := fPadR(fieldbyname('ATI_CODATI').AsString,10) + '|' +  // codigo da atividade
                      fPadR(fieldbyname('ATI_DESATI').AsString,50) + '|' +  // descricao da atividade
                      '0'                                          + '|' +  // 0 - fixo (valor mínimo do pedido)
                      fPadR(fCfgSis('CODACA'),10)                  + '|';   // codigo empresa na ACACIA

          lstTexto.Add(strLinha);
          Next;
          pProgresso(RecNo, RecordCount);          
        End;

        lstTexto.SaveToFile(strPath + '\' + strNomArq);
        chkAti.Visible := True;
      End;

    End;

  Finally
    cdsGenerica.Close;

    If (lstTexto <> Nil) Then
      FreeAndNil(lstTexto);
  End;

End;

{*****************************************}
{* TABELA ACACIA: T_MUNICIPIO            *}
{**************************************LU*}
procedure TfrmTxtACACIAServer.pExp_Cidades;
Var
  strSQL   : String;
  strNomArq: String;
  strLinha : String;
  lstTexto : TStringList;
Begin

  Try
    {*******************}
    {* NOME DO ARQUIVO *}
    {****************LU*}
    strNomArq := 'MUNICIPIOS' + FormatDateTime('yyyyMMdd',VS_Date)  + FormatDateTime('hhmmss', fTime()) + '.TXT';

    strSQL := '';
    strSQL := strSQL + ' SELECT        ';
    strSQL := strSQL + '   CID_CODCID, ';
    strSQL := strSQL + '   CID_NOMCID, ';
    strSQL := strSQL + '   CID_ESTADO  ';
    strSQL := strSQL + ' FROM          ';
    strSQL := strSQL + '   CADCID      ';

    With qryGenerica Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
    End;

    dspGenerica.DataSet := qryGenerica;
    cdsGenerica.Close;
    cdsGenerica.SetProvider(dspGenerica);
    cdsGenerica.Open;

    With cdsGenerica Do
    Begin

      If Not IsEmpty Then
      Begin
        lstTexto := TStringList.Create;
        While Not Eof Do
        Begin
          Application.ProcessMessages;
          strLinha := fPadR(fieldbyname('CID_CODCID').AsString,100) + '|' +  // codigo da cidade
                      fPadR(fieldbyname('CID_NOMCID').AsString,100) + '|' +  // nome da cidade
                      fPadR(fieldbyname('CID_ESTADO').AsString,2)   + '|' +  // estado
                      '1'                                           + '|';   // 1 - fixo (indice financeiro)

          lstTexto.Add(strLinha);
          Next;
          pProgresso(RecNo, RecordCount);          
        End;

        lstTexto.SaveToFile(strPath + '\' + strNomArq);
        chkCid.Visible := True;
      End;

    End;

  Finally
    cdsGenerica.Close;

    If (lstTexto <> Nil) Then
      FreeAndNil(lstTexto);
  End;

End;

{*****************************************}
{* TABELA ACACIA: T_CLIENTE              *}
{**************************************LU*}
procedure TfrmTxtACACIAServer.pExp_Clientes;
Var
  strSQL      : String;

  strNomArqCli: String;
  strLinhaCli : String;
  lstTextoCli : TStringList;

  strNomArqCV : String;
  strLinhaCV  : String;
  lstTextoCV  : TStringList;

  strNomArqCont : String;
  strLinhaCont  : String;
  lstTextoCont  : TStringList;

  strNomArqLim : String;
  strLinhaLim  : String;
  lstTextoLim  : TStringList;
  strLimCre    : String;

  strNomArqEnd : String;
  strLinhaEnd  : String;
  lstTextoEnd  : TStringList;

  strCodCndAca: String;
  strCodCndCli: String;

//  strNomArqDesc : String;
//  strLinhaDesc  : String;
//  lstTextoDesc  : TStringList;

//  strNomArqComp : String;
//  strLinhaComp  : String;
//  lstTextoComp  : TStringList;

Begin

  Try
    strCodCndAca := fCfgSis('CNDACA');
    
    {**********************}
    {* NOMES DOS ARQUIVOS *}
    {*******************LU*}
    strNomArqCli := 'CLIENTES' + FormatDateTime('yyyyMMdd',VS_Date) + FormatDateTime('hhmmss', fTime()) + '.TXT';

    strNomArqNF  := 'NOTAFISCAL' + FormatDateTime('yyyyMMdd',VS_Date) + FormatDateTime('hhmmss',fTime()) + '.TXT';
    strNomArqNFI := 'ITENSNOTAFISCAL' + FormatDateTime('yyyyMMdd',VS_Date) + FormatDateTime('hhmmss',fTime()) + '.TXT';

    strNomArqPD  := 'HISTPEDIDO' + FormatDateTime('yyyyMMdd',VS_Date) + FormatDateTime('hhmmss',fTime()) + '.TXT';
    strNomArqPDI := 'HISTPEDITENS' + FormatDateTime('yyyyMMdd',VS_Date) + FormatDateTime('hhmmss',fTime()) + '.TXT';

    strNomArqCV   := 'CLIENTVEND' + FormatDateTime('yyyyMMdd',VS_Date) + FormatDateTime('hhmmss',fTime()) + '.TXT';
    strNomArqCont := 'CONTATOS' + FormatDateTime('yyyyMMdd',VS_Date) + FormatDateTime('hhmmss',fTime()) + '.TXT';
    strNomArqLim  := 'LIMITECLIENTE' + FormatDateTime('yyyyMMdd',VS_Date) + FormatDateTime('hhmmss',fTime()) + '.TXT';
    strNomArqEnd  := 'ENDERECOSCLIENTE' + FormatDateTime('yyyyMMdd',VS_Date) + FormatDateTime('hhmmss',fTime()) + '.TXT';
//    strNomArqDesc := 'DESCMARCA' + FormatDateTime('yyyyMMdd',VS_Date) + FormatDateTime('hhmmss',fTime()) + '.TXT';
//    strNomArqComp := 'COMPLCLIENTE' + FormatDateTime('yyyyMMdd',VS_Date) + FormatDateTime('hhmmss',fTime()) + '.TXT';

    strSQL := '';
    strSQL := strSQL + ' SELECT                                                                       ';
    strSQL := strSQL + '   CLI_CODCLI AS CODCLI,                                                      ';
    strSQL := strSQL + '   CLI_NOMCLI AS NOMCLI,                                                      ';
    strSQL := strSQL + '   CLI_C_G_C_ AS C_G_C_,                                                      ';
    strSQL := strSQL + '   CLI_I_E_S_ AS I_E_S_,                                                      ';
    strSQL := strSQL + '   CONCAT(CLI_ENDERE," ", IFNULL(CLI_ENDNUM,"")) AS ENDERE,                   ';
    strSQL := strSQL + '   C1.CID_CODCID AS CODCID,                                         ';
    strSQL := strSQL + '   C1.CID_ESTADO AS ESTADO,                                                   ';
    strSQL := strSQL + '   CLI_BAIRRO AS BAIRRO,                                                      ';
    strSQL := strSQL + '   CLI_FONE01 AS FONE01,                                                      ';
    strSQL := strSQL + '   CLI_F_A_X_ AS F_A_X_,                                                      ';
    strSQL := strSQL + '   CLI_C_E_P_ AS C_E_P_,                                                      ';
    strSQL := strSQL + '   IF(CLI_STATUS = "I", "002", "001") AS STATUS,                              ';
    strSQL := strSQL + '   CLI_FANSOB AS FANSOB,                                                      ';
    strSQL := strSQL + '   CLI_DTACAD AS DTACAD,                                                      ';
    strSQL := strSQL + '   CLI_CODATI AS CODATI,                                                      ';
    strSQL := strSQL + '   CLI_ULTCOM AS ULTCOM,                                                      ';
    strSQL := strSQL + fRetSQLCliCnd('CLI_CODCLI', True) + '                               AS CODCND, ';
    strSQL := strSQL + '   CONCAT(CLI_OBS_01," ",CLI_OBS_02," ",CLI_OBS_03," ",CLI_OBS_04) AS OBSERV, ';
    strSQL := strSQL + '   CLI_EMAIL_ AS EMAIL_,                                                      ';
    strSQL := strSQL + '   CLI_CODVEN AS CODVEN,                                                      ';
    strSQL := strSQL + '   CLI_CONTAT AS CONTAT,                                                      ';
    strSQL := strSQL + '   CLI_LIMCRE AS LIMCRE,                                                      ';

    strSQL := strSQL + '   ETC_ENDENT AS ENDENT,                                                      ';
    strSQL := strSQL + '   ETC_BAIENT AS BAIENT,                                                      ';
    strSQL := strSQL + '   ETC_CEPENT AS CEPENT,                                                      ';

    strSQL := strSQL + '   C2.CID_NOMCID AS CIDENT,                                                   ';
    strSQL := strSQL + '   CLI_ENDCOB AS ENDCOB,                                                      ';
    strSQL := strSQL + '   CLI_BAICOB AS BAICOB,                                                      ';
    strSQL := strSQL + '   CLI_CEPCOB AS CEPCOB,                                                      ';
    strSQL := strSQL + '   C3.CID_NOMCID AS CIDCOB,                                                   ';
    strSQL := strSQL + fRetSQLCliCnd('CLI_CODCLI', False) + '                              AS CNDPAG, ';
    strSQL := strSQL + '   CONCAT("00",CLI_TABPRE) AS TABPRE                                          ';
    strSQL := strSQL + ' FROM                                                                         ';
    strSQL := strSQL + '   CADCLI                                                                     ';
    strSQL := strSQL + '   LEFT JOIN ENTCLI ON ETC_CODCLI = CLI_CODCLI AND ';
    strSQL := strSQL + '                       ETC_SEQIND = (SELECT MIN(ETC_SEQIND) FROM ENTCLI WHERE ETC_CODCLI = CLI_CODCLI) ';
    strSQL := strSQL + '   LEFT JOIN CADCID C1 ON (CLI_CODCID=C1.CID_CODCID)                          ';
    strSQL := strSQL + '   LEFT JOIN CADCID C2 ON (ETC_CIDENT=C2.CID_CODCID)                          ';
    strSQL := strSQL + '   LEFT JOIN CADCID C3 ON (CLI_CIDCOB=C3.CID_CODCID)                          ';
    strSQL := strSQL + ' WHERE                                                                        ';
    strSQL := strSQL + '   CLI_CODCLI IS NOT NULL AND CLI_CODCLI <> ""                                ';

    With qryCliente Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
    End;

    dspCliente.DataSet := qryCliente;
    cdsCliente.Close;
    cdsCliente.SetProvider(dspCliente);
    cdsCliente.Open;

    With cdsCliente Do
    Begin

      If Not IsEmpty Then
      Begin
        lstTextoCli := TStringList.Create;
        lstTextoNF  := TStringList.Create;
        lstTextoNFI := TStringList.Create;
        lstTextoPD  := TStringList.Create;
        lstTextoPDI := TStringList.Create;
        lstTextoCV  := TStringList.Create;
        lstTextoCont:= TStringList.Create;
        lstTextoLim := TStringList.Create;
        lstTextoEnd := TStringList.Create;
//        lstTextoDesc:= TStringList.Create;
//        lstTextoComp:= TStringList.Create;

        While Not Eof Do
        Begin
          If (RecordCount mod 100) = 0 Then
            Application.ProcessMessages;

          strCodCndCli := FieldByName('CODCND').AsString;

          If fEmptyStr(strCodCndCli) Then
            strCodCndCli := strCodCndAca;

          strLinhaCli:= fPadR(fieldbyname('CODCLI').AsString,20)                                        + '|' +  // código do cliente
                        fPadR(fieldbyname('NOMCLI').AsString,100)                                       + '|' +  // razão social
                        fPadR(fieldbyname('C_G_C_').AsString,20)                                        + '|' +  // cgc
                        fPadR(fieldbyname('I_E_S_').AsString,20)                                        + '|' +  // ies
                        fPadR(fieldbyname('ENDERE').AsString,100)                                       + '|' +  // endereco
                        fPadR(fieldbyname('CODCID').AsString,100)                                       + '|' +  // código da cidade
                        fPadR(fieldbyname('ESTADO').AsString,50)                                        + '|' +  // estado
                        fPadR(fieldbyname('BAIRRO').AsString,80)                                        + '|' +  // bairro
                        fPadR(fieldbyname('FONE01').AsString,20)                                        + '|' +  // telefone
                        fPadR(fieldbyname('F_A_X_').AsString,20)                                        + '|' +  // fax
                        fPadR(fieldbyname('C_E_P_').AsString,10)                                        + '|' +  // cep
                        fPadR(fieldbyname('STATUS').AsString,10)                                        + '|' +  // Status - A-ativo, I-inativo, B-bloqueado
                        fPadR(fieldbyname('FANSOB').AsString,50)                                        + '|' +  // nome fantasia
                        '001'                                                                           + '|' +  // % desconto suframa
                        FormatDateTime('ddMMyyyy',fieldbyname('DTACAD').AsDateTime)                     + '|' +  // data cadastro
                        fPadR(' ',10)                                                                   + '|' +  // cód. endereco entrega
                        fPadR(' ',10)                                                                   + '|' +  // cód. regional
                        '001       '                                                                    + '|' +  // cód. região
                        fPadR(' ',3)                                                                    + '|' +  // condicao entrega
                        fPadR(fieldbyname('CODATI').AsString,10)                                        + '|' +  // cód. atividade
                        fPadR(' ',10)                                                                   + '|' +  // cód. sub-atividade
                        fPadR(' ',10)                                                                   + '|' +  // cód. checkout
                        fPadR(fieldbyname('TABPRE').AsString,10)                                        + '|' +  // tabela preco
                        FormatDateTime('ddMMyyyy',fieldbyname('ULTCOM').AsDateTime)                     + '|' +  // data ultima visita
                        FormatDateTime('ddMMyyyy',fieldbyname('ULTCOM').AsDateTime)                     + '|' +  // data ultima compra
                        fPadR(' ',10)                                                                   + '|' +  // cód. forma pagto
                        fPadR(fPadL(strCodCndCli, 5, '0'),10)                                           + '|' +  // cód. condicao pagto
                        fPadR(fieldbyname('CODCLI').AsString,20)                                        + '|' +  // código cliente pai
                        fPadR(' ',200)                                                                  + '|' +  // obs fech. faturamento
                        fPadR(fieldbyname('OBSERV').AsString,200)                                       + '|' +  // obs cliente
                        fPadR(' ',1)                                                                    + '|' +  // cód. pedido permitido
                        fPadR(fCfgSis('CODACA'),10)                                                     + '|' +  // codigo empresa na ACACIA
                        fPadR(fieldbyname('EMAIL_').AsString,100)                                       + '|' +  // e_mail
                        fPadL(FloatToStr(round(fCalcMediaPagto(fieldbyname('CNDPAG').AsString))),2,'0') + '|' +  // prazo médio
                        '        '                                                                      + '|' +  // data anivers. cliente
                        '        '                                                                      + '|';   // data jornal cliente

          lstTextoCli.Add(strLinhaCli);

          {*****************************************}
          {* TABELA ACACIA: TR_CLIENTEVENDEDOR     *}
          {**************************************LU*}
          strLinhaCV := fPadR(fieldbyname('CODCLI').AsString,20) + '|' + // codigo do cliente
                        fPadR(fieldbyname('CODVEN').AsString,10) + '|';  // código do vendedor
          lstTextoCV.Add(strLinhaCV);

          {*****************************************}
          {* TABELA ACACIA: T_CONTATO              *}
          {**************************************LU*}
          If (Not fEmptyStr(FieldByName('CONTAT').AsString)) Then
          Begin
            strLinhaCont := fPadR(fieldbyname('CODCLI').AsString,20) + '|' + // codigo do cliente
                            fPadR(fieldbyname('CONTAT').AsString,80) + '|' + // contato
                            fPadR(' ',50)                            + '|' + // hobby
                            fPadR(' ',50)                            + '|' + // clube
                            fPadR(' ',20)                            + '|' + // telefone
                            fPadR(' ',5)                             + '|' + // aniversario
                            fPadR(' ',50)                            + '|' + // cargo
                            fPadR(' ',250)                           + '|' + // e-mail
                            fPadR(fCfgSis('CODACA'),10)              + '|';  // codigo empresa na ACACIA
            lstTextoCont.Add(strLinhaCont);
          End;

          {*****************************************}
          {* TABELA ACACIA: TE_LIMITECREDCLI       *}
          {**************************************LU*}
          strLimCre := AnsiReplaceStr(FormatFloat('##0.00',fieldbyname('LIMCRE').AsFloat),',','.');
          strLinhaLim := fPadR(fieldbyname('CODCLI').AsString,20) + '|' + // codigo do cliente
                         fPadL(strLimCre,14,'0')                  + '|' + // limite de credito
                         fPadL(strLimCre,14,'0')                  + '|' + // limite de credito disponivel
                         fPadR(fCfgSis('CODACA'),10)                   + '|';  // codigo empresa na ACACIA
          lstTextoLim.Add(strLinhaLim);

          {*****************************************}
          {* TABELA ACACIA: TE_ENDENTREGA          *}
          {**************************************LU*}
          {************************}
          {* ENDEREÇO DE ENTREGA  *}
          {*********************LU*}
          If Not fEmptyStr(fieldbyname('ENDENT').AsString) Then
          Begin
            strLinhaEnd := fPadR(fieldbyname('CODCLI').AsString,10)  + '|' + // codigo do cliente
                           fPadR('001',10)                           + '|' + // código do endereço
                           fPadR(fieldbyname('ENDENT').AsString,100) + '|' + // endereço
                           fPadR(fieldbyname('CIDENT').AsString,100) + '|' + // nome da cidade
                           fPadR(fieldbyname('CEPENT').AsString,10)  + '|' + // cep
                           fPadR(fieldbyname('BAIENT').AsString,80)  + '|' + // bairro
                           fPadR(fCfgSis('CODACA'),10)               + '|' + // codigo empresa na ACACIA
                           fPadR('E',10)                             + '|';  // tipo do endereco E-entrega, C-cobranca
              lstTextoEnd.Add(strLinhaEnd);
          End

          {***********************}
          {* ENDEREÇO DO CLIENTE *}
          {********************LU*}
          Else If Not fEmptyStr(fieldbyname('ENDERE').AsString) Then
          Begin
            strLinhaEnd := fPadR(fieldbyname('CODCLI').AsString,10)  + '|' + // codigo do cliente
                           fPadR('001',10)                           + '|' + // código do endereço
                           fPadR(fieldbyname('ENDERE').AsString,100) + '|' + // endereço
                           fPadR(fieldbyname('CODCID').AsString,100) + '|' + // nome da cidade
                           fPadR(fieldbyname('C_E_P_').AsString,10)  + '|' + // cep
                           fPadR(fieldbyname('BAIRRO').AsString,80)  + '|' + // bairro
                           fPadR(fCfgSis('CODACA'),10)               + '|' + // codigo empresa na ACACIA
                           fPadR('E',10)                             + '|';  // tipo do endereco E-entrega, C-cobranca
            lstTextoEnd.Add(strLinhaEnd);
          End;

          {************************}
          {* ENDEREÇO DE COBRANCA *}
          {*********************LU*}
          If Not fEmptyStr(fieldbyname('ENDCOB').AsString) Then
          Begin
            strLinhaEnd := fPadR(fieldbyname('CODCLI').AsString,10)  + '|' + // codigo do cliente
                           fPadR('002',10)                           + '|' + // código do endereço
                           fPadR(fieldbyname('ENDCOB').AsString,100) + '|' + // endereço
                           fPadR(fieldbyname('CIDCOB').AsString,100) + '|' + // nome da cidade
                           fPadR(fieldbyname('CEPCOB').AsString,10)  + '|' + // cep
                           fPadR(fieldbyname('BAICOB').AsString,80)  + '|' + // bairro
                           fPadR(fCfgSis('CODACA'),10)               + '|' + // codigo empresa na ACACIA
                           fPadR('C',10)                             + '|';  // tipo do endereco E-entrega, C-cobranca
            lstTextoEnd.Add(strLinhaEnd);
          End

          {***********************}
          {* ENDEREÇO DO CLIENTE *}
          {********************LU*}
          Else If Not fEmptyStr(fieldbyname('ENDERE').AsString) Then
          Begin
            strLinhaEnd := fPadR(fieldbyname('CODCLI').AsString,10)  + '|' + // codigo do cliente
                           fPadR('002',10)                           + '|' + // código do endereço
                           fPadR(fieldbyname('ENDERE').AsString,100) + '|' + // endereço
                           fPadR(fieldbyname('CODCID').AsString,100) + '|' + // nome da cidade
                           fPadR(fieldbyname('C_E_P_').AsString,10)  + '|' + // cep
                           fPadR(fieldbyname('BAIRRO').AsString,80)  + '|' + // bairro
                           fPadR(fCfgSis('CODACA'),10)               + '|' + // codigo empresa na ACACIA
                           fPadR('C',10)                             + '|';  // tipo do endereco E-entrega, C-cobranca
            lstTextoEnd.Add(strLinhaEnd);
          End;

          {*****************************************}
          {* TABELA ACACIA: TESP_DESMARCA          *}
          {**************************************LU*}
//          strLinhaDesc := fPadR(fieldbyname('CODCLI').AsString,20) + '|' + // codigo do cliente
//                          fPadR(' ',20)                            + '|';  // codigo empresa na ACACIA
//          lstTextoDesc.Add(strLinhaDesc);

          {*****************************************}
          {* TABELA ACACIA: TESP_COMPLCLIENTE      *}
          {**************************************LU*}
//          strLinhaComp := fPadR(fieldbyname('CODCLI').AsString,20) + '|' + // codigo do cliente
//                          fPadR(fieldbyname('FONE01').AsString,15) + '|' + // telefone
//                          fPadR(fieldbyname('EMAIL_').AsString,50) + '|' + // e-mail
//                          fPadR(fieldbyname('CODATI').AsString,5)  + '|';  // ramo de atividade
//          lstTextoComp.Add(strLinhaComp);

          {******************************************************************}
          {* BUSCA AS 5 ÚLTIMAS NOTAS FICAIS E SEUS ITENS PARA CADA CLIENTE *}
          {* TABELAS ACACIA: TE_NOTAFISCAL E TE_NOTAFISCALITEM              *}
          {***************************************************************LU*}
          pExp_ClienteNotaFiscal(fieldbyname('CODCLI').AsString);

          {******************************************************************}
          {* BUSCA OS 5 ÚLTIMOS PEDIDOS E SEUS ITENS PARA CADA CLIENTE      *}
          {* TABELAS ACACIA: TE_HISTPEDIDO E TE_HISTPEDIDOITEM              *}
          {***************************************************************LU*}
          pExp_ClientePedido(fieldbyname('CODCLI').AsString);

          Next;
          pProgresso(RecNo, RecordCount);          
        End;

        lstTextoCli.SaveToFile(strPath + '\' + strNomArqCli);
        lstTextoNF.SaveToFile(strPath + '\' + strNomArqNF);
        lstTextoNFI.SaveToFile(strPath + '\' + strNomArqNFI);
        lstTextoPD.SaveToFile(strPath + '\' + strNomArqPD);
        lstTextoPDI.SaveToFile(strPath + '\' + strNomArqPDI);
        lstTextoCV.SaveToFile(strPath + '\' + strNomArqCV);
        lstTextoCont.SaveToFile(strPath + '\' + strNomArqCont);
        lstTextoLim.SaveToFile(strPath + '\' + strNomArqLim);
        lstTextoEnd.SaveToFile(strPath + '\' + strNomArqEnd);
//        lstTextoDesc.SaveToFile(strPath + '\' + strNomArqDesc);
//        lstTextoComp.SaveToFile(strPath + '\' + strNomArqComp);

        chkCli.Visible := True;
      End;

    End;

  Finally
    cdsCliente.Close;
    cdsNotaFiscal.Close;
    cdsPedido.Close;

    If (lstTextoCli <> Nil) Then
      FreeAndNil(lstTextoCli);

    If (lstTextoCV <> Nil) Then
      FreeAndNil(lstTextoCV);

    If (lstTextoCont <> Nil) Then
      FreeAndNil(lstTextoCont);

    If (lstTextoLim <> Nil) Then
      FreeAndNil(lstTextoLim);

    If (lstTextoEnd <> Nil) Then
      FreeAndNil(lstTextoEnd);

  End;

End;

{******************************************************************}
{* TABELAS ACACIA: TE_NOTAFISCAL E TE_NOTAFISCALITEM              *}
{***************************************************************LU*}
procedure TfrmTxtACACIAServer.pExp_ClienteNotaFiscal(strCodCli: String);
Var
  strSQL      : String;
  strQtdIte   : String;
  strDesEsp   : String;
  strUnitar   : String;
  strVlrCon   : String;
Begin

  strSQL := '';
  strSQL := strSQL + ' SELECT                                               ';
  strSQL := strSQL + '   MOVGER.AUTOINCREM AS AUTINC,                       ';
  strSQL := strSQL + '   CONCAT(GER_NUMDOC,"/1") AS NUMDOC,                 ';
  strSQL := strSQL + '   GER_DTAENT AS DTAENT,                              ';
  strSQL := strSQL + '   GER_CODCLI AS CODCLI,                              ';
  strSQL := strSQL + '   GER_VLRCON AS VLRCON,                              ';
  strSQL := strSQL + '   GER_CODVEN AS CODVEN,                              ';
  strSQL := strSQL + '   IF(LEFT(GER_CLAFIS,1) < 5, "D", "V") AS TIPNOT,    ';
  strSQL := strSQL + '   FGO_NUMDOC AS NUMPED                               ';
  strSQL := strSQL + ' FROM                                                 ';
  strSQL := strSQL + '   MOVGER                                             ';
  strSQL := strSQL + '   INNER JOIN FATGOR ON (GER_NUMDOC=FGO_NUMFAT AND     ';
  strSQL := strSQL + '                        GER_ESPDOC=FGO_TIPFAT AND     ';
  strSQL := strSQL + '                        GER_CODEMP=FGO_EMPFAT AND     ';
  strSQL := strSQL + '                        GER_CODCLI=FGO_CODCLI AND     ';
  strSQL := strSQL + '                        FGO_ESPDOC="PD")              ';
  strSQL := strSQL + ' WHERE                                                ';
  strSQL := strSQL + '   GER_CODCLI = :CODCLI AND GER_ESPDOC IN ("NF", "EL", "IF", "IV", "D1") ';
  strSQL := strSQL + ' ORDER BY                                             ';
  strSQL := strSQL + '   GER_DTAENT DESC                                    ';
  strSQL := strSQL + ' LIMIT 5                                              ';

  With qryNotaFiscal Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODCLI').AsString := strCodCli;
  End;

  dspNotaFiscal.DataSet := qryNotaFiscal;
  cdsNotaFiscal.Close;
  cdsNotaFiscal.SetProvider(dspNotaFiscal);
  cdsNotaFiscal.Open;

  With cdsNotaFiscal Do
  Begin

    While Not Eof Do
    Begin
      Application.ProcessMessages;

      {********************}
      {* DADOS DA NOTA    *}
      {*****************LU*}
      strVlrCon := AnsiReplaceStr(FormatFloat('##0.00',fieldbyname('VLRCON').AsFloat),',','.');

      strLinhaNF := fPadR(fieldbyname('NUMDOC').AsString,20)                    + '|' + // número da nota fiscal
                    FormatDateTime('ddMMyyyy',fieldbyname('DTAENT').AsDateTime) + '|' + // data emissão
                    fPadR(fieldbyname('CODCLI').AsString,10)                    + '|' + // codigo do cliente
                    fPadL(strVlrCon,14,'0')                                     + '|' + // valor da nota
                    fPadR(fieldbyname('TIPNOT').AsString,30)                    + '|' + // tipo da nota
                    fPadR(fieldbyname('NUMPED').AsString,30)                    + '|' + // número do pedido
                    fPadR(' ',100)                                              + '|' + // motivo da devolução
                    fPadR(fCfgSis('CODACA'),10)                                 + '|' + // codigo empresa na ACACIA
                    FormatDateTime('ddMMyyyy',fieldbyname('DTAENT').AsDateTime) + '|' + // data prevista de entrega
                    FormatDateTime('ddMMyyyy',fieldbyname('DTAENT').AsDateTime) + '|' + // data entrega cliente
                    fPadR(fieldbyname('CODVEN').AsString,10)                    + '|';  // código do vendedor
      lstTextoNF.Add(strLinhaNF);

      {******************************}
      {* LOCALIZA OS ITENS DA NOTA  *}
      {***************************LU*}
      strSQL := '';
      strSQL := strSQL + ' SELECT                                               ';
      strSQL := strSQL + '   CONCAT(DET_NUMDOC,"/1") AS NUMDOC,                 ';
      strSQL := strSQL + '   CONCAT(RIGHT(ITE_CODGRU,3), DET_CODITE) AS CODITE, ';
      strSQL := strSQL + '   DET_QTDITE AS QTDITE,                              ';
      strSQL := strSQL + '   DET_DESESP AS DESESP,                              ';
      strSQL := strSQL + '   DET_UNITAR AS UNITAR,                              ';
      strSQL := strSQL + '   DET_DESCRI AS DESCRI,                              ';
      strSQL := strSQL + '   DET_NUM_PD AS NUM_PD                               ';
      strSQL := strSQL + ' FROM                                                 ';
      strSQL := strSQL + '   MOVDET                                             ';
      strSQL := strSQL + ' JOIN CADITE ON ITE_CODITE = DET_CODITE               ';
      strSQL := strSQL + ' WHERE                                                ';
      strSQL := strSQL + '   DET_SEQGER = :SEQGER                               ';

      With qryGenerica Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('SEQGER').AsString := cdsNotaFiscal.fieldbyname('AUTINC').AsString;
      End;

      dspGenerica.DataSet := qryGenerica;
      cdsGenerica.Close;
      cdsGenerica.SetProvider(dspGenerica);
      cdsGenerica.Open;

      While Not cdsGenerica.Eof Do
      Begin
        If Not fEmptyStr(cdsGenerica.fieldbyname('NUM_PD').AsString) Then
		    Begin
          strQtdIte := AnsiReplaceStr(FormatFloat('##0.00',cdsGenerica.fieldbyname('QTDITE').AsFloat),',','.');
          strDesEsp := AnsiReplaceStr(FormatFloat('##0.00',cdsGenerica.fieldbyname('DESESP').AsFloat),',','.');
          strUnitar := AnsiReplaceStr(FormatFloat('##0.00',cdsGenerica.fieldbyname('UNITAR').AsFloat),',','.');

          strLinhaNFI := '';
          strLinhaNFI := fPadR(cdsGenerica.fieldbyname('NUMDOC').AsString,20)  + '|' + // número da nota fiscal
                         fPadR(cdsGenerica.fieldbyname('NUM_PD').AsString,30)  + '|' + // número do pedido
                         fPadR(cdsGenerica.fieldbyname('CODITE').AsString,30)  + '|' + // codigo do item
                         fPadL(strQtdIte,14,'0')                               + '|' + // quant.
                         fPadL(strDesEsp,14,'0')                               + '|' + // desc. especial
                         fPadL(strUnitar,14,'0')                               + '|' + // val. unitario
                         fPadR(cdsGenerica.fieldbyname('DESCRI').AsString,100) + '|';  // descricao do item

          lstTextoNFI.Add(strLinhaNFI);
    		End;
        cdsGenerica.Next;
      End;

      Next;
//      pProgresso(RecNo, RecordCount);
    End;

  End;

End;

{******************************************************************}
{* TABELAS ACACIA: TE_HISTPEDIDO E TE_HISTPEDIDOITEM              *}
{***************************************************************LU*}
procedure TfrmTxtACACIAServer.pExp_ClientePedido(strCodCli: String);
Var
  strSQL      : String;
  strQtdIte   : String;
  strUnitar   : String;
  strDesEsp   : String;
  strVlrCon   : String;
  strTipPed   : String;
  strOriPed   : String;  
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT                                           ';
  strSQL := strSQL + '   FGO_NUMDOC AS NUMDOC,                          ';
  strSQL := strSQL + '   FGO_DTAENT AS DTAENT,                          ';
  strSQL := strSQL + '   FGO_CODCLI AS CODCLI,                          ';
  strSQL := strSQL + '   FGO_CODVEN AS CODVEN,                          ';
  strSQL := strSQL + '   FGO_VLRCON AS VLRCON,                          ';
  strSQL := strSQL + '   FGO_CODCND AS CODCND,                          ';
  strSQL := strSQL + '   FGO_CODFPG AS CODFPG,                          ';
  strSQL := strSQL + '   CND_DESCRI AS DESCND,                          ';
  strSQL := strSQL + '   FPG_DESCRI AS DESFPG,                          ';
  strSQL := strSQL + '   FGO_CONPAG AS CONPAG,                          ';
  strSQL := strSQL + '   FGO_TIPPED AS TIPPED,                          ';
  strSQL := strSQL + '   FGO_NUMPOK AS NUMPOK,                          ';
  strSQL := strSQL + '   IF(FGO_JAFATU = 1, "Faturado", "Aberto") AS TIPFAT, ';
  strSQL := strSQL + '   FATGOR.AUTOINCREM AS AUTINC                    ';
  strSQL := strSQL + ' FROM                                             ';
  strSQL := strSQL + '   FATGOR                                         ';
  strSQL := strSQL + '   LEFT JOIN CADCND ON FGO_CODCND = CND_CODIGO    ';
  strSQL := strSQL + '   LEFT JOIN CADFPG ON FGO_CODFPG = FPG_CODIGO    ';
  strSQL := strSQL + ' WHERE                                            ';
  strSQL := strSQL + '   FGO_CODCLI = :CODCLI AND                       ';
  strSQL := strSQL + '   FGO_ESPDOC <> "PR"                             ';
  strSQL := strSQL + ' ORDER BY                                         ';
  strSQL := strSQL + '   FGO_DTAENT DESC                                ';
  strSQL := strSQL + ' LIMIT 5                                          ';

  With qryPedido Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODCLI').AsString := strCodCli;
  End;

  dspPedido.DataSet := qryPedido;
  cdsPedido.Close;
  cdsPedido.SetProvider(dspPedido);
  cdsPedido.Open;

  With cdsPedido Do
  Begin

    While Not Eof Do
    Begin
      Application.ProcessMessages;

      strVlrCon := AnsiReplaceStr(FormatFloat('##0.00',fieldbyname('VLRCON').AsFloat),',','.');

      If FieldByName('TIPPED').AsString = 'B' Then
        strTipPed := '01'
      Else
        strTipPed := '00';

      If Not fEmptyStr(FieldByName('NUMPOK').AsString) Then
        strOriPed := 'ACACIA'
       Else
        strOriPed := 'AUTCOM';

      {********************}
      {* DADOS DO PEDIDO  *}
      {*****************LU*}
      strLinhaPD := '';
      strLinhaPD := fPadR(fieldbyname('NUMDOC').AsString,30)                    + '|' + // número do pedido
                    fPadR(fieldbyname('NUMPOK').AsString,30)                    + '|' + // número do pedido - pocket
                    fPadR(fieldbyname('CODCLI').AsString,20)                    + '|' + // codigo do cliente
                    fPadR(fieldbyname('TIPFAT').AsString,30)                    + '|' + // status do pedido
                    fPadL(strVlrCon,14,'0')                                     + '|' + // valor do pedido
                    fPadL(strVlrCon,14,'0')                                     + '|' + // valor do pedido faturado
                    FormatDateTime('ddMMyyyy',fieldbyname('DTAENT').AsDateTime) + '|' + // data emissão
                    FormatDateTime('ddMMyyyy',fieldbyname('DTAENT').AsDateTime) + '|' + // data prevista entrega
                    fPadR(strOriPed,30)                                         + '|' + // origem do pedido
                    fPadR(strTipPed,10)                                         + '|' + // código do tipo do pedido
                    fPadR(fPadL(fieldbyname('CODCND').AsString, 5, '0'),10)     + '|' + // código da cond. pagto
                    fPadR(' ',100)                                              + '|' + // descricao frete
                    fPadR(fCfgSis('CODACA'),10)                                 + '|' + // codigo empresa na ACACIA
                    '0'                                                         + '|' + // desconto forma pagto
                    fieldbyname('DESFPG').AsString                              + '|' + // descrição forma pagto
                    fPadR(fieldbyname('CODVEN').AsString,10)                    + '|';  // codigo do vendedor

      lstTextoPD.Add(strLinhaPD);

      {*******************************}
      {* LOCALIZA OS ITENS DO PEDIDO *}
      {****************************LU*}
      strSQL := '';
      strSQL := strSQL + ' SELECT                                           ';
      strSQL := strSQL + '   FDO_NUMDOC AS NUMDOC,                          ';
      strSQL := strSQL + '   CONCAT(RIGHT(GRU_CODGRU,3), FDO_CODITE) AS CODITE, ';
      strSQL := strSQL + '   FDO_QTDITE AS QTDITE,                          ';
      strSQL := strSQL + '   FDO_UNITAR AS UNITAR,                          ';
      strSQL := strSQL + '   FDO_DESESP AS DESESP,                          ';            
      strSQL := strSQL + '   FDO_DESCRI AS DESCRI                           ';
      strSQL := strSQL + ' FROM                                             ';
      strSQL := strSQL + '   FATDOR                                         ';
      strSQL := strSQL + 'JOIN CADITE ON ITE_CODITE = FDO_CODITE ';
      strSQL := strSQL + 'JOIN CADGRU ON GRU_CODGRU = ITE_CODGRU ';
      strSQL := strSQL + ' WHERE                                            ';
      strSQL := strSQL + '   FDO_SEQGER = :AUTINC                           ';

      With qryGenerica Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('AUTINC').AsString := cdsPedido.fieldbyname('AUTINC').AsString;
      End;

      dspGenerica.DataSet := qryGenerica;
      cdsGenerica.Close;
      cdsGenerica.SetProvider(dspGenerica);
      cdsGenerica.Open;

      While Not cdsGenerica.Eof Do
      Begin
        strQtdIte := AnsiReplaceStr(FormatFloat('##0.00',cdsGenerica.fieldbyname('QTDITE').AsFloat),',','.');
        strUnitar := AnsiReplaceStr(FormatFloat('##0.00',cdsGenerica.fieldbyname('UNITAR').AsFloat),',','.');
        strDesEsp := AnsiReplaceStr(FormatFloat('##0.00',cdsGenerica.fieldbyname('DESESP').AsFloat),',','.');        

        strLinhaPDI := '';
        strLinhaPDI := fPadR(cdsGenerica.fieldbyname('NUMDOC').AsString,30)  + '|' + // número do pedido
                       fPadR(cdsGenerica.fieldbyname('CODITE').AsString,30)  + '|' + // codigo do item
                       fPadR(cdsGenerica.fieldbyname('DESCRI').AsString,100) + '|' + // descricao do item
                       fPadL(strQtdIte,14,'0')                               + '|' + // quant.
                       '0'                                                   + '|' + // quant. bonificada
                       '0'                                                   + '|' + // quant. cortada
                       fPadL(strDesEsp,14,'0')                               + '|' + // desconto
                       fPadL(strUnitar,14,'0')                               + '|' + // val. unitario
                       fPadR(' ',10)                                         + '|' + // condição de pagto
                       fPadR(fCfgSis('CODACA'),10)                           + '|';  // codigo empresa na ACACIA

        lstTextoPDI.Add(strLinhaPDI);
        cdsGenerica.Next;
      End;

      Next;
//      pProgresso(RecNo, RecordCount);
    End;

  End;

End;

{*****************************************}
{* TABELA ACACIA: TE_MARCA               *}
{**************************************LU*}
procedure TfrmTxtACACIAServer.pExp_Marcas;
Var
  strSQL   : String;
  strNomArq: String;
  strArqMar: String;
  strLinha : String;
  lstTexto : TStringList;
  lstMarVen: TStringList;
Begin

  Try
    {*******************}
    {* NOME DO ARQUIVO *}
    {****************LU*}
    strNomArq := 'MARCA' + FormatDateTime('yyyyMMdd',VS_Date)  + FormatDateTime('hhmmss',fTime()) + '.TXT';
    strSQL := '';
    strSQL := strSQL + ' SELECT        ';
    strSQL := strSQL + '   MAR_CODMAR, ';
    strSQL := strSQL + '   MAR_DESMAR  ';
    strSQL := strSQL + ' FROM          ';
    strSQL := strSQL + '   CADMAR      ';

    With qryGenerica Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
    End;

    dspGenerica.DataSet := qryGenerica;
    cdsGenerica.Close;
    cdsGenerica.SetProvider(dspGenerica);
    cdsGenerica.Open;

    With cdsGenerica Do
    Begin

      If Not IsEmpty Then
      Begin
        lstTexto := TStringList.Create;
        While Not Eof Do
        Begin
          Application.ProcessMessages;
          strLinha := '';
          strLinha := fPadR(fieldbyname('MAR_CODMAR').AsString,10)  + '|' + // codigo da marca
                      fPadR(fieldbyname('MAR_DESMAR').AsString,100) + '|' + // descricao da marca
                      fPadR(fCfgSis('CODACA'),10)                   + '|';  // codigo empresa na ACACIA

          lstTexto.Add(strLinha);
          Next;
          pProgresso(RecNo, RecordCount);          
        End;
        lstTexto.SaveToFile(strPath + '\' + strNomArq);
        chkMar.Visible := True;
      End;

    End;

   {************************************************************************}
   {* MARCA VENDEDOR - CRIA ARQUIVO VAZIO APENAS PARA EVITAR PROBLEMAS NA  *}
   {* EXPORTAÇÃO DA ACACIA: ARQUIVO MARCAVEND....                          *}
   {*********************************************************************JC*}
    strArqMar := 'MARCAVEND' + FormatDateTime('yyyyMMdd',VS_Date)  + FormatDateTime('hhmmss',fTime()) + '.TXT';

    lstMarVen := TStringList.Create;
//    lstMarVen.Add(fPadR('',30) + '|' + fPadR('',10) + '|' + FormatDateTime('ddmmyyyy',Date) + '|');
    lstMarVen.SaveToFile(strPath + '\' +strArqMar);


  Finally
    cdsGenerica.Close;

    If (lstTexto <> Nil) Then
      FreeAndNil(lstTexto);

    If (lstMarVen <> Nil) Then
      FreeAndNil(lstMarVen);
  End;

End;

{*****************************************}
{* TABELA ACACIA: TE_PRODUTO             *}
{**************************************LU*}
procedure TfrmTxtACACIAServer.pExp_Produtos;
Var
  strSQL    : String;
  strNomArq : String;
  strLinha  : String;
  strPesoIt : String;
  strPesLiq : String;
  strPreVen : String;
  strSaldos : String;
  strIpiSai : String;
  strPreCus : String;
  strPreMin : String;
  strPreMi2 : String;
  strPreMi3 : String;
  strPreMi4 : String;
  strPreMi5 : String;
  strPreMi6 : String;
  strPreMi7 : String;
  lstTexto  : TStringList;

  strArqPR  : String;
  strDesMax : String;
  lstTextoPR: TStringList;

  function fPrecoPromocaoItem(strItem: String): Double;
  begin
    Result := 0;

    If (qryItensPromocao.FieldByName('CODITE').AsString = strItem) Or
       (qryItensPromocao.Locate('CODITE', strItem, []))            Then
    Begin
      Result := qryItensPromocao.fieldbyname('PREVEN').AsFloat;
    End;

  end;

Begin

  Try
    {*******************}
    {* NOME DO ARQUIVO *}
    {****************LU*}
    strNomArq := 'PRODUTOS' + FormatDateTime('yyyyMMdd',VS_Date)  + FormatDateTime('hhmmss',fTime()) + '.TXT';
    strArqPR  := 'TABPRECO' + FormatDateTime('yyyyMMdd',VS_Date)  + FormatDateTime('hhmmss',fTime()) + '.TXT';
   
    strSQL := '';
    strSQL := strSQL + ' SELECT                                                                       ';
    strSQL := strSQL + '   CONCAT(RIGHT(C.ITE_CODGRU,3), C.ITE_CODITE) AS CODITE,                     ';
    strSQL := strSQL + '   C.ITE_CODGRU AS CODGRU,                                                    ';
    strSQL := strSQL + '   RIGHT(C.ITE_CODITE,'+IntToStr(fTamCodIte)+') AS CODRED,                     ';
    strSQL := strSQL + '   C.ITE_DESITE AS DESITE,                                                    ';
    strSQL := strSQL + '   C.ITE_CODMAR AS CODMAR,                                                    ';
    strSQL := strSQL + '   IF(C.ITE_ITEATI = "S", "001", "002") AS ITEATI,                            ';
    strSQL := strSQL + '   C.ITE_CODBAR AS CODBAR,                                                    ';
    strSQL := strSQL + '   C.ITE_PESOIT AS PESOIT,                                                    ';
    strSQL := strSQL + '   C.ITE_PESLIQ AS PESLIQ,                                                    ';
    strSQL := strSQL + '   (SELECT UNI_SIGUNI FROM CADUNI WHERE UNI_CODUNI = C.ITE_CODUNI) AS CODUNI, ';
    strSQL := strSQL + '   I.ITE_PREVE1 AS PREVEN,                                                    ';
    strSQL := strSQL + '   I.ITE_PREVE2 AS PREVE2,                                                    ';
    strSQL := strSQL + '   I.ITE_PREVE3 AS PREVE3,                                                    ';
    strSQL := strSQL + '   I.ITE_PREVE4 AS PREVE4,                                                    ';
    strSQL := strSQL + '   I.ITE_PREVE5 AS PREVE5,                                                    ';
    strSQL := strSQL + '   I.ITE_PREVE6 AS PREVE6,                                                    ';
    strSQL := strSQL + '   I.ITE_PREVE7 AS PREVE7,                                                    ';  
    strSQL := strSQL + '   I.ITE_SALDOS AS SALDOS,                                                    ';
    strSQL := strSQL + '   I.ITE_IPISAI AS IPISAI,                                                    ';
    strSQL := strSQL + '   I.ITE_PRECUS AS PRECUS,                                                    ';
    strSQL := strSQL + '   I.ITE_DESMAX AS DESMAX,                                                    ';
    strSQL := strSQL + '   (I.ITE_PREVE1 - ((I.ITE_PREVE1 * I.ITE_DESMAX) /100)) AS PREMIN,           ';
    strSQL := strSQL + '   (I.ITE_PREVE2 - ((I.ITE_PREVE2 * I.ITE_DESMAX) /100)) AS PREMI2,           ';
    strSQL := strSQL + '   (I.ITE_PREVE3 - ((I.ITE_PREVE3 * I.ITE_DESMAX) /100)) AS PREMI3,           ';
    strSQL := strSQL + '   (I.ITE_PREVE4 - ((I.ITE_PREVE4 * I.ITE_DESMAX) /100)) AS PREMI4,           ';
    strSQL := strSQL + '   (I.ITE_PREVE5 - ((I.ITE_PREVE5 * I.ITE_DESMAX) /100)) AS PREMI5,           ';
    strSQL := strSQL + '   (I.ITE_PREVE6 - ((I.ITE_PREVE6 * I.ITE_DESMAX) /100)) AS PREMI6,           ';
    strSQL := strSQL + '   (I.ITE_PREVE7 - ((I.ITE_PREVE7 * I.ITE_DESMAX) /100)) AS PREMI7            ';
    strSQL := strSQL + ' FROM                                                                         ';
    strSQL := strSQL + '   CADITE C                                                                   ';
    strSQL := strSQL + '   JOIN ITEGER I ON (I.ITE_CODITE = C.ITE_CODITE AND                          ';
    strSQL := strSQL + '                     I.ITE_CODEMP = :CODEMP)                                  ';

    With qryProduto Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := VS_strCodEmp;
    End;
   
    dspProduto.DataSet := qryProduto;
    cdsProduto.Close;
    cdsProduto.SetProvider(dspProduto);
    cdsProduto.Open;
   
    With cdsProduto Do
    Begin
   
      If Not IsEmpty Then
      Begin
        lstTexto   := TStringList.Create;
        lstTextoPR := TStringList.Create;
   
        While Not Eof Do
        Begin
          If (RecordCount mod 100) = 0 Then
            Application.ProcessMessages;
   
          strPesoIt := AnsiReplaceStr(FormatFloat('##0.000',fieldbyname('PESOIT').AsFloat),',','.');
          strpesLiq := AnsiReplaceStr(FormatFloat('##0.000',fieldbyname('PESLIQ').AsFloat),',','.');
          strPreVen := AnsiReplaceStr(FormatFloat('##0.00',fieldbyname('PREVEN').AsFloat),',','.');
          strSaldos := AnsiReplaceStr(FormatFloat('##0.00',fieldbyname('SALDOS').AsFloat),',','.');
          strIpiSai := AnsiReplaceStr(FormatFloat('##0.00',fieldbyname('IPISAI').AsFloat),',','.');
          strPreCus := AnsiReplaceStr(FormatFloat('##0.00',fieldbyname('PRECUS').AsFloat),',','.');
          strPreMin := AnsiReplaceStr(FormatFloat('##0.00',fieldbyname('PREMIN').AsFloat),',','.');
          strPreMi2 := AnsiReplaceStr(FormatFloat('##0.00',fieldbyname('PREMI2').AsFloat),',','.');
          strPreMi3 := AnsiReplaceStr(FormatFloat('##0.00',fieldbyname('PREMI3').AsFloat),',','.');
          strPreMi4 := AnsiReplaceStr(FormatFloat('##0.00',fieldbyname('PREMI4').AsFloat),',','.');
          strPreMi5 := AnsiReplaceStr(FormatFloat('##0.00',fieldbyname('PREMI5').AsFloat),',','.');
          strPreMi6 := AnsiReplaceStr(FormatFloat('##0.00',fieldbyname('PREMI6').AsFloat),',','.');
          strPreMi7 := AnsiReplaceStr(FormatFloat('##0.00',fieldbyname('PREMI7').AsFloat),',','.');

          If fPrecoPromocaoItem(fieldbyname('CODRED').AsString) > 0 Then
          Begin
            strPreMin := AnsiReplaceStr(FormatFloat('##0.00', fPrecoPromocaoItem(fieldbyname('CODRED').AsString)),',','.');
            strPreMi2 := AnsiReplaceStr(FormatFloat('##0.00', fPrecoPromocaoItem(fieldbyname('CODRED').AsString)),',','.');
            strPreMi3 := AnsiReplaceStr(FormatFloat('##0.00', fPrecoPromocaoItem(fieldbyname('CODRED').AsString)),',','.');
            strPreMi4 := AnsiReplaceStr(FormatFloat('##0.00', fPrecoPromocaoItem(fieldbyname('CODRED').AsString)),',','.');
            strPreMi5 := AnsiReplaceStr(FormatFloat('##0.00', fPrecoPromocaoItem(fieldbyname('CODRED').AsString)),',','.');
            strPreMi6 := AnsiReplaceStr(FormatFloat('##0.00', fPrecoPromocaoItem(fieldbyname('CODRED').AsString)),',','.');
            strPreMi7 := AnsiReplaceStr(FormatFloat('##0.00', fPrecoPromocaoItem(fieldbyname('CODRED').AsString)),',','.');
          End;

          strLinha := fPadR(fieldbyname('CODITE').AsString,30)    + '|' +  // código do produto
                      fPadR(' ',10)                               + '|' +  // código da categoria
                      fPadR(fieldbyname('CODMAR').AsString,10)    + '|' +  // código da marca/fornecedor
                      fPadR(AnsiRightStr(fieldbyname('CODGRU').AsString, 3),10)  + '|' +  // código do grupo/familia
                      fPadR(fieldbyname('DESITE').AsString,100)   + '|' +  // descrição
                      fPadR(fieldbyname('ITEATI').AsString,10)    + '|' +  // status 001-ativo, 002-inativo
                      fPadR(' ',050)                              + '|' +  // DUN-14
                      fPadR(fieldbyname('CODBAR').AsString,50)    + '|' +  // código barra - EAN-13
                      fPadL(strPesoIt,12,'0')                     + '|' +  // peso bruto
                      fPadL('1',10,'0')                           + '|' +  // qtde embalagem
                      fPadR(fPadL('1',6,'0'),30)                  + '|' +  // volume
                      fPadR(' ',200)                              + '|' +  // observações
                      fPadR(fieldbyname('CODUNI').AsString,30)    + '|' +  // unidade produto
                      '0'                                         + '|' +  // % desconto flex.
                      fPadR(' ',30)                               + '|' +  // tempo validade
                      fPadL(strPreVen,14,'0')                     + '|' +  // preço produto
                      '0'                                         + '|' +  // % desconto maximo permitido
                      '0'                                         + '|' +  // % máximo de acrescimo
                      '0'                                         + '|' +  // % de comissão
                      '0'                                         + '|' +  // flag de valor fixo
                      fPadL(strSaldos,14,'0')                     + '|' +  // qtde estoque
                      fPadR(' ',10)                               + '|' +  // flag sit. especial P-promocao/L-lancamento
                      fPadL(strIpiSai,14,'0')                     + '|' +  // % IPI
                      fPadL(strPesLiq,14,'0')                     + '|' +  // peso liquido
                      fPadR(fCfgSis('CODACA'),10)                 + '|' +  // código empresa na ACACIA
                      fPadL(strPreCus,14,'0')                     + '|' +  // preço custo
                      fPadL(strPreMin,14,'0')                     + '|' +  // preço mínimo
                      fPadR(fieldbyname('CODRED').AsString,30)    + '|';   // código do produto reduzido
   
          lstTexto.Add(strLinha);
   
          {*****************************************}
          {* TABELA ACACIA: TE_TABELAPRECO         *}
          {**************************************LU*}
          strDesMax := AnsiReplaceStr(FormatFloat('##0.00',fieldbyname('DESMAX').AsFloat),',','.');

          If (fPrecoPromocaoItem(fieldbyname('CODRED').AsString) > 0) And (fieldbyname('PREVEN').AsFloat > 0) Then
          Begin
            strDesMax := AnsiReplaceStr(FormatFloat('##0.00', (1 - (fPrecoPromocaoItem(fieldbyname('CODRED').AsString) / fieldbyname('PREVEN').AsFloat)) * 100), ',','.');
          End;
   
          If (VS_strTabVen[1] = 'S') And (FieldByName('PREVEN').AsFloat > 0) Then
          Begin
            strPreVen := AnsiReplaceStr(FormatFloat('##0.00',fieldbyname('PREVEN').AsFloat),',','.');
            strLinha := '';
            strLinha := '001'                                    + '|' + // código da tabela
                        fPadR(fCfgSis('CODACA'),10)              + '|' + // codigo empresa na ACACIA
                        fPadR(' ',10)                            + '|' + // código da região
                        fPadR(' ',10)                            + '|' + // código do canal/ramo de atividade
                        fPadR(' ',50)                            + '|' + // chave da busca
                        fPadR(fieldbyname('CODITE').AsString,30) + '|' + // código do produto
                        fPadR(' ',10)                            + '|' + // código da embalagem
                        fPadL(strPreVen,14,'0')                  + '|' + // preço
                        fPadL(strDesMax,14,'0')                  + '|' + // % de desconto permitido
                        '00000000000.00'                         + '|' + // % de desconto flex
                        fPadR(' ',8)                             + '|' + // data inicial da validade
                        fPadR(' ',8)                             + '|' + // data final da validade
                        fPadL(strPreMin,14,'0')                  + '|';  // preço mínimo
            lstTextoPR.Add(strLinha);
          End;

          If (fPrecoPromocaoItem(fieldbyname('CODRED').AsString) > 0) And (fieldbyname('PREVE2').AsFloat > 0) Then
          Begin
            strDesMax := AnsiReplaceStr(FormatFloat('##0.00', (1 - (fPrecoPromocaoItem(fieldbyname('CODRED').AsString) / fieldbyname('PREVE2').AsFloat)) * 100), ',','.');
          End;
   
          If (VS_strTabVen[2] = 'S') And (fieldbyname('PREVE2').AsFloat > 0) Then
          Begin
            strPreVen := AnsiReplaceStr(FormatFloat('##0.00',fieldbyname('PREVE2').AsFloat),',','.');
            strLinha := '';
            strLinha := '002'                                    + '|' + // código da tabela
                        fPadR(fCfgSis('CODACA'),10)              + '|' + // codigo empresa na ACACIA
                        fPadR(' ',10)                            + '|' + // código da região
                        fPadR(' ',10)                            + '|' + // código do canal/ramo de atividade
                        fPadR(' ',50)                            + '|' + // chave da busca
                        fPadR(fieldbyname('CODITE').AsString,30) + '|' + // código do produto
                        fPadR(' ',10)                            + '|' + // código da embalagem
                        fPadL(strPreVen,14,'0')                  + '|' + // preço
                        fPadL(strDesMax,14,'0')                  + '|' + // % de desconto permitido
                        '00000000000.00'                         + '|' + // % de desconto flex
                        fPadR(' ',8)                             + '|' + // data inicial da validade
                        fPadR(' ',8)                             + '|' + // data final da validade
                        fPadL(strPreMi2,14,'0')                  + '|';  // preço mínimo
            lstTextoPR.Add(strLinha);
          End;

          If (fPrecoPromocaoItem(fieldbyname('CODRED').AsString) > 0) And (fieldbyname('PREVE3').AsFloat > 0) Then
          Begin
            strDesMax := AnsiReplaceStr(FormatFloat('##0.00', (1 - (fPrecoPromocaoItem(fieldbyname('CODRED').AsString) / fieldbyname('PREVE3').AsFloat)) * 100), ',','.');
          End;

          If (VS_strTabVen[3] = 'S') And (fieldbyname('PREVE3').AsFloat > 0) Then
          Begin
            strPreVen := AnsiReplaceStr(FormatFloat('##0.00',fieldbyname('PREVE3').AsFloat),',','.');
            strLinha := '';
            strLinha := '003'                                    + '|' + // código da tabela
                        fPadR(fCfgSis('CODACA'),10)              + '|' + // codigo empresa na ACACIA
                        fPadR(' ',10)                            + '|' + // código da região
                        fPadR(' ',10)                            + '|' + // código do canal/ramo de atividade
                        fPadR(' ',50)                            + '|' + // chave da busca
                        fPadR(fieldbyname('CODITE').AsString,30) + '|' + // código do produto
                        fPadR(' ',10)                            + '|' + // código da embalagem
                        fPadL(strPreVen,14,'0')                  + '|' + // preço
                        fPadL(strDesMax,14,'0')                  + '|' + // % de desconto permitido
                        '00000000000.00'                         + '|' + // % de desconto flex
                        fPadR(' ',8)                             + '|' + // data inicial da validade
                        fPadR(' ',8)                             + '|' + // data final da validade
                        fPadL(strPreMi3,14,'0')                  + '|';  // preço mínimo
            lstTextoPR.Add(strLinha);
          End;

          If (fPrecoPromocaoItem(fieldbyname('CODRED').AsString) > 0) And (fieldbyname('PREVE4').AsFloat > 0) Then
          Begin
            strDesMax := AnsiReplaceStr(FormatFloat('##0.00', (1 - (fPrecoPromocaoItem(fieldbyname('CODRED').AsString) / fieldbyname('PREVE4').AsFloat)) * 100), ',','.');
          End;
   
          If (VS_strTabVen[4] = 'S') And (fieldbyname('PREVE4').AsFloat > 0) Then
          Begin
            strPreVen := AnsiReplaceStr(FormatFloat('##0.00',fieldbyname('PREVE4').AsFloat),',','.');
            strLinha := '';
            strLinha := '004'                                    + '|' + // código da tabela
                        fPadR(fCfgSis('CODACA'),10)              + '|' + // codigo empresa na ACACIA
                        fPadR(' ',10)                            + '|' + // código da região
                        fPadR(' ',10)                            + '|' + // código do canal/ramo de atividade
                        fPadR(' ',50)                            + '|' + // chave da busca
                        fPadR(fieldbyname('CODITE').AsString,30) + '|' + // código do produto
                        fPadR(' ',10)                            + '|' + // código da embalagem
                        fPadL(strPreVen,14,'0')                  + '|' + // preço
                        fPadL(strDesMax,14,'0')                  + '|' + // % de desconto permitido
                        '00000000000.00'                         + '|' + // % de desconto flex
                        fPadR(' ',8)                             + '|' + // data inicial da validade
                        fPadR(' ',8)                             + '|' + // data final da validade
                        fPadL(strPreMi4,14,'0')                  + '|';  // preço mínimo
            lstTextoPR.Add(strLinha);
          End;

          If (fPrecoPromocaoItem(fieldbyname('CODRED').AsString) > 0) And (fieldbyname('PREVE5').AsFloat > 0) Then
          Begin
            strDesMax := AnsiReplaceStr(FormatFloat('##0.00', (1 - (fPrecoPromocaoItem(fieldbyname('CODRED').AsString) / fieldbyname('PREVE5').AsFloat)) * 100), ',','.');
          End;

          If (VS_strTabVen[5] = 'S') And (fieldbyname('PREVE5').AsFloat > 0) Then
          Begin
            strPreVen := AnsiReplaceStr(FormatFloat('##0.00',fieldbyname('PREVE5').AsFloat),',','.');
            strLinha := '';
            strLinha := '005'                                    + '|' + // código da tabela
                        fPadR(fCfgSis('CODACA'),10)              + '|' + // codigo empresa na ACACIA
                        fPadR(' ',10)                            + '|' + // código da região
                        fPadR(' ',10)                            + '|' + // código do canal/ramo de atividade
                        fPadR(' ',50)                            + '|' + // chave da busca
                        fPadR(fieldbyname('CODITE').AsString,30) + '|' + // código do produto
                        fPadR(' ',10)                            + '|' + // código da embalagem
                        fPadL(strPreVen,14,'0')                  + '|' + // preço
                        fPadL(strDesMax,14,'0')                  + '|' + // % de desconto permitido
                        '00000000000.00'                         + '|' + // % de desconto flex
                        fPadR(' ',8)                             + '|' + // data inicial da validade
                        fPadR(' ',8)                             + '|' + // data final da validade
                        fPadL(strPreMi5,14,'0')                  + '|';  // preço mínimo
            lstTextoPR.Add(strLinha);
          End;

          If (fPrecoPromocaoItem(fieldbyname('CODRED').AsString) > 0) And (fieldbyname('PREVE6').AsFloat > 0) Then
          Begin
            strDesMax := AnsiReplaceStr(FormatFloat('##0.00', (1 - (fPrecoPromocaoItem(fieldbyname('CODRED').AsString) / fieldbyname('PREVE6').AsFloat)) * 100), ',','.');
          End;
   
          If (VS_strTabVen[6] = 'S') And (fieldbyname('PREVE6').AsFloat > 0) Then
          Begin
            strPreVen := AnsiReplaceStr(FormatFloat('##0.00',fieldbyname('PREVE6').AsFloat),',','.');
            strLinha := '';
            strLinha := '006'                                    + '|' + // código da tabela
                        fPadR(fCfgSis('CODACA'),10)              + '|' + // codigo empresa na ACACIA
                        fPadR(' ',10)                            + '|' + // código da região
                        fPadR(' ',10)                            + '|' + // código do canal/ramo de atividade
                        fPadR(' ',50)                            + '|' + // chave da busca
                        fPadR(fieldbyname('CODITE').AsString,30) + '|' + // código do produto
                        fPadR(' ',10)                            + '|' + // código da embalagem
                        fPadL(strPreVen,14,'0')                  + '|' + // preço
                        fPadL(strDesMax,14,'0')                  + '|' + // % de desconto permitido
                        '00000000000.00'                         + '|' + // % de desconto flex
                        fPadR(' ',8)                             + '|' + // data inicial da validade
                        fPadR(' ',8)                             + '|' + // data final da validade
                        fPadL(strPreMi6,14,'0')                  + '|';  // preço mínimo
            lstTextoPR.Add(strLinha);
          End;

          If (fPrecoPromocaoItem(fieldbyname('CODRED').AsString) > 0) And (fieldbyname('PREVE7').AsFloat > 0) Then
          Begin
            strDesMax := AnsiReplaceStr(FormatFloat('##0.00', (1 - (fPrecoPromocaoItem(fieldbyname('CODRED').AsString) / fieldbyname('PREVE7').AsFloat)) * 100), ',','.');
          End;
   
          If (VS_strTabVen[7] = 'S') And (fieldbyname('PREVE7').AsFloat > 0) Then
          Begin
            strPreVen := AnsiReplaceStr(FormatFloat('##0.00',fieldbyname('PREVE7').AsFloat),',','.');
            strLinha := '';
            strLinha := '007'                                    + '|' + // código da tabela
                        fPadR(fCfgSis('CODACA'),10)              + '|' + // codigo empresa na ACACIA
                        fPadR(' ',10)                            + '|' + // código da região
                        fPadR(' ',10)                            + '|' + // código do canal/ramo de atividade
                        fPadR(' ',50)                            + '|' + // chave da busca
                        fPadR(fieldbyname('CODITE').AsString,30) + '|' + // código do produto
                        fPadR(' ',10)                            + '|' + // código da embalagem
                        fPadL(strPreVen,14,'0')                  + '|' + // preço
                        fPadL(strDesMax,14,'0')                  + '|' + // % de desconto permitido
                        '00000000000.00'                         + '|' + // % de desconto flex
                        fPadR(' ',8)                             + '|' + // data inicial da validade
                        fPadR(' ',8)                             + '|' + // data final da validade
                        fPadL(strPreMi7,14,'0')                  + '|';  // preço mínimo
            lstTextoPR.Add(strLinha);
          End;
   
          Next;
          pProgresso(RecNo, RecordCount);           
        End;
        lstTexto.SaveToFile(strPath + '\' + strNomArq);
        lstTextoPR.SaveToFile(strPath + '\' + strArqPR);
        chkPro.Visible := True;
        chkTPr.Visible := True;
      End;
   
    End;
  Finally
    If (lstTexto <> Nil) Then
      FreeAndNil(lstTexto);

    If (lstTextoPR <> Nil) Then
      FreeAndNil(lstTextoPR);
  End;

End;

{*****************************************}
{* TABELA ACACIA: T_GRUPOPRODUTO         *}
{**************************************LU*}
procedure TfrmTxtACACIAServer.pExp_GrupoProduto;
Var
  strSQL   : String;
  strNomArq: String;
  strLinha : String;
  lstTexto : TStringList;
Begin

  Try
    {*******************}
    {* NOME DO ARQUIVO *}
    {****************LU*}
    strNomArq := 'FORNECEDOR' + FormatDateTime('yyyyMMdd',VS_Date)  + FormatDateTime('hhmmss',fTime()) + '.TXT';

    strSQL := '';
    strSQL := strSQL + ' SELECT                  ';
    strSQL := strSQL + '   GRU_CODGRU AS CODIGO, ';
    strSQL := strSQL + '   GRU_DESGRU AS DESGRU  ';
    strSQL := strSQL + ' FROM                    ';
    strSQL := strSQL + '   CADGRU                ';

    With qryGenerica Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
    End;

    dspGenerica.DataSet := qryGenerica;
    cdsGenerica.Close;
    cdsGenerica.SetProvider(dspGenerica);
    cdsGenerica.Open;

    With cdsGenerica Do
    Begin

      If Not IsEmpty Then
      Begin
        lstTexto := TStringList.Create;
        While Not Eof Do
        Begin
          Application.ProcessMessages;
          strLinha := fPadR(AnsiRightStr(fieldbyname('CODIGO').AsString, 3),10)  + '|' + // código
                      fPadR(fieldbyname('DESGRU').AsString,100)                  + '|' + // descrição
                      '000.00'                                                   + '|' + // % máximo acréscimo
                      fPadR(fCfgSis('CODACA'),10)                                + '|';  // código empresa na ACACIA

          lstTexto.Add(strLinha);

          Next;
          pProgresso(RecNo, RecordCount);          
        End;
        lstTexto.SaveToFile(strPath + '\' + strNomArq);
        chkGru.Visible := True;
      End;

    End;

  Finally
    cdsGenerica.Close;

    If (lstTexto <> Nil) Then
      FreeAndNil(lstTexto);
  End;

End;

{*****************************************}
{* TABELA ACACIA: TE_REGIAO              *}
{**************************************LU*}
procedure TfrmTxtACACIAServer.pExp_Regioes;
Var
  strNomArq: String;
  strLinha : String;
  lstTexto : TStringList;
Begin
  Try
    {*******************}
    {* NOME DO ARQUIVO *}
    {****************LU*}
    strNomArq := 'REGIAO' + FormatDateTime('yyyyMMdd',VS_Date)  + FormatDateTime('hhmmss',fTime()) + '.TXT';
    
    lstTexto := TStringList.Create;
    
    strLinha := fPadR('001',10)     + '|' +  // codigo
                fPadR('ATACADO',50) + '|';   // descricao
    lstTexto.Add(strLinha);
    
{    strLinha := fPadR('002',10)    + '|' +  // codigo
                fPadR('VAREJO',50) + '|';   // descricao
    lstTexto.Add(strLinha);
    
    strLinha := fPadR('003',10)      + '|' +  // codigo
                fPadR('ESPECIAL',50) + '|';   // descricao
    lstTexto.Add(strLinha);}
    
    lstTexto.SaveToFile(strPath + '\' + strNomArq);
    
    chkReg.Visible := True;
    Repaint;

  Finally
    If (lstTexto <> Nil) Then
      FreeAndNil(lstTexto);
  End;

End;

{*****************************************}
{* TABELA ACACIA: T_STATUSCLIENTE        *}
{**************************************LU*}
procedure TfrmTxtACACIAServer.pExp_StatusCliente;
Var
  strNomArq: String;
  strLinha : String;
  lstTexto : TStringList;
Begin
  Try
    {*******************}
    {* NOME DO ARQUIVO *}
    {****************LU*}
    strNomArq := 'STATUSCLIENTE' + FormatDateTime('yyyyMMdd',VS_Date)  + FormatDateTime('hhmmss',fTime()) + '.TXT';
    
    lstTexto := TStringList.Create;
    
    strLinha := fPadR('001',10)    + '|' +  // codigo
                fPadR('ATIVO',100) + '|' +  // descricao
                '0'                + '|' +  // flag bloqueado
                '0'                + '|' +  // flag bloquear ped
                '1'                + '|';   // flag lim. credito
    lstTexto.Add(strLinha);
    
    strLinha := fPadR('002',10)      + '|' +   // codigo
                fPadR('INATIVO',100) + '|' +   // descricao
                '1'                  + '|' +   // flag bloqueado
                '1'                  + '|' +   // flag bloquear ped
                '1'                  + '|';    // flag lim. credito
    lstTexto.Add(strLinha);
    
    lstTexto.SaveToFile(strPath + '\' + strNomArq);
    
    chkStC.Visible := True;
    Repaint;

  Finally
    If (lstTexto <> Nil) Then
      FreeAndNil(lstTexto);
  End;
End;

{*****************************************}
{* TABELA ACACIA: T_STATUSPRODUTO        *}
{**************************************LU*}
procedure TfrmTxtACACIAServer.pExp_StatusProduto;
Var
  strNomArq: String;
  strLinha : String;
  lstTexto : TStringList;
Begin
  Try
    {*******************}
    {* NOME DO ARQUIVO *}
    {****************LU*}
    strNomArq := 'STATUSPRODUTO' + FormatDateTime('yyyyMMdd',VS_Date)  + FormatDateTime('hhmmss',fTime()) + '.TXT';
  
    lstTexto := TStringList.Create;
  
    strLinha := fPadR('001',10)    + '|' +  // codigo
                fPadR('ATIVO',100) + '|' +  // descricao
                ' '                + '|';   // flag para controle
    lstTexto.Add(strLinha);
  
    strLinha := fPadR('002',10)        + '|' +  // codigo
                fPadR('BLOQUEADO',100) + '|' +  // descricao
                ' '                    + '|';   // flag para controle
    lstTexto.Add(strLinha);
  
    strLinha := fPadR('003',10)       + '|' +  // codigo
                fPadR('SUSPENSO',100) + '|' +  // descricao
                ' '                   + '|';   // flag para controle
    lstTexto.Add(strLinha);
  
    lstTexto.SaveToFile(strPath + '\' + strNomArq);
  
    chkStP.Visible := True;
    Repaint;

  Finally
    If (lstTexto <> Nil) Then
      FreeAndNil(lstTexto);
  End;
End;

{*****************************************}
{* TABELA ACACIA: T_CONDPAGTO            *}
{**************************************LU*}
procedure TfrmTxtACACIAServer.pExp_CondicaoPagto;
Var
  strSQL   : String;
  strNomArq: String;
  strLinha : String;
  strFatAca: String;
  strValMin: String;
  strConPag: String;
  lstTexto : TStringList;
Begin

  Try
    {*******************}
    {* NOME DO ARQUIVO *}
    {****************LU*}
    strNomArq := 'CONDPGTO' + FormatDateTime('yyyyMMdd',VS_Date)  + FormatDateTime('hhmmss',fTime()) + '.TXT';

    strSQL := '';
    strSQL := strSQL + ' SELECT                         ';
    strSQL := strSQL + '   CND_CODIGO AS CODIGO,        ';
    strSQL := strSQL + '   CND_CNDPAG AS CNDPAG,        ';
    strSQL := strSQL + '   CND_FATACA AS FATACA,        ';
    strSQL := strSQL + '   CND_VALMIN AS VALMIN,        ';
    strSQL := strSQL + '   LEFT(CND_CNDPAG,2) AS NROPAR ';
    strSQL := strSQL + ' FROM                           ';
    strSQL := strSQL + '   CADCND                       ';

    If Not fCfgSis('CNDINA', varBoolean) Then
      strSQL := strSQL + ' WHERE LOCATE(' + QuotedStr(VS_strCodEmp) + ', CND_EMPACE) > 0 ';

    With qryCndPgto Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
    End;

    dspCndPgto.DataSet := qryCndPgto;
    cdsCndPgto.Close;
    cdsCndPgto.SetProvider(dspCndPgto);
    cdsCndPgto.Open;

    With cdsCndPgto Do
    Begin

      If Not IsEmpty Then
      Begin
        lstTexto := TStringList.Create;

        While Not Eof Do
        Begin
          Application.ProcessMessages;
          strFatAca := AnsiReplaceStr(FormatFloat('##0.0000',fieldbyname('FATACA').AsFloat),',','.');
          strValMin := AnsiReplaceStr(FormatFloat('##0.00',fieldbyname('VALMIN').AsFloat),',','.');

          strConPag := fFormataCondPag(fieldbyname('CNDPAG').AsString);
          strConpag := fPadR(Copy(strConPag, 1, 4) + ' ' + Copy(strConpag, 5, Length(strConPag)), 52);

          strLinha  := '';
          strLinha  := fPadR(fPadL(fieldbyname('CODIGO').AsString, 5, '0')  ,10)                       + '|' + // codigo da cond. pagto
                       strConPag                                                                       + '|' + // descricao
                       fPadL(FloatToStr(round(fCalcMediaPagto(fieldbyname('CNDPAG').AsString))),3,'0') + '|' + // prazo médio
                       '00000000000.00'                                                                + '|' + // indice da cond. pagto
                       fPadR('001',20)                                                                 + '|' + // cód. da tabela de preco
                       fPadL(strFatAca,14,'0')                                                         + '|' + // % máxima de desconto permitido
                       fPadR(fieldbyname('NROPAR').AsString,2)                                         + '|' + // nro de parcelas
                       fPadR(fCfgSis('CODACA'),10)                                                     + '|' + // codigo empresa na ACACIA
                       fPadR(' ',10)                                                                   + '|' + // flag especial
                       fPadL(strValMin,10,'0')                                                         + '|' ; // valor minimo para pedido
          lstTexto.Add(strLinha);

          Next;
          pProgresso(RecNo, RecordCount);
        End;
        lstTexto.SaveToFile(strPath + '\' + strNomArq);
        chkCnd.Visible := True;
      End;

    End;

  Finally
    cdsCndPgto.Close;

    If (lstTexto <> Nil) Then
      FreeAndNil(lstTexto);
  End;

End;

{*****************************************}
{* TABELA ACACIA: T_FORMAPAGTO           *}
{**************************************LU*}
procedure TfrmTxtACACIAServer.pExp_FormaPagto;
Var
  strSQL   : String;
  strNomArq: String;
  strLinha : String;
  lstTexto : TStringList;
Begin

  Try
    {*******************}
    {* NOME DO ARQUIVO *}
    {****************LU*}
    strNomArq := 'FORMAPGTO' + FormatDateTime('yyyyMMdd',VS_Date)  + FormatDateTime('hhmmss',fTime()) + '.TXT';

    strSQL := '';
    strSQL := strSQL + ' SELECT        ';
    strSQL := strSQL + '   FPG_CODIGO, ';
    strSQL := strSQL + '   FPG_DESCRI  ';
    strSQL := strSQL + ' FROM          ';
    strSQL := strSQL + '   CADFPG      ';

    With qryGenerica Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
    End;

    dspGenerica.DataSet := qryGenerica;
    cdsGenerica.Close;
    cdsGenerica.SetProvider(dspGenerica);
    cdsGenerica.Open;

    With cdsGenerica Do
    Begin

      If Not IsEmpty Then
      Begin
        lstTexto := TStringList.Create;

        While Not Eof Do
        Begin
          Application.ProcessMessages;
          strLinha := '';
          strLinha := fPadR(fieldbyname('FPG_CODIGO').AsString,10) + '|' + // codigo da forma pagto
                      fPadR(fieldbyname('FPG_DESCRI').AsString,50) + '|' + // descricao
                      '0'                                          + '|' + // valor mínimo
                      '0'                                          + '|' + // hierarquia
                      fPadR(fCfgSis('CODACA'),10)                  + '|';  // codigo empresa na ACACIA
          lstTexto.Add(strLinha);

          Next;
          pProgresso(RecNo, RecordCount);
        End;
        lstTexto.SaveToFile(strPath + '\' + strNomArq);
        chkFPG.Visible := True;
      End;

    End;

  Finally
    cdsGenerica.Close;

    If (lstTexto <> Nil) Then
      FreeAndNil(lstTexto);
  End;

End;

{*****************************************}
{* TABELA ACACIA: T_FORMACONDPGTO        *}
{**************************************JC*}
procedure TfrmTxtACACIAServer.pExp_FormaCondPgto;
Var
  strSQL   : String;
  strNomArq: String;
  strLinha : String;
  lstTexto : TStringList;
Begin

  Try
    {*******************}
    {* NOME DO ARQUIVO *}
    {****************JC*}
    strNomArq := 'FORMACONDPGTO' + FormatDateTime('yyyyMMdd',VS_Date)  + FormatDateTime('hhmmss',fTime()) + '.TXT';

    strSQL := '';
    strSQL := strSQL + ' SELECT                    ';
    strSQL := strSQL + ' 	FPG_CODIGO,              ';
    strSQL := strSQL + ' 	CND_CODIGO               ';
    strSQL := strSQL + ' FROM                      ';
    strSQL := strSQL + ' 	CADCND,                  ';
    strSQL := strSQL + ' 	CADFPG                   ';
    strSQL := strSQL + ' WHERE                     ';
    strSQL := strSQL + ' 	CND_CODFPG = FPG_CODIGO  ';
    strSQL := strSQL + ' ORDER BY                  ';
    strSQL := strSQL + ' 	CND_CODIGO               ';

    With qryGenerica Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
    End;

    dspGenerica.DataSet := qryGenerica;
    cdsGenerica.Close;
    cdsGenerica.SetProvider(dspGenerica);
    cdsGenerica.Open;

    With cdsGenerica Do
    Begin

      If Not IsEmpty Then
      Begin
        lstTexto := TStringList.Create;

        While Not Eof Do
        Begin
          Application.ProcessMessages;
          strLinha := '';
          strLinha := fPadR(fieldbyname('FPG_CODIGO').AsString,10)                 + '|' + // codigo da forma pagto
                      fPadR(fPadL(fieldbyname('CND_CODIGO').AsString, 5, '0'), 10) + '|' ; // codigo da Cond. pagto
          lstTexto.Add(strLinha);

          Next;
          pProgresso(RecNo, RecordCount);          
        End;
        lstTexto.SaveToFile(strPath + '\' + strNomArq);
      End;

    End;

  Finally
    cdsGenerica.Close;

    If (lstTexto <> Nil) Then
      FreeAndNil(lstTexto);

  End;

End;

{*****************************************}
{* TABELA ACACIA: T_TIPOPEDIDO           *}
{**************************************LU*}
procedure TfrmTxtACACIAServer.pExp_TipoPedido;
Var
  strNomArq: String;
  strLinha : String;
  lstTexto : TStringList;
Begin
  Try
    {*******************}
    {* NOME DO ARQUIVO *}
    {****************LU*}
    strNomArq := 'TIPOSPEDIDO' + FormatDateTime('yyyyMMdd',VS_Date)  + FormatDateTime('hhmmss',fTime()) + '.TXT';
    
    lstTexto := TStringList.Create;
    
    strLinha := fPadR('00',10) + '|' +  // codigo
                fPadR('NF',50) + '|';   // descricao
    lstTexto.Add(strLinha);
    
    strLinha := fPadR('01',10)    + '|' + // codigo
                fPadR('MI/FF',50) + '|';  // descricao
    lstTexto.Add(strLinha);
    
    strLinha := fPadR('02',10)     + '|' + // codigo
                fPadR('BRINDE',50) + '|';  // descricao
    lstTexto.Add(strLinha);
    
    lstTexto.SaveToFile(strPath + '\' + strNomArq);
    
    chkTPe.Visible := True;
    Repaint;

  Finally
    If (lstTexto <> Nil) Then
      FreeAndNil(lstTexto);
  End;
End;

{*****************************************}
{* TABELA ACACIA: TE_TITULO              *}
{**************************************LU*}
procedure TfrmTxtACACIAServer.pExp_TituloAberto;
Var
  strSQL   : String;
  strNomArq: String;
  strLinha : String;
  lstTexto : TStringList;
  strValOri: String;
  strValDup: String;
  strJurAtr: String;
Begin

  Try
    {*******************}
    {* NOME DO ARQUIVO *}
    {****************LU*}
    strNomArq := 'TITULOS' + FormatDateTime('yyyyMMdd',VS_Date)  + FormatDateTime('hhmmss',fTime()) + '.TXT';

    strSQL := '';
    strSQL := strSQL + ' SELECT                                                          ';
    strSQL := strSQL + '   CTR_CODCLI AS CODCLI,                                         ';
    strSQL := strSQL + '   CONCAT(CTR_NUMDUP,CTR_PARCEL, CTR_ESPDOC) AS NUMDOC,          ';
    strSQL := strSQL + '   CTR_NUMDUP AS NUMDUP,                                         ';
    strSQL := strSQL + '   CTR_PARCEL AS PARCEL,                                         ';
    strSQL := strSQL + '   CTR_DTACAD AS DTACAD,                                         ';
    strSQL := strSQL + '   CTR_DTAVEN AS DTAVEN,                                         ';
    strSQL := strSQL + '   CTR_VALORI AS VALORI,                                         ';
    strSQL := strSQL + '   CTR_VALDUP AS VALDUP                                          ';
    strSQL := strSQL + ' FROM                                                            ';
    strSQL := strSQL + '   CADREC                                                        ';
    strSQL := strSQL + '   JOIN CADCLI ON (CLI_CODCLI = CTR_CODCLI AND CLI_STATUS = "A") ';
    strSQL := strSQL + ' WHERE                                                           ';
    strSQL := strSQL + '   CTR_DTAREC IS NULL                                            ';

    With qryGenerica Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
    End;

    dspGenerica.DataSet := qryGenerica;
    cdsGenerica.Close;
    cdsGenerica.SetProvider(dspGenerica);
    cdsGenerica.Open;

    With cdsGenerica Do
    Begin

      If Not IsEmpty Then
      Begin
        lstTexto := TStringList.Create;

        While Not Eof Do
        Begin
          Application.ProcessMessages;

          strValOri := AnsiReplaceStr(FormatFloat('##0.00',fieldbyname('VALORI').AsFloat),',','.');
          strValDup := AnsiReplaceStr(FormatFloat('##0.00',fieldbyname('VALDUP').AsFloat),',','.');
          strJurAtr := AnsiReplaceStr(FormatFloat('##0.00',fCfgSis('JURATR', varDouble)),',','.');

          strLinha := '';
          strLinha := fPadR(fieldbyname('CODCLI').AsString,20)                    + '|' + // código do cliente
                      fPadR(fieldbyname('NUMDOC').AsString,20)                    + '|' + // número do documento
                      fPadR(fRetNroParcela(fieldbyname('PARCEL').AsString),10)    + '|' + // parcela
                      fPadR(' ',10)                                               + '|' + // tipo de documento
                      FormatDateTime('ddMMyyyy',fieldbyname('DTACAD').AsDateTime) + '|' + // data emissão
                      FormatDateTime('ddMMyyyy',fieldbyname('DTAVEN').AsDateTime) + '|' + // data vencimento
                      fPadL(strValOri,14,'0')                                     + '|' + // valor original
                      fPadL(strValDup,14,'0')                                     + '|' + // saldo do titulo
                      fPadR(fieldbyname('NUMDUP').AsString,20)                    + '|' + // número da nota fiscal
                      fPadL(strJurAtr,14,'0')                                     + '|' + // taxa de juros
                      '00000000000.00'                                            + '|' + // valor pago
                      fPadR(' ',8)                                                + '|' + // data de pagto
                      fPadR(fCfgSis('CODACA'),10)                                 + '|' + // codigo empresa na ACACIA
                      fPadR(' ',30)                                               + '|';  // nome do banco

          lstTexto.Add(strLinha);

          Next;
          pProgresso(RecNo, RecordCount);
        End;
        lstTexto.SaveToFile(strPath + '\' + strNomArq);
        chkTit.Visible := True;
      End;

    End;

  Finally
    cdsGenerica.Close;

    If (lstTexto <> Nil) Then
      FreeAndNil(lstTexto);
  End;

End;

procedure TfrmTxtACACIAServer.tmrFechaTimer(Sender: TObject);
begin
  inherited;

 If blnGerou Then
    Self.Close;
    
end;

procedure TfrmTxtACACIAServer.FormActivate(Sender: TObject);
begin
  inherited;

  If blnGeracaoAut And (Not blnGerou) Then
  Begin
    btnConfirma.Click;
    blnGerou := True;
    tmrFecha.Enabled := True;
  End;

end;

procedure TfrmTxtACACIAServer.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  FreeAndNil(dspGenerica);
  FreeAndNil(cdsGenerica);

  FreeAndNil(dspProduto);
  FreeAndNil(cdsProduto);

  FreeAndNil(dspCliente);
  FreeAndNil(cdsCliente);

  FreeAndNil(dspNotaFiscal);
  FreeAndNil(cdsNotaFiscal);

  FreeAndNil(dspPedido);
  FreeAndNil(cdsPedido);

  FreeAndNil(dspCndPgto);
  FreeAndNil(cdsCndPgto);

  FreeAndNil(lstTextoNF);
  FreeAndNil(lstTextoNFI);
  FreeAndNil(lstTextoPD);
  FreeAndNil(lstTextoPDI);

end;

procedure TfrmTxtACACIAServer.FormCreate(Sender: TObject);
begin
  inherited;
  qryGenerica := TUniQuery.Create(Self);
  qryGenerica.Connection := frmModulo.GetCurrentConnection;
  dspGenerica := TUniDataSetProvider.Create(Self);
  cdsGenerica := TUniClientDataSet.Create(Self);
  cdsGenerica.DisableControls;

  qryProduto := TUniQuery.Create(Self);
  qryProduto.Connection := frmModulo.GetCurrentConnection;
  dspProduto := TUniDataSetProvider.Create(Self);
  cdsProduto := TUniClientDataSet.Create(Self);
  cdsProduto.DisableControls;

  qryCliente := TUniQuery.Create(Self);
  qryCliente.Connection := frmModulo.GetCurrentConnection;
  dspCliente := TUniDataSetProvider.Create(Self);
  cdsCliente := TUniClientDataSet.Create(Self);
  cdsCliente.DisableControls;

  qryNotaFiscal := TUniQuery.Create(Self);
  qryNotaFiscal.Connection := frmModulo.GetCurrentConnection;
  dspNotaFiscal := TUniDataSetProvider.Create(Self);
  cdsNotaFiscal := TUniClientDataSet.Create(Self);
  cdsNotaFiscal.DisableControls;

  qryPedido := TUniQuery.Create(Self);
  qryPedido.Connection := frmModulo.GetCurrentConnection;
  dspPedido := TUniDataSetProvider.Create(Self);
  cdsPedido := TUniClientDataSet.Create(Self);
  cdsPedido.DisableControls;

  qryCndPgto := TUniQuery.Create(Self);
  qryCndPgto.Connection := frmModulo.GetCurrentConnection;
  dspCndPgto := TUniDataSetProvider.Create(Self);
  cdsCndPgto := TUniClientDataSet.Create(Self);
  cdsCndPgto.DisableControls;

  blnGeracaoAut := False;
  blnGerou      := False;
end;

procedure TfrmTxtACACIAServer.FormShow(Sender: TObject);
begin
  inherited;
  dirPathExp.edtDirectory.text := fCfgSis('EXPACA');

  If (blnGeracaoAut) Then
  Begin
    If (fEmptyStr(dirPathExp.edtDirectory.text)) Then
      dirPathExp.edtDirectory.text := 'C:\ACACIA\';
  End;
end;

function TfrmTxtACACIAServer.fRetNroParcela(strParcel: String): String;
Begin
       If strParcel = 'A' Then Result := '01'
  Else If strParcel = 'B' Then Result := '02'
  Else If strParcel = 'C' Then Result := '03'
  Else If strParcel = 'D' Then Result := '04'
  Else If strParcel = 'E' Then Result := '05'
  Else If strParcel = 'F' Then Result := '06'
  Else If strParcel = 'G' Then Result := '07'
  Else If strParcel = 'H' Then Result := '08'
  Else If strParcel = 'I' Then Result := '09'
  Else If strParcel = 'J' Then Result := '10'
  Else If strParcel = 'K' Then Result := '11'
  Else If strParcel = 'L' Then Result := '12';
End;

function TfrmTxtACACIAServer.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If Inherited fValidaCampos(Sender, blnBuscaPorChave) Then
  Begin
    If (Sender = dirPathExp) Then
    Begin
      If fEmptyStr(dirPathExp.edtDirectory.text) Then
      Begin
        If (blnGeracaoAut) Then
          Result := False
        Else
        Begin
          fMensagem('','Informar o Path para exportação dos arquivos TXTs!', ['&Ok']);
          Result := False;
        End;
      End
      Else If Not DirectoryExists(dirPathExp.edtDirectory.text) Then
      Begin
        If (blnGeracaoAut) Then
        Begin
          If Not DirectoryExists(dirPathExp.edtDirectory.text) Then
            fCriaDiretorio(dirPathExp.edtDirectory.text);
        End
        Else
        Begin
          fMensagem('','Pasta não encontrada!', ['&Ok']);
          Result := FALSE;
        End;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmTxtACACIAServer.pCriaQueryPromocoes;
  Var
     strSql: String;
begin
  strSql := '';
  strSql := strSql + '  SELECT SQL_NO_CACHE     ';
  strSql := strSql + '  	IPR_CODITE AS CODITE, ';
  strSql := strSql + '    IPR_PREVEN AS PREVEN  ';
  strSql := strSql + '  FROM                    ';
  strSql := strSql + '    CADPRO                ';
  strSql := strSql + '    INNER JOIN ITEPRO ON CADPRO.AUTOINCREM = ITEPRO.IPR_SEQGER ';
  strSql := strSql + '    INNER JOIN PROEMP ON CADPRO.AUTOINCREM = PROEMP.PRO_SEQGER ';
  strSql := strSql + '  WHERE ';
  strSql := strSql + '    PROEMP.PRO_CODEMP  = :CODEMP AND ';
  strSql := strSql + '    PRO_DTAINI <= :DTAPRO AND PRO_DTAFIN >= :DTAPRO ';
  strSql := strSql + '  ORDER BY ';
  strSql := strSql + '    PRO_CODPRO ';

  qryItensPromocao := fCriaQuery(Self);

  With qryItensPromocao, SQL Do
  Begin
    Close;
    Clear;
    Add(strSql);
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    ParamByName('DTAPRO').AsDate   := VS_Date;
    Open;
    IndexFieldNames := 'CODITE';
   End;
   
end;

procedure TfrmTxtACACIAServer.pProgresso(intPos, intMax: Integer);
begin
  pgbProgresso.Max := intMax;
  pgbProgresso.Position := intPos;
end;

end.
