unit untTxtImpFullSoftTablet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, BitBtnLockedIncrem,
  ExtCtrls, Mask, FilenameEditFocus, DBClient, DB, ComCtrls, Uni, Grids, DBGridCitel, DBGrids,
  ImgList, UniClientDataSet, StrUtils, frxClass, frxExportCSVTestabilidade,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, System.ImageList, cxTextEdit,
  cxMaskEdit, cxButtonEdit;

type
  TValidaFunction = Function (var strMensag : String) : Boolean of Object;

type
  TRecTraduz = Record
    strCampoFullSoft : String;
    strCampoAutcom   : String;
  End;

type
  TArrRecTraduz = Array of TRecTraduz;

type
  TfrmTxtImpFullSoftTablet = class(TfrmPai)
    dirFileImp: TFilenameEditFocus;
    Label17: TLabel;
    pgbImporta: TProgressBar;
    btnGravar: TBitBtnLocked;
    mmoMsgs: TMemo;
    Label3: TLabel;
    PageControl1: TPageControl;
    tabPedido: TTabSheet;
    tabCliente: TTabSheet;
    dbgPedido: TDBGridCitel;
    dbgItens: TDBGridCitel;
    Label2: TLabel;
    Splitter1: TSplitter;
    dbgCliente: TDBGridCitel;
    tabManutencao: TTabSheet;
    dbgItenMan: TDBGridCitel;
    Label1: TLabel;
    dbgManuten: TDBGridCitel;
    Splitter2: TSplitter;
    imgLista: TImageList;
    procedure dirFileImpPropertiesChange(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbgPedidoDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgItenManCellClick(Column: TColumn);
    procedure dbgItenManKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    blnEmpFat     : Boolean;

    FcdsPedido    : TUniClientDataSet;
    FcdsItens     : TUniClientDataSet;
    FcdsCliente   : TUniClientDataSet;
    FcdsManuten   : TUniClientDataSet;
    FcdsItenMan   : TUniClientDataSet;

    FdtsPedido    : TDataSource;
    FdtsItens     : TDataSource;
    FdtsCliente   : TDataSource;
    FdtsManuten   : TDataSource;
    FdtsItenMan   : TDataSource;

    qryCadIte     : TUniQuery;

    FstrNumDoc    : String;
    FstrNumTablet : String;
    clrZebra      : TColor;
    intIteDoc     : Integer;

    Procedure pCriaCdsPedido(var cdsDados : TUniClientDataSet);
    Procedure pCriaCdsItensPedido(var cdsDados : TUniClientDataSet);
    Procedure pCriaCdsClientes(var cdsDados : TUniClientDataSet);
    Procedure pCriaCdsManuten(var cdsDados : TUniClientDataSet);
    Procedure pCriaCdsItenMan(var cdsDados : TUniClientDataSet);

    Procedure pFormataNumericos(DataSet : TDataSet);

    Procedure pImportarRegistros(strArqName : String);
    Procedure pImportaRegistro(var strLinha : String; cdsDados : TUniClientDataSet; fntValida : TValidaFunction); overload;
    Procedure pImportaRegistro(var strLinha : String; cdsDados : TUniClientDataSet); overload;
    Function fProximoCampo(var strLinha : String) : String;

    Function fValidaCliente(Var strMensag : String): Boolean;
    Function fValidaPedido(var strMensag : String) : Boolean;
    Function fValidaItem(var strMensag : String) : Boolean;

    Function fGravaRegistros      : Boolean;
    Function fGraFatGor           : Boolean;
    Function fGraDetGor(strAutFgo, strNumDoc : String) : Boolean;
    Function fCarregaItem(strCodIte, strCodEmp: String): Boolean;

    Function fImportarClientes   : Boolean;
    Function fImportarPedidos    : Boolean;
    Function fEfetuarManutencoes : Boolean;

    procedure pAfterScrollPedido(DataSet: TDataSet);
    procedure pAfterScrollManutencao(DataSet: TDataSet);
    procedure pMarcaDesmarca;

    function fPedidoJaImportado(strNumPok: String; var stlDocume: TStringList): Boolean;
    function fTabelaValida(strTabPre: String): Boolean;
    function fGetTabPreco(strTabPre: String): String;
  public
    { Public declarations }
  end;

implementation

uses untFatGor, untFuncoesGenerica,
     untFuncoesSimples, untFuncoes,
     untTextStream, untTypesSistema;

{$R *.dfm}

{ TfrmTxtImpFullSoftTablet }

procedure TfrmTxtImpFullSoftTablet.btnGravarClick(Sender: TObject);
begin
  inherited;
  fGravaRegistros;
end;

procedure TfrmTxtImpFullSoftTablet.dbgItenManCellClick(Column: TColumn);
begin
  inherited;
  If SameText(Column.Field.FieldName,'MARCA') then
    pMarcaDesmarca;
end;

procedure TfrmTxtImpFullSoftTablet.dbgItenManKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_SPACE) or (Key = VK_RETURN) Then
    pMarcaDesmarca;
end;

procedure TfrmTxtImpFullSoftTablet.dbgPedidoDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  With TDBGridCitel(Sender) Do
  Begin
    if Odd(DataSource.DataSet.RecNo) Then
      Canvas.Brush.Color := clrZebra;
    DefaultDrawColumnCell(Rect, DataCol, Column, State);
  End;

  if SameText(Column.Field.FieldName, 'MARCA') then
  Begin
    TDBGridCitel(Sender).Canvas.FillRect(Rect);
    imgLista.Draw(TDBGridCitel(Sender).Canvas, Rect.Left+1, Rect.Top, 0);
    If Column.Field.AsBoolean then
      imgLista.Draw(TDBGridCitel(Sender).Canvas, Rect.Left+1, Rect.Top+1, 1)
    Else
      imgLista.Draw(TDBGridCitel(Sender).Canvas, Rect.Left+1, Rect.Top+1, 2);
  end;
end;

procedure TfrmTxtImpFullSoftTablet.dirFileImpPropertiesChange(Sender: TObject);
begin
  inherited;
  if FileExists(dirFileImp.Dialog.Dialog.FileName) Then
    pImportarRegistros(dirFileImp.Dialog.Dialog.FileName);
end;

Function TfrmTxtImpFullSoftTablet.fGravaRegistros : Boolean;
begin
  fStartTransaction;
  Try
    Try
      Screen.Cursor := crHourGlass;
      mmoMsgs.Lines.Clear;

      Result := fImportarClientes;

      If Result Then
        Result := fImportarPedidos;

      If Result Then
        Result := fEfetuarManutencoes;

      If Result Then
      Begin
        fCommit;
        pMensagemOk('Registro(s) Importado(s) com Sucesso!');
        RenameFile(dirFileImp.Dialog.Dialog.FileName, ChangeFileExt(dirFileImp.Dialog.Dialog.FileName,'.IMP'));
      End
      Else
      Begin
        fRollBack;
        pMensagemOk('Falha ao importar Pedido(s), Nenhum Item foi importado!');
      End;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        Result := False;
        pMensagensErro(E.Message, '[TfrmTxtImpFullSoftTablet.fGravaRegistros]');
      End;
    End;
  Finally
    FcdsPedido.EmptyDataSet;
    FcdsItens.EmptyDataSet;
    FcdsCliente.EmptyDataSet;
    FcdsManuten.EmptyDataSet;
    FcdsItenMan.EmptyDataSet;
    Screen.Cursor := crDefault;
    pgbImporta.Visible := False;
    dirFileImp.Clear;
    pSetFocus(dirFileImp);
    btnGravar.Enabled := False;
  End;
end;

function TfrmTxtImpFullSoftTablet.fImportarClientes: Boolean;
  Var
    qryInsCli : TUniQuery;
    strCodCli : String;
begin
  Try
    With FcdsCliente Do
    Begin
      DisableControls;
      pgbImporta.Position := 0;
      pgbImporta.Max      := RecordCount;
      pgbImporta.Visible  := True;

      qryInsCli := fCriaQuery(Self);

      First;
      While not Eof Do
      Begin
        qryInsCli.SQL.Clear;
        qryInsCli.SQL.Add ('INSERT INTO CADCLI( ');
        qryInsCli.SQL.Add ('CLI_CODCLI, ');
        qryInsCli.SQL.Add ('CLI_CODEMP, ');
        qryInsCli.SQL.Add ('CLI_NOMCLI, ');
        qryInsCli.SQL.Add ('CLI_FANSOB, ');
        qryInsCli.SQL.Add ('CLI_CGCCPF, ');
        qryInsCli.SQL.Add ('CLI_C_G_C_, ');
        qryInsCli.SQL.Add ('CLI_EMAIL_, ');
        qryInsCli.SQL.Add ('CLI_EMAIL3, ');
        qryInsCli.SQL.Add ('CLI_CODREP, ');
        qryInsCli.SQL.Add ('CLI_OBS_01, ');
        qryInsCli.SQL.Add ('CLI_OBS_02, ');
        qryInsCli.SQL.Add ('CLI_OBS_03, ');
        qryInsCli.SQL.Add ('CLI_OBS_04, ');
        qryInsCli.SQL.Add ('CLI_DTACAD, ');
        qryInsCli.SQL.Add ('CLI_RETPCO, ');
        qryInsCli.SQL.Add ('CLI_RETIRF, ');
        qryInsCli.SQL.Add ('CLI_RETISS, ');
        qryInsCli.SQL.Add ('CLI_ALQISS, ');
        qryInsCli.SQL.Add ('CLI_SEGSOC, ');
        qryInsCli.SQL.Add ('CLI_CODEAC, ');
        qryInsCli.SQL.Add ('CLI_SITIPI, ');
        qryInsCli.SQL.Add ('CLI_ENQIPI, ');
        qryInsCli.SQL.Add ('CLI_MENIPI, ');
        qryInsCli.SQL.Add ('CLI_ORGPUB, ');
        qryInsCli.SQL.Add ('CLI_ZONFRA, ');
        qryInsCli.SQL.Add ('CLI_STATUS, ');
        qryInsCli.SQL.Add ('CLI_CODVEN, ');
        qryInsCli.SQL.Add ('CLI_CODATI, ');
        qryInsCli.SQL.Add ('CLI_LIMCRE, ');
        qryInsCli.SQL.Add ('CLI_TABPRE, ');
        qryInsCli.SQL.Add ('CLI_ENVBOL, ');
        qryInsCli.SQL.Add ('CLI_CONSUM, ');
        qryInsCli.SQL.Add ('AUTOINCREM, ');
        qryInsCli.SQL.Add ('CLI_I_E_S_, ');
        qryInsCli.SQL.Add ('CLI_CODPOR, ');
        qryInsCli.SQL.Add ('CLI_ENDERE, ');
        qryInsCli.SQL.Add ('CLI_ENDNUM, ');
        qryInsCli.SQL.Add ('CLI_ENDCOM, ');
        qryInsCli.SQL.Add ('CLI_BAIRRO, ');
        qryInsCli.SQL.Add ('CLI_C_E_P_, ');
        qryInsCli.SQL.Add ('CLI_CODCID, ');
        qryInsCli.SQL.Add ('CLI_FONE01, ');
        qryInsCli.SQL.Add ('CLI_OPECAD, ');
        qryInsCli.SQL.Add ('CLI_CODOPE, ');
        qryInsCli.SQL.Add ('CLI_ULTALT, ');
        qryInsCli.SQL.Add ('CLI_CONTAT, ');
        qryInsCli.SQL.Add ('CLI_OBSERV) ');

        qryInsCli.SQL.Add ('VALUES ( ');
        qryInsCli.SQL.Add (':CODCLI, ');       //CLI_CODCLI
        qryInsCli.SQL.Add (':CODEMP, ');       //CLI_CODEMP
        qryInsCli.SQL.Add (':NOMCLI, ');       //CLI_NOMCLI
        qryInsCli.SQL.Add (':FANSOB, ');       //CLI_FANSOB
        qryInsCli.SQL.Add (':CGCCPF, ');       //CLI_CGCCPF
        qryInsCli.SQL.Add (':C_G_C_, ');       //CLI_C_G_C_
        qryInsCli.SQL.Add (':EMAIL_, ');       //CLI_EMAIL_
        qryInsCli.SQL.Add (':EMAIL3, ');       //CLI_EMAIL3
        qryInsCli.SQL.Add (':CODREP, ');       //CLI_CODREP
        qryInsCli.SQL.Add (':OBS_01, ');       //CLI_OBS_01
        qryInsCli.SQL.Add (':OBS_02, ');       //CLI_OBS_02
        qryInsCli.SQL.Add (':OBS_03, ');       //CLI_OBS_03
        qryInsCli.SQL.Add (':OBS_04, ');       //CLI_OBS_04
        qryInsCli.SQL.Add (':DTACAD, ');       //CLI_DTACAD
        qryInsCli.SQL.Add ('"N", ');           //CLI_RETPCO
        qryInsCli.SQL.Add ('"N", ');           //CLI_RETIRF
        qryInsCli.SQL.Add ('"N", ');           //CLI_RETISS
        qryInsCli.SQL.Add ('0, ');             //CLI_ALQISS
        qryInsCli.SQL.Add ('"N", ');           //CLI_SEGSOC
        qryInsCli.SQL.Add ('"N", ');           //CLI_CODEAC
        qryInsCli.SQL.Add ('"T", ');           //CLI_SITIPI
        qryInsCli.SQL.Add ('"999", ');         //CLI_ENQIPI
        qryInsCli.SQL.Add ('" ", ');           //CLI_MENIPI
        qryInsCli.SQL.Add ('"N", ');           //CLI_ORGPUB
        qryInsCli.SQL.Add ('"N", ');           //CLI_ZONFRA
        qryInsCli.SQL.Add ('"A", ');           //CLI_STATUS
        qryInsCli.SQL.Add (':CODREP, ');       //CLI_CODVEN
        qryInsCli.SQL.Add (':CODATI, ');       //CLI_CODATI
        qryInsCli.SQL.Add (':LIMCRE, ');       //CLI_LIMCRE
        qryInsCli.SQL.Add ('1, ');             //CLI_TABPRE
        qryInsCli.SQL.Add ('"N", ');           //CLI_ENVBOL
        qryInsCli.SQL.Add ('"N", ');           //CLI_CONSUM
        qryInsCli.SQL.Add (':AUTOINCREM,');    //AUTOINCREM
        qryInsCli.SQL.Add (':I_E_S_, ');       //CLI_I_E_S_
        qryInsCli.SQL.Add (':CODPOR, ');       //CLI_CODPOR
        qryInsCli.SQL.Add (':ENDERE, ');       //CLI_ENDERE
        qryInsCli.SQL.Add (':ENDNUM, ');       //CLI_ENDNUM
        qryInsCli.SQL.Add (':ENDCOM, ');       //CLI_ENDCOM
        qryInsCli.SQL.Add (':BAIRRO, ');       //CLI_BAIRRO
        qryInsCli.SQL.Add (':C_E_P_, ');       //CLI_C_E_P_
        qryInsCli.SQL.Add (':CODCID, ');       //CLI_CODCID
        qryInsCli.SQL.Add (':FONE01, ');       //CLI_FONE01
        qryInsCli.SQL.Add (':OPECAD, ');
        qryInsCli.SQL.Add (':CODOPE, ');
        qryInsCli.SQL.Add (':DTAALT, ');
        qryInsCli.SQL.Add (':CONTAT, ');
        qryInsCli.SQL.Add (':OBSERV) ');

        strCodCli := fAtualizaProCod('CADCLI', 'CLI_CODCLI');

        qryInsCli.Close;
        qryInsCli.ParamByName('CODCLI').AsString     := strCodCli;
        qryInsCli.ParamByName('CODEMP').AsString     := FieldByName('CodEmpresaSync').AsString;
        qryInsCli.ParamByName('NOMCLI').AsString     := UpperCase(FieldByName('RazaoSocial').AsString);
        qryInsCli.ParamByName('FANSOB').AsString     := UpperCase(FieldByName('NomeFantasia').AsString);
        qryInsCli.ParamByName('CGCCPF').AsInteger    := IIF(FieldByName('TipoPessoa').AsInteger = 1, 2, 1);
        qryInsCli.ParamByName('C_G_C_').AsString     := IIF(FieldByName('TipoPessoa').AsInteger = 1, FieldByName('Cpf').AsString, FieldByName('Cnpj').AsString);
        qryInsCli.ParamByName('EMAIL_').AsString     := FieldByName('Email').AsString;
        qryInsCli.ParamByName('CODREP').AsString     := FieldByName('CodRepresentanteSync').AsString;
        if fEmptyStr(qryInsCli.ParamByName('CODREP').AsString) then
          qryInsCli.ParamByName('CODREP').Clear;
        qryInsCli.ParamByName('OBS_01').AsString     := UpperCase(Copy(FieldByName('Observacao').AsString, 001, 60));
        qryInsCli.ParamByName('OBS_02').AsString     := UpperCase(Copy(FieldByName('Observacao').AsString, 061, 60));
        qryInsCli.ParamByName('OBS_03').AsString     := UpperCase(Copy(FieldByName('Observacao').AsString, 121, 60));
        qryInsCli.ParamByName('OBS_04').AsString     := UpperCase(Copy(FieldByName('Observacao').AsString, 181, 60));
        qryInsCli.ParamByName('DTACAD').AsDateTime   := FieldByName('DtInclusao').AsDateTime;
        qryInsCli.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('CADCLI', VS_strCodEmp);
        qryInsCli.ParamByName('I_E_S_').AsString     := FieldByName('InscricaoEstadual').AsString;
        qryInsCli.ParamByName('CODPOR').AsString     := FieldByName('CodPortadorSync').AsString;
        if fEmptyStr(qryInsCli.ParamByName('CODPOR').AsString) then
          qryInsCli.ParamByName('CODPOR').Clear;
        qryInsCli.ParamByName('ENDERE').AsString     := FieldByName('Endereco').AsString;
        qryInsCli.ParamByName('ENDNUM').AsString     := FieldByName('NumeroEndereco').AsString;
        qryInsCli.ParamByName('ENDCOM').AsString     := FieldByName('ComplementoEndereco').AsString;
        qryInsCli.ParamByName('BAIRRO').AsString     := FieldByName('BairroEndereco').AsString;
        qryInsCli.ParamByName('C_E_P_').AsString     := FieldByName('CEP').AsString;
        qryInsCli.ParamByName('CODCID').AsString     := FieldByName('CodCidadeSync').AsString;
        qryInsCli.ParamByName('FONE01').AsString     := fAcertaMaskTel(FieldByName('TelefoneEndereco').AsString);
        qryInsCli.ParamByName('LIMCRE').AsFloat      := FieldByName('LimiteCredito').AsFloat;
        qryInsCli.ParamByName('CODATI').AsString     := FieldByName('CodRamoAtividadeSync').AsString;
        if fEmptyStr(qryInsCli.ParamByName('CODATI').AsString) then
          qryInsCli.ParamByName('CODATI').Clear;

        qryInsCli.ParamByName('OPECAD').AsString     := strLoginUsuarioLogado;
        qryInsCli.ParamByName('CODOPE').AsString     := strLoginUsuarioLogado;
        qryInsCli.ParamByName('DTAALT').AsDateTime   := VS_Date + fTime();
        qryInsCli.ParamByName('CONTAT').AsString     := FieldByName('NomeContato').AsString;
        qryInsCli.ParamByName('OBSERV').AsString     := FieldByName('Observacao').AsString;

        qryInsCli.ExecSQL;

        If not fEmptyStr(FieldByName('NomeContato').AsString) Then
        Begin
          qryInsCli.SQL.Clear;
          qryInsCli.Close;
          qryInsCli.SQL.Clear;
          qryInsCli.SQL.Add('INSERT INTO CLICTT  ');
          qryInsCli.SQL.Add('(                   ');
          qryInsCli.SQL.Add('  CLI_CODCLI,       ');
          qryInsCli.SQL.Add('  CLI_NOMCTT,       ');
          qryInsCli.SQL.Add('  CLI_TELCTT,       ');
          qryInsCli.SQL.Add('  CLI_CELCTT,       ');
          qryInsCli.SQL.Add('  CLI_EMACTT,       ');
          qryInsCli.SQL.Add('  CLI_CODEMP,       ');
          qryInsCli.SQL.Add('  CLI_CIDCTT,       ');
          qryInsCli.SQL.Add('  AUTOINCREM        ');
          qryInsCli.SQL.Add(') VALUES (          ');
          qryInsCli.SQL.Add('  :CODCLI,          ');
          qryInsCli.SQL.Add('  :NOMCTT,          ');
          qryInsCli.SQL.Add('  :TELCTT,          ');
          qryInsCli.SQL.Add('  :CELCTT,          ');
          qryInsCli.SQL.Add('  :EMACTT,          ');
          qryInsCli.SQL.Add('  :CODEMP,          ');
          qryInsCli.SQL.Add('  :CIDCTT,          ');
          qryInsCli.SQL.Add('  :AUTINC)          ');

          qryInsCli.ParamByName('CODCLI').AsString := strCodCli;
          qryInsCli.ParamByName('NOMCTT').AsString := FieldByName('NomeContato').AsString;
          qryInsCli.ParamByName('TELCTT').AsString := fAcertaMaskTel(FieldByName('TelefoneContato').AsString);
          qryInsCli.ParamByName('CELCTT').AsString := fAcertaMaskTel(FieldByName('CelularConato').AsString);
          qryInsCli.ParamByName('EMACTT').AsString := FieldByName('EmailContato').AsString;
          qryInsCli.ParamByName('CODEMP').AsString := FieldByName('CodEmpresaSync').AsString;
          qryInsCli.ParamByName('CIDCTT').AsString := FieldByName('CodCidadeSync').AsString;
          qryInsCli.ParamByName('AUTINC').AsString := fRetAutoIncrem('CLICTT', VS_strCodEmp);

          qryInsCli.Close;
          qryInsCli.ExecSQL;
        End;

        Edit;
        FieldByName('CodCliNovo').AsString := strCodCli;
        Post;

        Next;

        pgbImporta.Position := RecNo;
        Application.ProcessMessages;
      End;

      EnableControls;
    End;

    FreeAndNil(qryInsCli);
    Result := True;
  Except
    On E : Exception Do
    Begin
      pMensagensErro(e.Message,'TfrmTxtImpFullSoftTablet.fGravaRegistros');
      Result := False;
      FreeAndNil(qryInsCli);
      FcdsCliente.EnableControls;
    End;
  End;
end;

function TfrmTxtImpFullSoftTablet.fImportarPedidos: Boolean;
begin
  Result := True;
  With FcdsPedido Do
  Begin
    If IsEmpty Then
      Exit;

    DisableControls;
    Try
      pgbImporta.Position := 0;
      pgbImporta.Max      := RecordCount;
      pgbImporta.Visible  := True;

      mmoMsgs.Lines.Add( 'PEDIDO TABLET                   PEDIDO AUTCOM        STATUS' );
      //                  00128573_001088_00023600        000000600109-PD-007  OK - GERADO

      First;
      While not Eof Do
      Begin

        {******************************************************************}
        {* SE CLIENTE NOVO O CODIGO DO CLIENTE É O SEQUENCIAL DO CAD CLI  *}
        {***************************************************************GB*}
        if FieldByName('ClienteNovo').AsString = '1' Then
        begin
          FcdsCliente.RecNo := FieldByName('CodClienteSync').AsInteger;
          Edit;
          FieldByName('CodClienteSync').AsString := FcdsCliente.FieldByName('CodCliNovo').AsString;
          Post;
        End;

        Result := fGraFatGor;

        if Result Then
          Next
        Else
          Last;

        pgbImporta.Position := RecNo;
        Application.ProcessMessages;
      End;
    Finally
      EnableControls;
    End;
  End;

end;

procedure TfrmTxtImpFullSoftTablet.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  If Assigned(FcdsPedido) Then
   FreeAndNil(FcdsPedido);
  If Assigned(FcdsItens) Then
   FreeAndNil(FcdsItens);
  If Assigned(FcdsCliente) Then
   FreeAndNil(FcdsCliente);
  If Assigned(FdtsPedido) Then
   FreeAndNil(FdtsPedido);
  If Assigned(FdtsItens) Then
   FreeAndNil(FdtsItens);
  If Assigned(FdtsCliente) Then
   FreeAndNil(FdtsCliente);
  If Assigned(qryCadIte) Then
   FreeAndNil(qryCadIte);

  inherited;
end;

procedure TfrmTxtImpFullSoftTablet.FormCreate(Sender: TObject);
begin
  inherited;
  blnFecharComEscape := True;
  intIteDoc := fCfgSis('ITEDOC', varInteger);
  If intIteDoc <= 0 then
    intIteDoc := 9999;
  blnEmpFat := fCfgSis('EMPFAT', varBoolean);

  qryCadIte := fCriaQuery(Self);
  With qryCadIte Do
  Begin
    SQL.Add(' SELECT * ');
    SQL.Add(' FROM CADITE ');
    SQL.Add('   INNER JOIN ITEGER ');
    SQL.Add(' ON CADITE.ITE_CODITE = ITEGER.ITE_CODITE ');
    SQL.Add('     AND ITEGER.ITE_CODEMP = :CODEMP ');
    SQL.Add('     AND CADITE.ITE_CODITE = :CODITE ');
  End;

  clrZebra  := fCfgSis('CORZEB');

  dirFileImp.Dialog.Dialog.Filter := 'Arquivo Texto (*.txt)|*.txt';

end;

function TfrmTxtImpFullSoftTablet.fGraDetGor(strAutFgo, strNumDoc : String): Boolean;
  Var
    strAutInc : String;
    blnImpRef : Boolean;
    intQtdGra : Integer;
begin
  Result := False;
  Try
    blnImpRef := fCfgSis('IMPREF', varBoolean);
    Try
      With FcdsItens Do
      Begin
        DisableControls;
        Filter   := 'CodPedidoSync = ' + FcdsPedido.FieldByName('CodPedidoSync').AsString + ' AND ITEIMP = 0 ';
        Filtered := True;
        First;

        While (not Eof) And (RecNo <= intIteDoc) Do
        Begin
          If fCarregaItem(FieldByName('CodProdutoSync').AsString, FcdsPedido.FieldByName('CodEmpresaSync').AsString) Then
          Begin
            strAutInc := '';
            Result := fGravaFatDor( strAutInc,
                                    strAutFgo,                                                                             // strSeqGer
                                    FcdsPedido.FieldByName('CodEmpresaSync').AsString,                                     //  strCodEmp
                                    FcdsPedido.FieldByName('CodClienteSync').AsString,                                     //  strCodCli
                                    FcdsPedido.FieldByName('CodUsuarioSync').AsString,                                     //  strCodVen
                                    FieldByName('CodProdutoSync').AsString,                                                //  strCodIte
                                    qryCadIte.FieldByName('ITE_CODMAR').AsString,                                          //  strCodMar
                                    '',                                                                                    //  strCodDiv
                                    strNumDoc,                                                                             //  strNumDoc
                                    'PD',                                                                                  //  strEspDoc
                                    '',                                                                                    //  strSerie
                                    FcdsPedido.FieldByName('DtInicioPedido').AsDateTime,                                   //  dtaDtaEnt
                                    FcdsPedido.FieldByName('DtInicioPedido').AsDateTime,                                   //  dtaHorEnt
                                    fRetConPagCodCnd(FcdsPedido.FieldByName('CodCondicaoPagamentoSync').AsString),         //  strConPag
                                    '',                                                                                    //  strEstado
                                    IIF(blnImpRef,
                                          IIF(fCfgSis('MONDES', varString) = '1',
                                                qryCadIte.FieldByName('ITE_DESITE').AsString +
                                                IIF(Not fEmptyStr(qryCadIte.FieldByName('ITE_REFERE').AsString),' ' + qryCadIte.FieldByName('ITE_REFERE').AsString,''),
                                                IIF(Not fEmptyStr(qryCadIte.FieldByName('ITE_REFERE').AsString),qryCadIte.FieldByName('ITE_REFERE').AsString + ' ','') +
                                                qryCadIte.FieldByName('ITE_DESITE').AsString),
                                          qryCadIte.FieldByName('ITE_DESITE').AsString),                                                  //  strDescri
                                    qryCadIte.FieldByName('ITE_REFERE').AsString,                                                         //  strRefere
                                    qryCadIte.FieldByName('ITE_CODUNI').AsString,                                                         //  strUnidad
                                    qryCadIte.FieldByName('ITE_CODFOR').AsString,                                                         //  strForIte

                                    FieldByName('Quantidade').AsFloat,                                                    //  fltQtdIte
                                    FieldByName('Preco').AsFloat,                                                         //  fltUnitar
                                    FieldByName('PrecoTabela').AsFloat,                                                   //  fltUniOri
                                    FieldByName('Quantidade').AsFloat * FieldByName('Preco').AsFloat,     //  fltUniVis
                                    FieldByName('Quantidade').AsFloat * FieldByName('Preco').AsFloat,     //  fltTotIte
                                    FieldByName('Quantidade').AsFloat * FieldByName('Preco').AsFloat,     //  fltVlrCon
                                    FieldByName('Quantidade').AsFloat * qryCadIte.FieldByName('ITE_PRECUS').AsFloat,      //  fltTotCus
                                    FieldByName('Quantidade').AsFloat * qryCadIte.FieldByName('ITE_PREMED').AsFloat,      //  fltTotMed
                                    0.0,                                                                                                  //  fltDesCon
                                    0.0,                                                                                                  //  fltTotFre
                                    0.0,                                                                                                  //  fltDesEsp
                                    0.0,                                                                                                  //  fltDesAce
                                    FcdsPedido.FieldByName('CodUsuarioSync').AsString,                                                    //  strCodRep
                                    '',                                                                                                   //  strCodVe2
                                    qryCadIte.FieldByName('ITE_PRECOM').AsFloat,                                                          //  fltPerCom
                                    FieldByName('Quantidade').AsFloat * qryCadIte.FieldByName('ITE_PRECOM').AsFloat,                      //  fltTotCom
                                    FieldByName('Quantidade').AsFloat * qryCadIte.FieldByName('ITE_PRECOM').AsFloat,                      //  fltTotCo2
                                    '5405',                                                                                               //  strClaFis
                                    '',                                                                                                   //  strCodFis
                                    0.0,                                                                                                  //  fltValIpi
                                    0.0,                                                                                                  //  fltAlqIpi
                                    0.0,                                                                                                  //  fltBasIpi
                                    0.0,                                                                                                  //  fltValIcm
                                    0.0,                                                                                                  //  fltAlqIcm
                                    0.0,                                                                                                  //  fltBasIcm
                                    0.0,                                                                                                  //  fltValRet
                                    0.0,                                                                                                  //  fltAlqRet
                                    0.0,                                                                                                  //  fltBasRet
                                    fFormataFloat(FieldByName('Quantidade').AsFloat * qryCadIte.FieldByName('ITE_PESOIT').AsFloat, 3),    //  fltTotPes
                                    0.0,                                                                                                  //  fltPerBas
                                    0.0,                                                                                                  //  fltPerRed
                                    False,                                                                                                //  blnJaFatu
                                    '',                                                                                                   //  strTipFat
                                    '',                                                                                                   //  strNumFat
                                    '',                                                                                                   //  strEmpFat
                                    0,                                                                                                    //  dtaDtaFat
                                    '',                                                                                                   //  strVenFat
                                    '',                                                                                                   //  strCndFat
                                    0.0,                                                                                                  //  fltValFat
                                    'NOR',                                                                                                //  strIdePro
                                    'N',                                                                                                  //  strIncPis
                                    strLoginUsuarioLogado,                                                                                //  strCodDig
                                    fRetConPagCodCnd(FcdsPedido.FieldByName('CodCondicaoPagamentoSync').AsString),                        //  strConPag
                                    '',                                                                                                   //  strProEmb
                                    FcdsPedido.FieldByName('CodFormaPagamentoSync').AsString,                                              //  strCodFpg
                                    '',                                                                                                   //  strIteCha
                                    '',                                                                                                   //  strIteTin
                                    '',                                                                                                   //  strDesCor
                                    '',                                                                                                   //  strTipEmb
                                    0.0,                                                                                                  //  fltQtdEmb
                                    0.0,                                                                                                  //  fltPreEmb
                                    '',                                                                                                   //  strTipPre
                                    0.0,                                                                                                  //  fltPrvTin
                                    0.0,                                                                                                  //  fltPrcTin
                                    0.0,                                                                                                  //  fltFatTin
                                    '',                                                                                                   //  strIteEmb
                                    '',                                                                                                   //  strGruEmb
                                    0,                                                                                                    //  intLazQua
                                    'N',                                                                                                  //  strPromoc
                                    '',                                                                                                   //  strSeqTin
                                    0.0,                                                                                                  //  fltQtdPul
                                    RecNo,                                                                                //  intSeqInd
                                    0.0,                                                                                                  //  fltQtdBai
                                    FieldByName('Preco').AsFloat,                                                    //  fltUniDig
                                    '',                                                                                                   //  strComple
                                    0.0,                                                                                                  //  fltVolPro
                                    '',                                                                                                   //  strCodAca
                                    '',                                                                                                   //  strEmpAca
                                    False,                                                                                                //  blnProAca
                                    fGetTabPreco(FieldByName('CodTipoPrecoSync').AsString),                                               //  strTabPre
                                    '',                                                                                                   //  strLinha:
                                    '',                                                                                                   //  strCatali
                                    '',                                                                                                   //  strCodDil
                                    0.0,                                                                                                  //  fltPorDil
                                    '',                                                                                                   //  strDilCon
                                    0.0,
                                    'E',
                                    '',
                                    '',
                                    '',
                                    0,
                                    0,
                                    0,
                                    0,
                                    '',
                                    '',
                                    '',
                                    False,
                                    IIF(blnEmpFat, VS_strCodEmp, ''),
                                    '',
                                    '',
                                    '',
                                    '',
                                    '',
                                    0,
                                    0,
                                    '',
                                    '',
                                    0,
                                    '',
                                    '',
                                    0,
                                    0,
                                    0.00) ;

          End;

          Next;
          Application.ProcessMessages;

        End;

        // Não tem Next Porque já tem o Filter "ITEIMP = 0" então todo post já retira o Registro do Data Set.
        intQtdGra := 1;
        First;
        While (not Eof) And (intQtdGra <= intIteDoc) Do
        Begin
          Edit;
          FieldByName('ITEIMP').AsInteger := 1;
          Post;
          inc(intQtdGra);
        End;

        If Result Then
          mmoMsgs.Lines.Add(fPadR(FstrNumTablet,32) + fPadR(FstrNumDoc + '-PD-' + FcdsPedido.FieldByName('CodEmpresaSync').AsString, 21) +
            IIF(Result, 'OK - GERADO', 'FALHOU') );

        EnableControls;

        if RecordCount > 0 Then
          fGraFatGor;

      End;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(e.Message, '[TfrmTxtImpFullSoftTablet.fGravaDetGor]');
      End;
    End;
  Finally
    FcdsItens.Filtered := False;
    FcdsItens.Filter   := '';
  End;
end;

function TfrmTxtImpFullSoftTablet.fGraFatGor: Boolean;
  Var
    strAutInc    : String;
    recServicos  : TDadosServicos;
    fltPesoBruto : Double;
    stlDocume : TStringList;
    intCnt : Integer;
    strTabPreGor : String;
    arrDuplic    : TarrDuplicata;
begin
  stlDocume := TStringList.Create;
  Try
    Try

      With FcdsItens Do
      Begin
        try
          DisableControls;
          Filter   := 'CodPedidoSync = ' + FcdsPedido.FieldByName('CodPedidoSync').AsString + ' AND ITEIMP = 0 ';
          Filtered := True;
          fltPesoBruto := 0.00;
          While (not Eof) And (RecNo <= intIteDoc) Do
          Begin

            If fCarregaItem(FieldByName('CodProdutoSync').AsString, FcdsPedido.FieldByName('CodEmpresaSync').AsString) Then
              fltPesoBruto := fltPesoBruto + fFormataFloat(FieldByName('Quantidade').AsFloat * qryCadIte.FieldByName('ITE_PESOIT').AsFloat, 3);

            Next;
          End;
        Finally
          FcdsItens.Filtered := False;
          FcdsItens.Filter   := '';
          EnableControls;
        End;

      End;

      With FcdsPedido Do
      Begin
        FillChar(arrDuplic, Sizeof(arrDuplic) , #0);
        FstrNumTablet := fStrZero(Trim(FieldByName('CodPedidoSync').AsString),8) + '_' +
                         fStrZero(Trim(FieldByName('Numero').AsString),6) + '_' +
                         fStrZero(Trim(FieldByName('CodClienteSync').AsString),8);

        If fPedidoJaImportado(FstrNumTablet, stlDocume) Then
        Begin
          For intCnt := 0 To stlDocume.Count -1 Do
            mmoMsgs.Lines.Add(fPadR(FstrNumTablet,32) + fPadR(stlDocume.Strings[intCnt], 21) + 'JÁ FOI IMPORTADO!');

          Result := True; // Resulto "true" para não parar o laço principal, pois no mesmo arquivo pode conter um pedido já importado e um pedido não importado!
          Exit;
        End;

        FstrNumDoc := fRetSequencialPedido;

        strTabPreGor := '1';

        Result := fGravaFatGor( strAutInc,                                                               // strIncrem
                                FieldByName('CodEmpresaSync').AsString,                                  //  strCodEmp
                                FstrNumDoc,                                                              //  strNumDoc
                                'PD',                                                                    //  strEspDoc
                                FieldByName('CodClienteSync').AsString,                                  //  strCodCli
                                FieldByName('CodUsuarioSync').AsString,                                  //  strCodVen
                                '',                                                                      //  strCodTra
                                '',                                                                      //  strSerie:
                                FieldByName('DtInicioPedido').AsDateTime,                                //  dtaDtaEnt
                                FieldByName('DtInicioPedido').AsDateTime,                                //  dtaHorEnt
                                fRetConPagCodCnd(FieldByName('CodCondicaoPagamentoSync').AsString),      //  strConPag
                                '',                                                                      //  strEstado
                                '',                                                                      //  strNomCom
                                '',                                                                      //  strEndCon
                                '',                                                                      //  strBaiCon
                                '',                                                                      //  strCepCon
                                '',                                                                      //  strCidCon
                                '',                                                                      //  strEstCon
                                '',                                                                      //  strCodAti
                                '',                                                                      //  strTelCon
                                0,                                                                       //  dtaNasCon
                                '',                                                                      //  strCgcCpf
                                '',                                                                      //  strCgcCon
                                '',                                                                      //  strIesCon
                                '',                                                                      //  strCli_Rg
                                0.0,                                                                     //  fltBasSim
                                0.0,                                                                     //  fltBasIpi
                                0.0,                                                                     //  fltAlqIpi
                                FieldByName('VlrIPI').AsFloat,                                           //  fltTotIpi
                                0.0,                                                                     //  fltBasIcm
                                0.0,                                                                     //  fltAlqIcm
                                0.0,                                                                     //  fltTotIcm
                                FieldByName('VlrST').AsFloat,                                            //  fltTotRet
                                0.0,                                                                     //  fltAlqRet
                                0.0,                                                                     //  fltBasRet
                                0.0,                                                                     //  fltDesEsp
                                FieldByName('VlrTotal').AsFloat,                                         //  fltVlrCon
                                FieldByName('VlrProdutos').AsFloat,                                      //  fltTotPro
                                0, //cdsPedidos.FieldByName('TOTALBRUTO').AsFloat,                       //  fltTotCus
                                FieldByName('VlrTotal').AsFloat,                                         //  fltTotMed
                                '',                                                                      //  strTipFre
                                0.0,                                                                     //  fltTotFre

                                0.0,
                                0.0,
                                0.0,
                                0.0,
                                0.0,
                                0.0,
                                0.0,
                                0.0,
                                0.0,
                                0.0,
                                0.0,
                                0.0,

                                0.0,                                                                     //  fltDesAce
                                fltPesoBruto,                                                            //  fltPesBru
                                0,                                                                       //  fltPesLiq
                                0,                                                                       //  fltVolume
                                arrDuplic,                                                               //  arrDuplic
                                '',                                                                      //  strEspeci
                                '',                                                                      //  strMarca,
                                '',                                                                      //  strMen001
                                '',                                                                      //  strMen002
                                False,                                                                   //  blnJaFatu
                                '',                                                                      //  strTipFat
                                '',                                                                      //  strNumFat
                                '',                                                                      //  strEmpFat
                                0,                                                                       //  dtaDtaFat
                                '',                                                                      //  strVenFat
                                '',                                                                      //  strCndFat
                                0.0,                                                                     //  fltValFat
                                0.0,                                                                     //  fltPorDes
                                strLoginUsuarioLogado,                                                   //  strCodDig
                                FieldByName('CodCondicaoPagamentoSync').AsString,                        //  strCodCnd
                                FieldByName('CodFormaPagamentoSync').AsString,                           //  strCodFpg
                                recServicos,
                                '',                                                                      //  strConEnt
                                VS_Date,                                                                 //  dtaPreVis
                                0.0,                                                                     //  fltVPgAnt
                                VS_Date,                                                                 //  dtaUltAlt
                                '',                                                                      //  strNTrava
                                'A',                                                                     //cdsPedidos.FieldByName('CODTIPOPEDIDO').AsString,                 //  strTipPed
                                '',                                                                      //  strCliCtt
                                0,                                                                       //  intLibera
                                'S',                                                                     //  strEntFat
                                0.0,                                                                     //  fltDesCon
                                strTabPreGor,                                                            //  strTabPre
                                '',                                                                      //  strEntFut
                                0.0,                                                                     //  fltMargem
                                FstrNumTablet,                                                            //  strNumPok
                                '',                                                                      //  strEmp_CD
                                False,                                                                   //  blnEnt_CD
                                'N',                                                                     //  strOprFlj
                                Copy(FieldByName('Observacao').AsString,001, 70),                        //  strMenExp
                                Copy(FieldByName('Observacao').AsString,071, 70),                        //  strMenExp
                                Copy(FieldByName('Observacao').AsString,141, 70),                        //  strMenExp
                                Copy(FieldByName('Observacao').AsString,211, 70),                        //  strMenExp
                                '',
                                '',
                                False,                                                                   //  blnPedLib
                                0,
                                'N',
                                '',
                                0,
                                'P',                                                                     // strTipFin
                                0,                                                                       // fltDesFin
                                '',                                                                      // strAutEnt
                                '',
                                '',
                                False, //Liberacao Comercial
                                '',
                                Nil,
                                '',
                                '',
                                0, //cdsPedidos.FieldByName('HORAFINAL').AsDateTime,
                                0,
                                0,
                                '',
                                Nil,
                                '',
                                0,
                                0,
                                '',
                                '',
                                0,
                                '',
                                0,
                                '',
                                '',
                                '0',
                                'N');

        Application.ProcessMessages;
      End;

      Application.ProcessMessages;
      If Result Then
        Result := fGraDetGor(strAutInc, FstrNumDoc);

    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(e.Message, '[TfrmTxtImpFullSoftTablet.fGravaFatGor]');
      End;

    End;
  Finally
    FreeAndNil(stlDocume);
  End;
end;

function TfrmTxtImpFullSoftTablet.fPedidoJaImportado(
  strNumPok: String; var stlDocume: TStringList): Boolean;
  Var
    qryPedido: TUniQuery;
begin
  qryPedido := fCriaQuery(Self);
  Try
    Try
      With qryPedido Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(' SELECT CONCAT(FGO_NUMDOC, "-", FGO_ESPDOC, "-", FGO_CODEMP) AS DOCUME ');
        SQL.Add('   FROM FATGOR ');
        SQL.Add('  WHERE FGO_NUMPOK = :NUMPOK ');
        ParamByName('NUMPOK').AsString := strNumPok;
        Open;

        stlDocume.Clear;

        If Not IsEmpty Then
        Begin
          First;
          While Not Eof Do
          Begin
            stlDocume.Add(FieldByName('DOCUME').AsString);
            Next;
          End;
        End;

        Result := (stlDocume.Count > 0);
        Close;
      End;
    Except
      On E: Exception Do
      Begin
        Result := False;
        stlDocume.Clear;
        pMensagensErro(E.Message, '[TfrmTxtImpFullSoftTablet.fPedidoJaImportado]');
      End;
    End;
  Finally
    FreeAndNil(qryPedido);
  End
end;

function TfrmTxtImpFullSoftTablet.fProximoCampo(var strLinha: String): String;
  Var
    intPosPipe : Integer;
begin
  intPosPipe := Pos('|', strLinha);

  If intPosPipe <= 0 Then
    intPosPipe := Length(strLinha) + 1;

  Result     := Copy(strLinha, 1, intPosPipe-1);
  Result     := AnsiReplaceStr(Result, cLf, ' '); // Trocando o LF por Espaço.
  strLinha   := Copy(strLinha, intPosPipe+1, Length(strLinha));
end;

function TfrmTxtImpFullSoftTablet.fValidaCliente(
  var strMensag: String): Boolean;
  Var
    strAux : String;
begin
  With FcdsCliente do
  Begin
    strMensag := '';

    strAux := FieldByName('CodCidadeSync').AsString;
    Result := (not fEmptyStr(strAux)) and ( not fEmptyStr( fRetNomCidade( strAux )));
    if not Result Then
      strMensag := Format('Cidade não Encontrada (%s)' ,[strAux]) ;

    if Result then
    Begin
      strAux := FieldByName('CodRamoAtividadeSync').AsString;
      if not (fEmptyStr(strAux) Or ( not fEmptyStr( fRetNomAtividade( strAux )))) Then
      Begin
        Result := False;
        strMensag := Format('Código de Atividade não Encontrada (%s)' ,[strAux]) ;
      End;
    End;

    if Result then
    Begin
      strAux := FieldByName('CodRepresentanteSync').AsString;
      if not (fEmptyStr(strAux) Or ( not fEmptyStr( fRetNomeOperador( strAux )))) Then
      Begin
        Result := False;
        strMensag := Format('Código do Representante não Encontrado (%s)' ,[strAux]) ;
      End;
    End;

    if Result then
    Begin
      strAux := FieldByName('CodPortadorSync').AsString;
      if not (fEmptyStr(strAux) Or ( not fEmptyStr( fRetNomPortador( strAux )))) Then
      Begin
        Result := False;
        strMensag := Format('Código do Portador não Encontrada (%s)' ,[strAux]) ;
      End;
    End;



  End;

end;

function TfrmTxtImpFullSoftTablet.fValidaItem(var strMensag : String) : Boolean;
  Var
    strAux : String;
begin
  With FcdsItens Do
  Begin
    strMensag := '';

    strAux := FieldByName('CodProdutoSync').AsString;
    Result := fEmptyStr(strAux) Or (not fEmptyStr( fRetNomProduto( strAux )));
    if not Result Then
      strMensag := Format('Produto não Encontrada (%s)' ,[strAux]) ;

  End;

end;

function TfrmTxtImpFullSoftTablet.fValidaPedido(var strMensag : String): Boolean;
  Var
    strAux : String;
begin
  With FcdsPedido Do
  Begin
    strMensag := '';

    strAux := FieldByName('CodEmpresaSync').AsString;
    Result := fEmptyStr(strAux) Or (not fEmptyStr( fRetNomeEmpresaSelec( strAux )));
    if not Result Then
      strMensag := Format('Pedido: %s - Empresa informada no Arquivo não Encontrada (%s)' ,[FieldByName('Numero').AsString, strAux]) ;

    If Result Then
    Begin
      strAux := FieldByName('CodUsuarioSync').AsString;
      Result := fEmptyStr(strAux) Or (not fEmptyStr( fRetNomeOperador( strAux )));
      if not Result Then
        strMensag := Format('Pedido: %s - Usuário não Encontrado (%s)' ,[FieldByName('Numero').AsString, strAux]) ;

    End;


    If Result Then
    Begin
      strAux := FieldByName('CodTransportadoraSync').AsString;
      Result := fEmptyStr(strAux) Or (not fEmptyStr( fRetNomTransportadora( strAux )));
      if not Result Then
        strMensag := Format('Pedido: %s - Transportadora não Encontrada (%s)' ,[FieldByName('Numero').AsString, strAux]) ;

    End;

    If Result and (FieldByName('ClienteNovo').AsString = '0') Then
    Begin
      strAux := FieldByName('CodClienteSync').AsString;

      Result := fEmptyStr(strAux) Or (not fEmptyStr( fRetNomCliente( strAux )));
      if not Result Then
        strMensag := Format('Pedido: %s - Cliente não Encontrado (%s) ' ,[FieldByName('Numero').AsString, strAux]) ;

    End;

  End;

end;

procedure TfrmTxtImpFullSoftTablet.pAfterScrollManutencao(DataSet: TDataSet);
begin
  FcdsItenMan.Filter := '';
  if not fEmptyStr(DataSet.FieldByName('CodManutencaoSync').AsString) Then
    FcdsItenMan.Filter   := 'CodManutencaoSync = ' + DataSet.FieldByName('CodManutencaoSync').AsString;

  FcdsItenMan.Filtered := not fEmptyStr(FcdsItenMan.Filter);

end;

procedure TfrmTxtImpFullSoftTablet.pAfterScrollPedido(DataSet: TDataSet);
begin
  FcdsItens.Filter := '';
  if not fEmptyStr(DataSet.FieldByName('CodPedidoSync').AsString) Then
    FcdsItens.Filter   := 'CodPedidoSync = ' + DataSet.FieldByName('CodPedidoSync').AsString;

  FcdsItens.Filtered := not fEmptyStr(FcdsItens.Filter);

end;

procedure TfrmTxtImpFullSoftTablet.pCriaCdsClientes(
  var cdsDados: TUniClientDataSet);
  Procedure pAddCampo(strCampo : String; dtyTipo : TFieldType; intSize : Integer = 0);
  Begin
    With cdsDados.FieldDefs.AddFieldDef Do
    Begin
      Name := strCampo;
      DataType := dtyTipo;
      if intSize > 0 Then
        Size := intSize;
    End;
  End;

begin
  if Assigned(cdsDados) Then
    FreeAndNil(cdsDados);

  cdsDados := TUniClientDataSet.Create(Self);

  FdtsCliente           := TDataSource.Create(Self);
  FdtsCliente.DataSet   := cdsDados;
  dbgCliente.DataSource := FdtsCliente;

  pAddCampo('CodEmpresaSync', ftString, 20);
  pAddCampo('RazaoSocial', ftString, 100);
  pAddCampo('NomeFantasia', ftString, 100);
  pAddCampo('TipoPessoa', ftInteger);
  pAddCampo('Cnpj', ftString, 20);
  pAddCampo('Cpf', ftString, 11);
  pAddCampo('Email', ftString, 100);
  pAddCampo('CodRepresentanteSync', ftString, 20);
  pAddCampo('Observacao', ftString, 255);
  pAddCampo('Situacao', ftInteger);
  pAddCampo('NomeContato', ftString, 100);
  pAddCampo('TelefoneContato', ftString, 20);
  pAddCampo('CelularConato', ftString, 20);
  pAddCampo('EmailContato', ftString, 100);
  pAddCampo('DtInclusao', ftDate);
  pAddCampo('CodCliente', ftString, 20);
  pAddCampo('CodSegmentoMercadoSync', ftString, 20);
  pAddCampo('InscricaoEstadual', ftString, 14);
  pAddCampo('LimiteCredito', ftFloat);
  pAddCampo('CodPortadorSync', ftString, 20);
  pAddCampo('CodRamoAtividadeSync', ftString, 20);
  pAddCampo('Endereco', ftString, 255);
  pAddCampo('NumeroEndereco', ftString, 30);
  pAddCampo('ComplementoEndereco', ftString, 70);
  pAddCampo('BairroEndereco', ftString, 100);
  pAddCampo('CEP', ftString, 8);
  pAddCampo('CodCidadeSync', ftString, 20);
  pAddCampo('TelefoneEndereco', ftString, 20);
  pAddCampo('Latitude', ftString, 20);
  pAddCampo('Longitude', ftString, 20);
  pAddCampo('CodCliNovo', ftString, 8);

  cdsDados.CreateDataSet;

  pFormataNumericos(cdsDados);

end;

procedure TfrmTxtImpFullSoftTablet.pCriaCdsItenMan(
  var cdsDados: TUniClientDataSet);
  Procedure pAddCampo(strCampo : String; dtyTipo : TFieldType; intSize : Integer = 0);
  Begin
    With cdsDados.FieldDefs.AddFieldDef Do
    Begin
      Name := strCampo;
      DataType := dtyTipo;
      if intSize > 0 Then
        Size := intSize;
    End;
  End;

begin
  if Assigned(cdsDados) Then
    FreeAndNil(cdsDados);

  cdsDados := TUniClientDataSet.Create(Self);

  FdtsItenMan           := TDataSource.Create(Self);
  FdtsItenMan.DataSet   := cdsDados;
  dbgItenMan.DataSource := FdtsItenMan;

  pAddCampo('CodManutencaoItemSync', ftInteger);
  pAddCampo('CodManutencaoSync', ftInteger);
  pAddCampo('Campo', ftString, 100);
  pAddCampo('ValorOriginal', ftString, 255);
  pAddCampo('ValorAlterado', ftString, 255);
  pAddCampo('Operacao', ftString, 1);

  {*****************************************}
  {* CAMPO MARCA NÃO EXISTE NO LAYOUT E    *}
  {* DEVE FICAR SEMPRE POR ÚLTIMO, O MESMO *}
  {* SEMPRE RECEBE COMO DEFAULT TRUE,      *}
  {* O CAMPO SERÁ UTILIZADO PARA IMPEDIR   *}
  {* ALGUMA ALTERAÇÃO INDESEJADA, SOMENTE  *}
  {* SERA IMPORTADO OS ITENS ONDE MARCA = T*}
  {**************************************GB*}
  pAddCampo('MARCA', ftBoolean);


  cdsDados.CreateDataSet;
  pFormataNumericos(cdsDados);

end;

procedure TfrmTxtImpFullSoftTablet.pCriaCdsItensPedido(var cdsDados: TUniClientDataSet);
  Procedure pAddCampo(strCampo : String; dtyTipo : TFieldType; intSize : Integer = 0);
  Begin
    With cdsDados.FieldDefs.AddFieldDef Do
    Begin
      Name := strCampo;
      DataType := dtyTipo;
      if intSize > 0 Then
        Size := intSize;
    End;
  End;

begin
  if Assigned(cdsDados) Then
    FreeAndNil(cdsDados);

  cdsDados := TUniClientDataSet.Create(Self);

  FdtsItens           := TDataSource.Create(Self);
  FdtsItens.DataSet   := cdsDados;
  dbgItens.DataSource := FdtsItens;

  pAddCampo('CodPedidoProdutoSync', ftInteger);
  pAddCampo('CodPedidoSync', ftInteger);
  pAddCampo('CodProdutoSync', ftString, 20);
  pAddCampo('CodDerivacaoSync', ftString, 20);
  pAddCampo('CodMultiplaMedidaSync', ftString, 20);
  pAddCampo('CodPoliticaSync', ftString, 20);
  pAddCampo('CodTipoPrecoSync', ftString, 20);
  pAddCampo('Quantidade', ftFloat);
  pAddCampo('Preco', ftFloat);
  pAddCampo('PrecoTabela', ftFloat);
  pAddCampo('VlrDesconto', ftFloat);
  pAddCampo('VlrAcrescimo', ftFloat);
  pAddCampo('PercDesconto', ftFloat);
  pAddCampo('PercAcrescimo', ftFloat);
  pAddCampo('DtEntrega', ftDate);
  pAddCampo('NomeProduto', ftString, 100);
  pAddCampo('VlrICMS', ftFloat);
  pAddCampo('VlrST', ftFloat);
  pAddCampo('VlrIPI', ftFloat);
  pAddCampo('Observacao', ftString, 255);
  pAddCampo('PercDescontoPeso',  ftFloat);

  {*****************************************}
  {* CAMPO ABAIXO NÃO EXISTE NO LAYOUT E   *}
  {* DEVE FICAR SEMPRE POR ÚLTIMO          *}
  {**************************************GB*}
  pAddCampo('ITEIMP', ftInteger);

  cdsDados.CreateDataSet;

  pFormataNumericos(cdsDados);

end;

procedure TfrmTxtImpFullSoftTablet.pCriaCdsManuten(
  var cdsDados: TUniClientDataSet);
  Procedure pAddCampo(strCampo : String; dtyTipo : TFieldType; intSize : Integer = 0);
  Begin
    With cdsDados.FieldDefs.AddFieldDef Do
    Begin
      Name := strCampo;
      DataType := dtyTipo;
      if intSize > 0 Then
        Size := intSize;
    End;
  End;

begin
  if Assigned(cdsDados) Then
    FreeAndNil(cdsDados);

  cdsDados := TUniClientDataSet.Create(Self);

  FdtsManuten           := TDataSource.Create(Self);
  FdtsManuten.DataSet   := cdsDados;

  dbgManuten.DataSource := FdtsManuten;
  cdsDados.AfterScroll  := pAfterScrollManutencao;

  pAddCampo('CodManutencaoSync', ftInteger);
  pAddCampo('Tabela', ftString, 100);
  pAddCampo('ChavePrimaria', ftString, 20);
  pAddCampo('DtInclusao', ftDateTime);
  pAddCampo('Situacao', ftInteger);
  pAddCampo('DependenciaOrigem', ftString, 50);

  cdsDados.CreateDataSet;

  pFormataNumericos(cdsDados);

end;

procedure TfrmTxtImpFullSoftTablet.pCriaCdsPedido(var cdsDados: TUniClientDataSet);
  Procedure pAddCampo(strCampo : String; dtyTipo : TFieldType; intSize : Integer = 0);
  Begin
    With cdsDados.FieldDefs.AddFieldDef Do
    Begin
      Name := strCampo;
      DataType := dtyTipo;
      if intSize > 0 Then
        Size := intSize;
    End;
  End;

begin
  if Assigned(cdsDados) Then
    FreeAndNil(cdsDados);

  cdsDados := TUniClientDataSet.Create(Self);

  FdtsPedido           := TDataSource.Create(Self);
  FdtsPedido.DataSet   := cdsDados;
  dbgPedido.DataSource := FdtsPedido;

  cdsDados.AfterScroll := pAfterScrollPedido;

  pAddCampo('CodPedidoSync', ftInteger);
  pAddCampo('CodEmpresaSync', ftString, 20);
  pAddCampo('Numero', ftString, 20);
  pAddCampo('CodClienteSync', ftString, 20);
  pAddCampo('CodCondicaoPagamentoSync', ftString, 20);
  pAddCampo('CodFormaPagamentoSync', ftString, 20);
  pAddCampo('CodListaPrecoSync', ftString, 20);
  pAddCampo('CodTipoOperacaoSync', ftString, 20);
  pAddCampo('CodMotivoVendaSync', ftString, 20);
  pAddCampo('CodUsuarioSync', ftString, 20);
  pAddCampo('CodRepresentanteSync', ftString, 20);
  pAddCampo('CodPrepostoSync', ftString, 20);
  pAddCampo('CodTransportadoraSync', ftString, 20);
  pAddCampo('DtEntrega', ftDate);
  pAddCampo('OrdemCompra', ftString, 20);
  pAddCampo('DtInicioPedido', ftDateTime);
  pAddCampo('DtTerminoPedido', ftDateTime);
  pAddCampo('ClienteNovo', ftInteger);
  pAddCampo('CodPedidoPDA', ftString, 10);
  pAddCampo('DtInclusao', ftDate);
  pAddCampo('TipoFrete', ftInteger);
  pAddCampo('VlrAcrescimo', ftFloat);
  pAddCampo('VlrDesconto', ftFloat);
  pAddCampo('PercAcrescimo', ftFloat);
  pAddCampo('PercDesconto', ftFloat);
  pAddCampo('VlrST', ftFloat);
  pAddCampo('VlrFrete', ftFloat);
  pAddCampo('VlrIPI', ftFloat);
  pAddCampo('VlrTotal', ftFloat);
  pAddCampo('Observacao', ftString, 255);
  pAddCampo('ObservacaoNota', ftString, 255);
  pAddCampo('Origem', ftInteger);
  pAddCampo('Situacao', ftInteger);
  pAddCampo('VlrProdutos', ftFloat);
  pAddCampo('Urgente', ftInteger);
  pAddCampo('CodRedespachoSync', ftString, 20);
  pAddCampo('DtFaturamento', ftDate);
  pAddCampo('CodComunicacaoSync', ftInteger);
  pAddCampo('EnviaEmail', ftBoolean);
  pAddCampo('Latitude', ftString, 20);
  pAddCampo('Longitude', ftString, 20);

  cdsDados.CreateDataSet;

  pFormataNumericos(cdsDados);
end;


procedure TfrmTxtImpFullSoftTablet.pFormataNumericos(DataSet: TDataSet);
  Var
    intCorre : Integer;
begin
  For intCorre := 0 To DataSet.FieldCount -1 Do
  Begin
    If DataSet.Fields[intCorre].DataType = ftFloat Then
      TFloatField(DataSet.Fields[intCorre]).DisplayFormat := '#,##0.00';

  End;

end;

procedure TfrmTxtImpFullSoftTablet.pImportaRegistro(var strLinha: String; cdsDados: TUniClientDataSet; fntValida : TValidaFunction);
  Var
    strMensag: String;
begin
  pImportaRegistro(strLinha, cdsDados);

  If Not fntValida(strMensag) Then
  Begin
    cdsDados.Delete;
    If not fEmptyStr(strMensag) Then
      mmoMsgs.Lines.Add(strMensag);
  End;

end;

procedure TfrmTxtImpFullSoftTablet.pImportaRegistro(var strLinha: String; cdsDados: TUniClientDataSet);
  Var
    intCorre : Integer;
    strValCam: String;
begin
  cdsDados.Append;
  For intCorre := 0 to cdsDados.FieldCount -1 Do
  Begin
    strValCam := fProximoCampo(strLinha);
    cdsDados.Fields[intCorre].AsVariant := IIF(fEmptyStr(strValCam), null, strValCam);
  End;

  cdsDados.Post;

end;

procedure TfrmTxtImpFullSoftTablet.pImportarRegistros(strArqName: String);
  Var
    stlArquivo : TTextStream;
    strLinha   : String;
    strRegistro: String;
begin
  try
    mmoMsgs.Lines.Clear;
    dirFileImp.Enabled   := False;
    Screen.Cursor        := crHourGlass;
    btnGravar.Enabled    := False;
    try
      if FileExists(strArqName) then
        stlArquivo:= TTextStream.Create(strArqName, False)
      Else
      Begin
        pMensagemOk('O Arquivo indicado não existe!');
        Exit;
      End;

      pgbImporta.Max      := stlArquivo.Stream.Size;
      pgbImporta.Position := stlArquivo.Stream.Position;
      pgbImporta.Visible  := True;

      pCriaCdsPedido(FcdsPedido);
      pCriaCdsItensPedido(FcdsItens);
      pCriaCdsClientes(FcdsCliente);
      pCriaCdsManuten(FCdsManuten);
      pCriaCdsItenMan(FCdsItenMan);

      FcdsPedido.DisableControls;
      FcdsItens.DisableControls;
      FcdsCliente.DisableControls;
      FCdsManuten.DisableControls;
      FCdsItenMan.DisableControls;

      While not stlArquivo.Eof Do
      Begin
        strLinha := String(stlArquivo.ReadLine);

        strRegistro := fProximoCampo(strLinha);

        Case StrToIntDef(strRegistro, 0) Of
          9020 : pImportaRegistro(strLinha, FcdsCliente, fValidaCliente);
          9100 : pImportaRegistro(strLinha, FcdsPedido , fValidaPedido);
          9110 : Begin
                   pImportaRegistro(strLinha, FcdsItens  , fValidaItem);
                   FcdsItens.Edit;
                   FcdsItens.FieldByName('ITEIMP').AsInteger := 0;
                   FcdsItens.Post;
                 End;
          9300 : pImportaRegistro(strLinha, FCdsManuten);
          9310 : Begin
                   pImportaRegistro(strLinha, FCdsItenMan);
                   FCdsItenMan.Edit;
                   FCdsItenMan.FieldByName('MARCA').AsBoolean := (FCdsItenMan.FieldByName('Operacao').AsString = 'M');
                   FCdsItenMan.Post;
                 End;
        End;

        pgbImporta.Position := stlArquivo.Stream.Position;

      End;

      btnGravar.Enabled := (mmoMsgs.Lines.Count = 0);

      FcdsPedido.First;
      FcdsItens.First;
      FcdsCliente.First;
      FCdsManuten.First;
      FCdsItenMan.First;

      pAfterScrollPedido(FcdsPedido);
      pAfterScrollManutencao(FCdsManuten);

      FcdsPedido.EnableControls;
      FcdsItens.EnableControls;
      FcdsCliente.EnableControls;
      FCdsManuten.EnableControls;
      FCdsItenMan.EnableControls;

      tabPedido.TabVisible := (FcdsPedido.RecordCount > 0);
      tabCliente.TabVisible := (FcdsCliente.RecordCount > 0);
      tabManutencao.TabVisible := (FcdsManuten.RecordCount > 0);

    Except
      On E : Exception Do
        pMensagensErro(e.Message, '[TfrmTxtImpFullSoftTablet.pImportarRegistros]');

    End;

  Finally
    dirFileImp.Enabled := True;
    Screen.Cursor := crDefault;
    pgbImporta.Position := 0;
    pgbImporta.Visible  := False;
    FreeAndNil(stlArquivo);
  End;

end;

procedure TfrmTxtImpFullSoftTablet.pMarcaDesmarca;
begin
  if not FcdsItenMan.IsEmpty then
  Begin
    if FCdsItenMan.FieldByName('Operacao').AsString <> 'M' Then
      Exit;
      
    FcdsItenMan.Edit;
    FcdsItenMan.FieldByName('MARCA').AsBoolean := Not FcdsItenMan.FieldByName('MARCA').AsBoolean;
    FcdsItenMan.Post;
  end;

end;

function TfrmTxtImpFullSoftTablet.fCarregaItem(strCodIte, strCodEmp: String): Boolean;
begin

  Try
    Result := True;

    qryCadIte.Close;
    qryCadIte.ParamByName('CODEMP').AsString := strCodEmp;
    qryCadIte.ParamByName('CODITE').AsString := strCodIte;
    qryCadIte.Open;

    If qryCadIte.IsEmpty Then
      Result := False;

  Except
    Result := False;
  End;

end;

function TfrmTxtImpFullSoftTablet.fEfetuarManutencoes: Boolean;
  const DIC_FULL_CLIENTE : array[0..15] Of TRecTraduz =
  ((strCampoFullSoft: 'CodClienteSync'     ; strCampoAutcom : 'CLI_CODCLI'),
   (strCampoFullSoft: 'Codigo'             ; strCampoAutcom : 'CLI_CODCLI'),
   (strCampoFullSoft: 'RazaoSocial'        ; strCampoAutcom : 'CLI_NOMCLI'),
   (strCampoFullSoft: 'NomeFantasia'       ; strCampoAutcom : 'CLI_FANSOB'),
   (strCampoFullSoft: 'CNPJ'               ; strCampoAutcom : 'CLI_C_G_C_'),
   (strCampoFullSoft: 'CPF'                ; strCampoAutcom : 'CLI_C_G_C_'),
   (strCampoFullSoft: 'InscricaoEstadual'  ; strCampoAutcom : 'CLI_I_E_S_'),
   (strCampoFullSoft: 'Email'              ; strCampoAutcom : 'CLI_EMAIL_'),
   (strCampoFullSoft: 'Observacao'         ; strCampoAutcom : 'CLI_OBSERV'),
   (strCampoFullSoft: 'SituacaoFinanceira' ; strCampoAutcom : 'CLI_STATUS'),
   (strCampoFullSoft: 'LimiteCredito'      ; strCampoAutcom : 'CLI_LIMCRE'),
   (strCampoFullSoft: 'Ativo'              ; strCampoAutcom : 'CLI_STATUS'),
   (strCampoFullSoft: 'DtUltimaCompra'     ; strCampoAutcom : 'CLI_ULTCOM'),
   (strCampoFullSoft: 'DtCadastro'         ; strCampoAutcom : 'CLI_DTACAD'),
   (strCampoFullSoft: 'TipoPessoa'         ; strCampoAutcom : 'CLI_CGCCPF'),
   (strCampoFullSoft: 'Suframa'            ; strCampoAutcom : 'CLI_SUFRAM'));

  const DIC_FULL_CLIENTEENDERECO : array[0..11] Of TRecTraduz =
  ((strCampoFullSoft: 'CodEnderecoSync'     ; strCampoAutcom : 'CLI_CODCLI'),
   (strCampoFullSoft: 'CodTipoEnderecoSync' ; strCampoAutcom : ''),
   (strCampoFullSoft: 'CodClienteSync'      ; strCampoAutcom : 'CLI_CODCLI'),
   (strCampoFullSoft: 'Endereco'            ; strCampoAutcom : 'CLI_ENDERE'),
   (strCampoFullSoft: 'Numero'              ; strCampoAutcom : 'CLI_ENDNUM'),
   (strCampoFullSoft: 'Complemento'         ; strCampoAutcom : 'CLI_ENDCOM'),
   (strCampoFullSoft: 'Bairro'              ; strCampoAutcom : 'CLI_BAIRRO'),
   (strCampoFullSoft: 'CEP'                 ; strCampoAutcom : 'CLI_C_E_P_'),
   (strCampoFullSoft: 'Latitude'            ; strCampoAutcom : ''),
   (strCampoFullSoft: 'Longitude'           ; strCampoAutcom : ''),
   (strCampoFullSoft: 'Telefone'            ; strCampoAutcom : 'CLI_FONE01'),
   (strCampoFullSoft: 'CodCidadeSync'       ; strCampoAutcom : 'CLI_CODCID'));

  const DIC_FULL_CLIENTECONTATO : array[0..11] Of TRecTraduz =
  ((strCampoFullSoft: 'CodContatoSync'     ; strCampoAutcom : 'AUTOINCREM'),
   (strCampoFullSoft: 'CodClienteSync'     ; strCampoAutcom : 'CLI_CODCLI'),
   (strCampoFullSoft: 'CodTipoContatoSync' ; strCampoAutcom : ''),
   (strCampoFullSoft: 'Codigo'             ; strCampoAutcom : 'AUTOINCREM'),
   (strCampoFullSoft: 'Nome'               ; strCampoAutcom : 'CLI_NOMCTT'),
   (strCampoFullSoft: 'CPF'                ; strCampoAutcom : ''),
   (strCampoFullSoft: 'DtNascimento'       ; strCampoAutcom : 'CLI_NASCTT'),
   (strCampoFullSoft: 'Telefone'           ; strCampoAutcom : 'CLI_TELCTT'),
   (strCampoFullSoft: 'Ramal'              ; strCampoAutcom : ''),
   (strCampoFullSoft: 'Area'               ; strCampoAutcom : ''),
   (strCampoFullSoft: 'Email'              ; strCampoAutcom : 'CLI_EMACTT'),
   (strCampoFullSoft: 'Celular'            ; strCampoAutcom : 'CLI_CELCTT'));

  function fTraduzTabela(strTabFullSoft : String) : String;
    Const LST_CADCLI : String = 'FULL_CLIENTE|FULL_CLIENTETELEFONE|FULL_CLIENTEENDERECO';
    Const LST_CLICTT : String = 'FULL_CLIENTECONTATO';
  Begin
    if Pos(strTabFullSoft, LST_CADCLI) > 0 then
      Result := 'CADCLI'
    Else
    if Pos(strTabFullSoft, LST_CLICTT) > 0 then
      Result := 'CLICTT'
    Else // FULL_CLIENTEEMPRESA_ => Tabela que não atualiza
      Result := '';
  end;

  function fTraduzCampo( arrDic : TArrRecTraduz; strCampoFullSoft : String) : String;
    Var
      intCorre : Integer;
  Begin
    Result := '';
    For intCorre := 0 to Length(arrDic) -1 do
    begin
      if SameText(arrDic[intCorre].strCampoFullSoft, strCampoFullSoft) then
      begin
        Result := arrDic[intCorre].strCampoAutcom;
        Break;
      end;
    end;
  End;

  function fRetArray(strTabFullSoft : String) : TArrRecTraduz;
  Var
    intCorre : Integer;
    intTipoFone : Integer;
    strFone,
    strRamal : String;

  Begin

     if SameText(strTabFullSoft, 'FULL_CLIENTECONTATO' ) then
     Begin
       SetLength(Result,Length(DIC_FULL_CLIENTECONTATO));
       For intCorre := 0 to Length(DIC_FULL_CLIENTECONTATO)-1 do
       Begin
         Result[intCorre].strCampoFullSoft := DIC_FULL_CLIENTECONTATO[intCorre].strCampoFullSoft;
         Result[intCorre].strCampoAutcom   := DIC_FULL_CLIENTECONTATO[intCorre].strCampoAutcom;
       End;
     End;

     if SameText(strTabFullSoft, 'FULL_CLIENTEENDERECO' ) then
     Begin
       SetLength(Result,Length(DIC_FULL_CLIENTEENDERECO));
       For intCorre := 0 to Length(DIC_FULL_CLIENTEENDERECO)-1 do
       Begin
         Result[intCorre].strCampoFullSoft := DIC_FULL_CLIENTEENDERECO[intCorre].strCampoFullSoft;
         Result[intCorre].strCampoAutcom   := DIC_FULL_CLIENTEENDERECO[intCorre].strCampoAutcom;
       End;
     End;

     if SameText(strTabFullSoft, 'FULL_CLIENTE' ) then
     Begin
       SetLength(Result,Length(DIC_FULL_CLIENTE));
       For intCorre := 0 to Length(DIC_FULL_CLIENTE)-1 do
       Begin
         Result[intCorre].strCampoFullSoft := DIC_FULL_CLIENTE[intCorre].strCampoFullSoft;
         Result[intCorre].strCampoAutcom   := DIC_FULL_CLIENTE[intCorre].strCampoAutcom;
       End;
     End;

     if SameText(strTabFullSoft, 'FULL_CLIENTETELEFONE' ) then
     Begin
       intTipoFone := StrToIntDef(RightStr(FcdsItenMan.FieldByName('chavePrimaria').AsString,2),0);

       if intTipoFone > 0 then
       Begin
         case intTipoFone of
          1 : Begin
                strFone := 'CLI_FONE01';
                strRamal:= 'CLI_RAMAL1';
              End;
          2 : Begin
                strFone := 'CLI_FONE02';
                strRamal:= 'CLI_RAMAL2';

              End;
          3 : Begin
                strFone := 'CLI_F_A_X_';
                strRamal:= 'CLI_RAMAL3';
              End;
         end;

         SetLength(Result, 2);
         Result[0].strCampoFullSoft := 'Numero';
         Result[0].strCampoAutcom   := strFone;

         Result[1].strCampoFullSoft := 'Ramal';
         Result[1].strCampoAutcom   := strRamal;

       end;

     End;

  End;

  function fRetCondicaoSQL(strTabFullSoft : String) : String;
  Begin
     if Pos(strTabFullSoft, 'FULL_CLIENTE_FULL_CLIENTEENDERECO_' ) > 0 then
       Result := ' WHERE CLI_CODCLI = ' + QuotedStr(FcdsManuten.FieldByName('ChavePrimaria').AsString)
     Else
     if SameText(strTabFullSoft, 'FULL_CLIENTECONTATO' ) then
       Result := ' WHERE AUTOINCREM = ' + QuotedStr(FcdsManuten.FieldByName('ChavePrimaria').AsString)
     else
     if SameText(strTabFullSoft, 'FULL_CLIENTETELEFONE' ) then
       Result := ' WHERE CLI_CODCLI = ' + QuotedStr( LeftStr(FcdsManuten.FieldByName('ChavePrimaria').AsString,8));

  End;

   Var
     qryUpdate : TUniQuery;
     strSql    : String;
     strTabela : String;
     strCampo  : String;
     strWhere  : String;
begin
  Try
    Result := True;
    With FcdsManuten Do
    Begin
      DisableControls;
      pgbImporta.Position := 0;
      pgbImporta.Max      := RecordCount;
      pgbImporta.Visible  := True;

      qryUpdate := fCriaQuery(Self);

      First;
      While not Eof Do
      Begin

        pAfterScrollManutencao(FcdsManuten);

        while not FcdsItenMan.Eof do
        Begin
          if not FcdsItenMan.FieldByName('MARCA').AsBoolean then
          Begin
            FcdsItenMan.Next;
            Continue;
          End;

          strTabela := fTraduzTabela( FieldByName('Tabela').AsString );
          strCampo  := fTraduzCampo(fRetArray(FieldByName('Tabela').AsString), FcdsItenMan.FieldByName('Campo').AsString);
          strWhere  := fRetCondicaoSQL(FieldByName('Tabela').AsString);
          if fEmptyStr(strTabela) or fEmptyStr(strCampo) or fEmptyStr(strWhere) then
          Begin
            FcdsItenMan.Next;
            Continue;
          End;

          strSql := '';
          strSql := strSql + ' UPDATE ';
          strSql := strSql + strTabela;
          strSql := strSql + ' SET ';
          strSql := strSql + strCampo;
          strSql := strSql + ' = :NOVOVALOR ';
          strSql := strSql + strWhere;

          Try
            qryUpdate.SQL.Clear;
            qryUpdate.SQL.Add(strSql);
            qryUpdate.ParamByName('NOVOVALOR').AsString := FcdsItenMan.FieldByName('ValorAlterado').AsString;
            qryUpdate.ExecSQL;
          Except
            On E : Exception Do
            Begin
              pMensagensErro(E.Message,'[TfrmTxtImpFullSoftTablet.fEfetuarManutencoes]');
              Result := False;
              Exit;
            End;

          End;

          FcdsItenMan.Next;
        End;

        Next;
        pgbImporta.Position := RecNo;
        Application.ProcessMessages;
      End;

    End;
  Finally
    FcdsManuten.EnableControls;
    if Assigned(qryUpdate) then
      FreeAndNil(qryUpdate);    
  End;

end;

function TfrmTxtImpFullSoftTablet.fTabelaValida(strTabPre: String): Boolean;
begin
  If (Length(strTabPre) <> 1) Then
    Result := False
  Else
    Result := CharInSet(strTabPre[1], ['1'..'7']);
end;

function TfrmTxtImpFullSoftTablet.fGetTabPreco(strTabPre: String): String;
begin
  If (Length(strTabPre) = 4) And (LeftStr(strTabPre, 3) = 'TAB') Then
    Result := RightStr(strTabPre, 1)
  Else
    Result := strTabPre;

  If Not fTabelaValida(Result) Then
    Result := '1';
end;

end.