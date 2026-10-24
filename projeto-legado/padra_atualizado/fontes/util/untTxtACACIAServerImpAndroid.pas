unit untTxtACACIAServerImpAndroid;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, frxClass, frxDBSet, StdCtrls, Mask, DirectoryEditFocus,
  AppEvnts, Menus, Buttons, ExtCtrls, UniClientDataSet, Uni, DB, ComCtrls,
  untAtualizaOcorrenciasCRM, BitBtnLockedIncrem, frxExportCSVTestabilidade,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit, 
  untFrameDirectoryEditFocus;

type
  TfrmTxtACACIAServerImpAndroid = class(TfrmPai)
    Panel1: TPanel;
    Label17: TLabel;
    frxPagina: TfrxReport;
    frxRelatorio: TfrxDBDataset;
    PopupMenu1: TPopupMenu;
    MenuItem1: TMenuItem;
    tmrFecha: TTimer;
    pgbProdutos: TProgressBar;
    lbl2: TLabel;
    pgbPedidos: TProgressBar;
    lbl1: TLabel;
    frxIncSalDB: TfrxDBDataset;
    frxIncSalPag: TfrxReport;
    btnConfirma: TBitBtnLocked;
    dirPathImp: TfraDirectoryEditFocus;
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure tmrFechaTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    blnEmpFat         : Boolean;
    cdsArquivos       : TUniClientDataSet;
    cdsInconsistencia : TUniClientDataSet;
    cdsIncSaldo       : TUniClientDataSet;
    cdsTelefone       : TUniClientDataSet;
    cdsPedido         : TUniClientDataSet;
    cdsPedidoItem     : TUniClientDataSet;

    qryGenerica: TUniQuery;
    qryUpdate  : TUniQuery;

    blnSepararItensCom_e_SemSaldo: Boolean;

    objOcoCrm: TAtuOcoCrm;

    procedure pImp_Telefone(strNomArq: String);
    procedure pImp_Pedido(strNomArq: String);
    procedure pImp_ItensPedido(strNomArq: String);

    procedure pGrava_Telefone;
    procedure pGrava_Pedido(blnSepSal: Boolean; strComSal: String);

    procedure pGravaInconsistencia(strNomArq, strDescri, strCodigo, strPedido: String);
    procedure pGravaInconsistenciasSaldos(dtaDtaPed: TDate;
                                          strNumPed,
                                          strEspDoc,
                                          strCodEmp,
                                          strCodCli,
                                          strNomCli,
                                          strCodIte,
                                          strDesIte,
                                          strSigUni: String;
                                          fltQtdIte,
                                          fltUnitar,
                                          fltTotIte: Double);

    function fValidaPedido(strNumPok: String): Boolean;
    function fValidaCliente(strCodCli: String): Boolean;
    function fValidaItem(strCodIte: String): Boolean;
    function fValidaAtividade(strCodAti: String): Boolean;
    function fValidaVendedor(strCodVen: String): Boolean;
    function fValidaCondPagto(strCodCnd: String): Boolean;
    function fValidaFormaPagto(strCodFpg: String): Boolean;

    function fVerificaSaldo(strCodIte: String; fltQtdImp: Double): Boolean;
    function fRetornaSaldoDisponivel(strCodIte: String): Double;
    procedure pSepararProdutosCom_e_SemSaldo;
  public
    { Public declarations }
    strPath: String;
    srcArquivos: TSearchRec;
    blnGeracaoAut: Boolean;
    blnGerou: Boolean;    
  end;

implementation

uses untFuncoesSimples, untFuncoesCRM, StrUtils, untFuncoes, untFatGor,
  untTypesSistema, untTypesCRM, untTFatReservaSaldo;

{$R *.dfm}

procedure TfrmTxtACACIAServerImpAndroid.btnConfirmaClick(Sender: TObject);
  Var
    intTotRegP : Integer;
    intTotRegPI: Integer;
begin
  inherited;

  If fEmptyStr(fCfgSis('PEDACA')) Then
  Begin
    If (Not blnGeracaoAut) Then
    Begin
      fMensagem('','Configure o Path para Pedidos já importados!',['&OK']);
      Exit;
    End;
  End;

  If fEmptyStr(dirPathImp.edtDirectory.text) And (Not blnGeracaoAut) Then
    fMensagem('','Informar o Path para importação dos arquivos TXTs!',['&OK'])
  Else
  Begin
    btnConfirma.Enabled := False;
    btnSair.Enabled := False;
    dirPathImp.Enabled := False;
    pnlInfo.Caption := 'Aguarde, importando arquivos...';

    intTotRegP  := 0;
    intTotRegPI := 0;
    strPath := dirPathImp.edtDirectory.text;

    cdsArquivos.Open;
    cdsTelefone.Open;
    cdsPedido.Open;
    cdsPedidoItem.Open;
    cdsInconsistencia.Open;
    cdsIncSaldo.Open;

    cdsTelefone.EmptyDataSet;
    cdsPedido.EmptyDataSet;
    cdsPedidoItem.EmptyDataSet;
    cdsInconsistencia.EmptyDataSet;
    cdsIncSaldo.EmptyDataSet;

    {******************************************************}
    {* VERIFICA SE EXISTEM ARQUIVOS PARA SEREM IMPORTADOS *}
    {***************************************************LU*}
    If (FindFirst(strPath + '\*.*', faAnyFile, srcArquivos) = 0) Then
    Begin

      {*****************************************************************}
      {* VERIFICA SE EXISTEM ARQUIVOS PARA SEREM IMPORTADOS            *}
      {* CASO EXISTAM IMPORTA OS DADOS DO TXT PARA OS CLIENTDATASETS   *}
      {* PARA SEREM FEITAS AS VALIDAÇÕES E GRAVADOS NO BANCO DE DADOS  *}
      {**************************************************************LU*}

      {*****************************************************************}
      {* VERIFICA SE EXISTEM ARQUIVOS PARA SEREM IMPORTADOS - TELEFONE *}
      {**************************************************************LU*}
      If (FindFirst(strPath + '\complcli*.*', faAnyFile, srcArquivos) = 0) Then
      Begin
       cdsArquivos.EmptyDataSet;
        Repeat
          Application.ProcessMessages;
          cdsArquivos.Append;
          cdsArquivos.FieldByName('NOMARQ').AsString := ExtractFileName(srcArquivos.Name);
         cdsArquivos.Post;
        Until (FindNext(srcArquivos) <> 0);
        FindClose(srcArquivos);

        With cdsArquivos Do
        Begin
          First;

          While Not Eof Do
          Begin
            Application.ProcessMessages;
            pImp_Telefone(FieldByName('NOMARQ').AsString);
            fRenomearArquivo(strPath + '\' + FieldByName('NOMARQ').AsString, fCfgSis('PEDACA') + '\' + FieldByName('NOMARQ').AsString + '.OLD');
            DeleteFile(strPath + '\' + FieldByName('NOMARQ').AsString);
            Next;
          End;

        End;

        pGrava_Telefone;

      End
      Else
      Begin
        pGravaInconsistencia('',
                             'Telefone - Nenhum arquivo para importação!',
                             '',
                             '');
      End;

      {*****************************************************************}
      {* VERIFICA SE EXISTEM ARQUIVOS PARA SEREM IMPORTADOS - PEDIDO   *}
      {**************************************************************LU*}
      If (FindFirst(strPath + '\pedcab*.*', faAnyFile, srcArquivos) = 0) Then
      Begin
        cdsArquivos.EmptyDataSet;
        Repeat
          Application.ProcessMessages;
          cdsArquivos.Append;
          cdsArquivos.FieldByName('NOMARQ').AsString := ExtractFileName(srcArquivos.Name);
         cdsArquivos.Post;
        Until (FindNext(srcArquivos) <> 0);
        FindClose(srcArquivos);

        With cdsArquivos Do
        Begin
          First;
          intTotRegP := RecordCount;

          While Not Eof Do
          Begin
            Application.ProcessMessages;
            pImp_Pedido(FieldByName('NOMARQ').AsString);
            Next;
          End;

        End;

      End;

      {*********************************************************************}
      {* VERIFICA SE EXISTEM ARQUIVOS PARA SEREM IMPORTADOS - ITENS PEDIDO *}
      {******************************************************************LU*}
      If (FindFirst(strPath + '\peditens*.*', faAnyFile, srcArquivos) = 0) Then
      Begin
        cdsArquivos.EmptyDataSet;
        Repeat
          Application.ProcessMessages;
          cdsArquivos.Append;
          cdsArquivos.FieldByName('NOMARQ').AsString := ExtractFileName(srcArquivos.Name);
         cdsArquivos.Post;
        Until (FindNext(srcArquivos) <> 0);
        FindClose(srcArquivos);

        With cdsArquivos Do
        Begin
          First;
          intTotRegPI := RecordCount;

          While Not Eof Do
          Begin
            Application.ProcessMessages;
            pImp_ItensPedido(FieldByName('NOMARQ').AsString);
            Next;
          End;

        End;

      End;

      {************************************************************}
      {* VERIFICA SE EXISTE O MESMO NÚMERO DE ARQUIVOS DE PEDIDOS *}
      {* E DE ARQUIVO DE ITENS DE PEDIDOS                         *}
      {*********************************************************LU*}
      If (intTotRegP = intTotRegPI) Then
      Begin
        {****************************************************************}
        {* VERIFICA SE IRÁ GERAR PEDIDOS SEPARADOS PARA ITENS COM SALDO *}
        {* E PARA OS ITENS SEM SALDO.                                   *}
        {*************************************************************PZ*}
        If blnSepararItensCom_e_SemSaldo Then
        Begin
          pSepararProdutosCom_e_SemSaldo;
          pGrava_Pedido(True, 'S');
          pGrava_Pedido(True, 'N');
        End
        Else
          pGrava_Pedido(False, '');
      End
      Else
      Begin

        If (Not blnGeracaoAut) Then
        Begin
          fMensagem('','Número de arquivos de Pedido e de Itens incompatível! Verifique!',['&OK']);
        End;

        btnConfirma.Enabled := True;
        btnSair.Enabled := True;
        dirPathImp.Enabled := True;
        pnlInfo.Caption := '';
        Exit;
      End;

      {**************************************************************}
      {* VERIFICA SE FORAM GERADAS INCONSISTENCIAS E GERA RELATORIO *}
      {***********************************************************LU*}
      If Not cdsInconsistencia.IsEmpty Then
      Begin
        If (Not blnGeracaoAut) Then
        Begin
          fMensagem('','Foram encontradas inconsistências na importação dos arquivos!',['&OK']);

          cdsInconsistencia.Open;
          frxRelatorio.DataSet := cdsInconsistencia;
          frxPagina.Script.Variables['NOMEMP'] := fRetNomeEmpresa;
          frxPagina.Script.Variables['NOMREL'] := 'IMPORTACAO DE PEDIDOS - RELATORIO DE INCONSISTENCIAS';
          pPreviewReport(Self.Name, Self.Caption + ' (Relatorio de inconsistencias)', frxPagina);
        End;

      End;

      {***********************************************************************}
      {* VERIFICA SE FORAM GERADAS INCONSISTENCIAS DE SALDO E GERA RELATORIO *}
      {********************************************************************PZ*}
      If Not cdsIncSaldo.IsEmpty Then
      Begin
        If (Not blnGeracaoAut) Then
        Begin
          fMensagem('','Foram encontradas inconsistências de saldo na importação dos arquivos!',['&OK']);
        End;

        cdsIncSaldo.Open;
        cdsIncSaldo.IndexFieldNames := 'NUMPED;CODITE';
        frxIncSalDB.DataSet := cdsIncSaldo;
        frxIncSalPag.Script.Variables['NOMEMP'] := fRetNomeEmpresa;
        frxIncSalPag.Script.Variables['NOMREL'] := 'IMPORTACAO DE PEDIDOS - RELATORIO DE INCONSISTENCIAS DE SALDO DOS ITENS';
        pPreviewReport(Self.Name, Self.Caption + ' (Relatorio de inconsistencias de saldo dos itens)', frxIncSalPag);
      End;

    End
    Else
      If (Not blnGeracaoAut) Then
      Begin
        fMensagem('','Não foram encontrados arquivos para importação!',['&OK']);
      End;

    cdsArquivos.Close;
    cdsTelefone.Close;
    cdsPedido.Close;
    cdsPedidoItem.Close;
    cdsInconsistencia.Close;
    cdsIncSaldo.Close;

    btnConfirma.Enabled := True;
    btnSair.Enabled := True;
    dirPathImp.Enabled := True;
    pnlInfo.Caption := 'Importação completada com sucesso!';

  End;
end;

procedure TfrmTxtACACIAServerImpAndroid.FormActivate(Sender: TObject);
begin
  inherited;
  If blnGeracaoAut And (Not blnGerou) Then
  Begin
    btnConfirma.Click;
    blnGerou := True;
    tmrFecha.Enabled := True;
  End
  Else If Not fEmptyStr(dirPathImp.edtDirectory.text) Then
    pSetFocus(btnConfirma)
  Else
    pSetFocus(dirPathImp);
end;

procedure TfrmTxtACACIAServerImpAndroid.FormCreate(Sender: TObject);
begin
  inherited;
  blnSepararItensCom_e_SemSaldo :=
    (Not fCfgSis('DELACA', varBoolean)) And (fCfgSis('SEPPED', varBoolean));

  blnEmpFat   := fCfgSis('EMPFAT', varBoolean);
  qryGenerica := fCriaQuery(Self);
  qryUpdate   := fCriaQuery(Self);

  {****************************}
  {* CLIENTDATASET - ARQUIVOS *}
  {*************************LU*}
  cdsArquivos := TUniClientDataSet.Create(Self);
  cdsArquivos.DisableControls;
  cdsArquivos.FetchOnDemand := False;

  With cdsArquivos.FieldDefs.AddFieldDef Do
  Begin
    Name := 'NOMARQ';
    DataType := ftString;
    Size := 100;
  End;
  cdsArquivos.CreateDataSet;

  {***********************************}
  {* CLIENTDATASET - INCONSISTENCIAS *}
  {********************************LU*}
  cdsInconsistencia := TUniClientDataSet.Create(Self);
  cdsInconsistencia.DisableControls;
  cdsInconsistencia.FetchOnDemand := False;

  With cdsInconsistencia.FieldDefs.AddFieldDef Do
  Begin
    Name := 'NOMARQ';
    DataType := ftString;
    Size := 100;
  End;

  With cdsInconsistencia.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DESCRI';
    DataType := ftString;
    Size := 100;
  End;

  With cdsInconsistencia.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CODIGO';
    DataType := ftString;
    Size := 25;
  End;

  With cdsInconsistencia.FieldDefs.AddFieldDef Do
  Begin
    Name := 'PEDIDO';
    DataType := ftString;
    Size := 10;
  End;
  cdsInconsistencia.CreateDataSet;

  {*********************************************}
  {* CLIENTDATASET - INCONSISTENCIAS DE SALDO. *}
  {******************************************PZ*}
  cdsIncSaldo := TUniClientDataSet.Create(Self);
  cdsIncSaldo.DisableControls;
  cdsIncSaldo.FetchOnDemand := False;

  With cdsIncSaldo.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DTAPED';
    DataType := ftString;
    Size := 10;
  End;

  With cdsIncSaldo.FieldDefs.AddFieldDef Do
  Begin
    Name := 'NUMPED';
    DataType := ftString;
    Size := 12;
  End;

  With cdsIncSaldo.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ESPDOC';
    DataType := ftString;
    Size := 02;
  End;

  With cdsIncSaldo.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CODEMP';
    DataType := ftString;
    Size := 03;
  End;

  With cdsIncSaldo.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CODCLI';
    DataType := ftString;
    Size := 8;
  End;

  With cdsIncSaldo.FieldDefs.AddFieldDef Do
  Begin
    Name := 'NOMCLI';
    DataType := ftString;
    Size := 60;
  End;

  With cdsIncSaldo.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CODITE';
    DataType := ftString;
    Size := fTamCodIte;
  End;

  With cdsIncSaldo.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DESITE';
    DataType := ftString;
    Size := 70;
  End;

  With cdsIncSaldo.FieldDefs.AddFieldDef Do
  Begin
    Name := 'SIGUNI';
    DataType := ftString;
    Size := 6;
  End;

  With cdsIncSaldo.FieldDefs.AddFieldDef Do
  Begin
    Name := 'QTDITE';
    DataType := ftFloat;
    Precision := fCfgSis('DECUNI', varInteger);
  End;

  With cdsIncSaldo.FieldDefs.AddFieldDef Do
  Begin
    Name := 'UNITAR';
    DataType := ftFloat;
    Precision := fCfgSis('DECUNI', varInteger);
  End;

  With cdsIncSaldo.FieldDefs.AddFieldDef Do
  Begin
    Name := 'TOTITE';
    DataType := ftFloat;
    Precision := fCfgSis('DECUNI', varInteger);
  End;

  cdsIncSaldo.CreateDataSet;

  {****************************}
  {* CLIENTDATASET - TELEFONE *}
  {*************************LU*}
  cdsTelefone := TUniClientDataSet.Create(Self);
  cdsTelefone.DisableControls;
  cdsTelefone.FetchOnDemand := False;

  With cdsTelefone.FieldDefs.AddFieldDef Do
  Begin
    Name := 'NOMARQ';
    DataType := ftString;
    Size := 50;
  End;

  With cdsTelefone.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CODCLI';
    DataType := ftString;
    Size := 8;
  End;

  With cdsTelefone.FieldDefs.AddFieldDef Do
  Begin
    Name := 'FONE01';
    DataType := ftString;
    Size := 15;
  End;

  With cdsTelefone.FieldDefs.AddFieldDef Do
  Begin
    Name := 'EMAIL_';
    DataType := ftString;
    Size := 50;
  End;

  With cdsTelefone.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CODATI';
    DataType := ftString;
    Size := 3;
  End;
  cdsTelefone.CreateDataSet;

  {**************************}
  {* CLIENTDATASET - PEDIDO *}
  {***********************LU*}
  cdsPedido := TUniClientDataSet.Create(Self);
  cdsPedido.DisableControls;
  cdsPedido.FetchOnDemand := False;

  With cdsPedido.FieldDefs.AddFieldDef Do
  Begin
    Name := 'NOMARQ';
    DataType := ftString;
    Size := 50;
  End;

  With cdsPedido.FieldDefs.AddFieldDef Do
  Begin
    Name := 'NUMDOC';
    DataType := ftString;
    Size := 30;
  End;

  With cdsPedido.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CODEMP';
    DataType := ftString;
    Size := 10;
  End;

  With cdsPedido.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DTAPED';
    DataType := ftString;
    Size := 10;
  End;

  With cdsPedido.FieldDefs.AddFieldDef Do
  Begin
    Name := 'HORPED';
    DataType := ftString;
    Size := 5;
  End;

  With cdsPedido.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CODCLI';
    DataType := ftString;
    Size := 8;
  End;

  With cdsPedido.FieldDefs.AddFieldDef Do
  Begin
    Name := 'SERDOC';
    DataType := ftString;
    Size := 2;
  End;

  With cdsPedido.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CODPAG';
    DataType := ftString;
    Size := 10;
  End;

  With cdsPedido.FieldDefs.AddFieldDef Do
  Begin
    Name := 'FORPAG';
    DataType := ftString;
    Size := 10;
  End;

  With cdsPedido.FieldDefs.AddFieldDef Do
  Begin
    Name := 'TIPTAB';
    DataType := ftString;
    Size := 3;
  End;

  With cdsPedido.FieldDefs.AddFieldDef Do
  Begin
    Name := 'OBS001';
    DataType := ftString;
    Size := 100;
  End;

  With cdsPedido.FieldDefs.AddFieldDef Do
  Begin
    Name := 'OBS002';
    DataType := ftString;
    Size := 100;
  End;

  With cdsPedido.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CODVEN';
    DataType := ftString;
    Size := 3;
  End;

  With cdsPedido.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CODUND';
    DataType := ftString;
    Size := 1;
  End;

  With cdsPedido.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CODUNI';
    DataType := ftString;
    Size := 4;
  End;

  With cdsPedido.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ESPDOC';
    DataType := ftString;
    Size := 2;
  End;

  cdsPedido.CreateDataSet;

  {********************************}
  {* CLIENTDATASET - ITENS PEDIDO *}
  {*****************************LU*}
  cdsPedidoItem := TUniClientDataSet.Create(Self);
  cdsPedidoItem.DisableControls;
  cdsPedidoItem.FetchOnDemand := False;

  With cdsPedidoItem.FieldDefs.AddFieldDef Do
  Begin
    Name := 'NOMARQ';
    DataType := ftString;
    Size := 50;
  End;

  With cdsPedidoItem.FieldDefs.AddFieldDef Do
  Begin
    Name := 'NUMDOC';
    DataType := ftString;
    Size := 30;
  End;

  With cdsPedidoItem.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CODEMP';
    DataType := ftString;
    Size := 10;
  End;  

  With cdsPedidoItem.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DTAPED';
    DataType := ftString;
    Size := 10;
  End;

  With cdsPedidoItem.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CODCLI';
    DataType := ftString;
    Size := 8;
  End;

  With cdsPedidoItem.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CODITE';
    DataType := ftString;
    Size := fTamCodIte;
  End;

  With cdsPedidoItem.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CODPAG';
    DataType := ftString;
    Size := 10;
  End;

  With cdsPedidoItem.FieldDefs.AddFieldDef Do
  Begin
    Name := 'QTDITE';
    DataType := ftFloat;
    Precision := fCfgSis('DECUNI', varInteger);
  End;

  With cdsPedidoItem.FieldDefs.AddFieldDef Do
  Begin
    Name := 'UNITAR';
    DataType := ftFloat;
    Precision := fCfgSis('DECUNI', varInteger);
  End;

  With cdsPedidoItem.FieldDefs.AddFieldDef Do
  Begin
    Name := 'UNIORI';
    DataType := ftFloat;
    Precision := fCfgSis('DECUNI', varInteger);
  End;


  With cdsPedidoItem.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DESCON';
    DataType := ftFloat;
    Precision := fCfgSis('DECUNI', varInteger);
  End;

  With cdsPedidoItem.FieldDefs.AddFieldDef Do
  Begin
    Name := 'TOTITE';
    DataType := ftFloat;
    Precision := fCfgSis('DECUNI', varInteger);
  End;

  With cdsPedidoItem.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CODVEN';
    DataType := ftString;
    Size := 3;
  End;

  With cdsPedidoItem.FieldDefs.AddFieldDef Do
  Begin
    Name := 'SALDOS';
    DataType := ftString;
    Size := 1;
  End;

  cdsPedidoItem.AggregatesActive := True;

  With TAggregateField.Create(Self) Do
  Begin
    Name          := 'TOT_QTDITE';
    FieldName     := 'TOT_QTDITE';
    DataSet       := cdsPedidoItem;
    Expression    := 'SUM(QTDITE)';
    Active        := True;
  End;

  cdsPedidoItem.CreateDataSet;

  blnGeracaoAut := False;
  blnGerou      := False;

end;

procedure TfrmTxtACACIAServerImpAndroid.FormShow(Sender: TObject);
begin
  inherited;
  dirPathImp.edtDirectory.text := fCfgSis('IMPACA');

  If (blnGeracaoAut) Then
  Begin
    If (fEmptyStr(dirPathImp.edtDirectory.text)) Then
      dirPathImp.edtDirectory.text := 'C:\ACACIA\';
  End;
end;

function TfrmTxtACACIAServerImpAndroid.fRetornaSaldoDisponivel(strCodIte: String): Double;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Self);

  qryGen.SQL.Clear;
  qryGen.SQL.Add('SELECT');
  qryGen.SQL.Add('	ITE_SALDOS');
  qryGen.SQL.Add('FROM ');
  qryGen.SQL.Add('	CADITE I');
  qryGen.SQL.Add('	INNER JOIN ITEGER G ON I.ITE_CODITE = G.ITE_CODITE');
  qryGen.SQL.Add('WHERE');
  qryGen.SQL.Add('	I.ITE_CODITE = :CODITE');
  qryGen.SQL.Add('	AND G.ITE_CODEMP = :CODEMP');

  qryGen.ParamByName('CODITE').AsString := strCodIte;
  qryGen.ParamByName('CODEMP').AsString := VS_strCodEmp;

  qryGen.Open;

  Result := qryGen.FieldByName('ITE_SALDOS').AsFloat -
    TSaldoReservado.New(
      TReservaParametros.New()
        .EmpresaItem(VS_strCodEmp)
        .CodigoItem(strCodIte)
        .CodEmpresa(VS_strCodEmp)
      ).fGetQuantidade();

  FreeAndNil(qryGen);
end;

function TfrmTxtACACIAServerImpAndroid.fValidaAtividade(strCodAti: String): Boolean;
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   COUNT(*) AS QTD ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   CADATI ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   ATI_CODATI = :CODATI ';

  With qryGenerica Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODATI').AsString := strCodAti;
    Open;

    If FieldByName('QTD').AsInteger <= 0 Then
      Result := False
    Else
      Result := True;
  End;

end;

function TfrmTxtACACIAServerImpAndroid.fValidaCliente(strCodCli: String): Boolean;
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   COUNT(*) AS QTD ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   CADCLI ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   CLI_CODCLI = :CODCLI ';

  With qryGenerica Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODCLI').AsString := strCodCli;
    Open;

    If FieldByName('QTD').AsInteger <= 0 Then
      Result := False
    Else
      Result := True;
  End;
  
end;

function TfrmTxtACACIAServerImpAndroid.fValidaCondPagto(strCodCnd: String): Boolean;
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   COUNT(*) AS QTD ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   CADCND ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   CND_CODIGO = :CODCND ';

  With qryGenerica Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODCND').AsString := strCodCnd;
    Open;

    If FieldByName('QTD').AsInteger <= 0 Then
      Result := False
    Else
      Result := True;
  End;

end;

function TfrmTxtACACIAServerImpAndroid.fValidaFormaPagto(strCodFpg: String): Boolean;
begin

  Result := False;

  If fEmptyStr(strCodFpg) Then
    Exit;

  Result := ( fCampoTabela('COUNT(*) AS QTD', 'CADFPG', ['FPG_CODIGO'], [strCodFpg], False) > 0 );

end;

function TfrmTxtACACIAServerImpAndroid.fValidaItem(strCodIte: String): Boolean;
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   COUNT(*) AS QTD ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   CADITE ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   ITE_CODITE = :CODITE ';

  With qryGenerica Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODITE').AsString := strCodIte;
    Open;

    If FieldByName('QTD').AsInteger <= 0 Then
      Result := False
    Else
      Result := True;
  End;
end;

function TfrmTxtACACIAServerImpAndroid.fValidaPedido(strNumPok: String): Boolean;
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   COUNT(*) AS QTD ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   FATGOR ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   FGO_NUMPOK = :NUMPOK  ';

  With qryGenerica Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('NUMPOK').AsString := strNumPok;
    Open;

    If FieldByName('QTD').AsInteger <= 0 Then
      Result := False
    Else
      Result := True;
  End;

end;

function TfrmTxtACACIAServerImpAndroid.fValidaVendedor(strCodVen: String): Boolean;
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   COUNT(*) AS QTD ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   CADOPE ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   OPE_CODOPE = :CODOPE ';

  With qryGenerica Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODOPE').AsString := strCodVen;
    Open;

    If FieldByName('QTD').AsInteger <= 0 Then
      Result := False
    Else
      Result := True;
  End;

end;

function TfrmTxtACACIAServerImpAndroid.fVerificaSaldo(strCodIte: String; fltQtdImp: Double): Boolean;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Self);

  qryGen.SQL.Clear;
  qryGen.SQL.Add('SELECT');
  qryGen.SQL.Add('	ITE_SALDOS');
  qryGen.SQL.Add('FROM ');
  qryGen.SQL.Add('	CADITE I');
  qryGen.SQL.Add('	INNER JOIN ITEGER G ON I.ITE_CODITE = G.ITE_CODITE');
  qryGen.SQL.Add('WHERE');
  qryGen.SQL.Add('	I.ITE_CODITE = :CODITE');
  qryGen.SQL.Add('	AND G.ITE_CODEMP = :CODEMP');

  qryGen.ParamByName('CODITE').AsString := strCodIte;
  qryGen.ParamByName('CODEMP').AsString := VS_strCodEmp;

  qryGen.Open;

  Result := (fRetornaSaldoDisponivel(strCodIte) - fltQtdImp) >= 0;

  FreeAndNil(qryGen);
end;

procedure TfrmTxtACACIAServerImpAndroid.pGravaInconsistencia(strNomArq, strDescri, strCodigo, strPedido: String);
begin
  With cdsInconsistencia Do
  Begin
    Append;
    FieldByName('NOMARQ').AsString := strNomArq;
    FieldByName('DESCRI').AsString := strDescri;
    FieldByName('CODIGO').AsString := strCodigo;
    FieldByName('PEDIDO').AsString := strPedido;
    Post;
  End;
end;

procedure TfrmTxtACACIAServerImpAndroid.pGravaInconsistenciasSaldos(dtaDtaPed: TDate;
                                                                    strNumPed,
                                                                    strEspDoc,
                                                                    strCodEmp,
                                                                    strCodCli,
                                                                    strNomCli,
                                                                    strCodIte,
                                                                    strDesIte,
                                                                    strSigUni: String;
                                                                    fltQtdIte,
                                                                    fltUnitar,
                                                                    fltTotIte: Double);
begin
  With cdsIncSaldo Do
  Begin
    Append;
    FieldByName('DTAPED').AsDateTime := dtaDtaPed;
    FieldByName('NUMPED').AsString   := strNumPed;
    FieldByName('ESPDOC').AsString   := strEspDoc;
    FieldByName('CODEMP').AsString   := strCodEmp;
    FieldByName('CODCLI').AsString   := strCodCli;
    FieldByName('NOMCLI').AsString   := strNomCli;
    FieldByName('CODITE').AsString   := strCodIte;
    FieldByName('DESITE').AsString   := strDesIte;
    FieldByName('SIGUNI').AsString   := strSigUni;
    FieldByName('QTDITE').AsFloat    := fltQtdIte;
    FieldByName('UNITAR').AsFloat    := fltUnitar;
    FieldByName('TOTITE').AsFloat    := fltTotIte;
    Post;
  End;
end;

procedure TfrmTxtACACIAServerImpAndroid.pGrava_Pedido(blnSepSal: Boolean; strComSal: String);
  Var
    strNumDoc: String;
    strCodCli: String;
    strCodVen: String;
    strDtaEnt: String;
    strSQL   : String;
    strAutInc: String;
    strAutFdo: String;
    fltTotGer: Double;
    fltTotCus: Double;
    fltTotMed: Double;
    blnInsere: Boolean;
    intSeqInc: Integer;
    strCodCnd: String;
    strCodFpg: String;
    strDescri: String;
    strTipPed: String;
    strCodEmp: String;
    recServicos: TDadosServicos;
    arrDuplic : TarrDuplicata;
begin
  With cdsPedido Do
  Begin
    First;

    pgbPedidos.Max := RecordCount;

    While Not Eof Do
    Begin
      pgbPedidos.Position := RecNo;
      Application.ProcessMessages;

      strNumDoc := fRetSequencialPedido;
      strCodCli := fieldbyname('CODCLI').AsString;
      strCodVen := fieldbyname('CODVEN').AsString;
      strDtaEnt := fieldbyname('DTAPED').AsString;
      strCodEmp := Trim(FieldByName('CODEMP').AsString);

      {*****************************************}
      {* TRATA TIPO DO PEDIDO PARA FATURAMENTO *}
      {**************************************IV*}
      If SameText(fieldbyname('SERDOC').AsString, '00') Then
           strTipPed := 'A'
      Else If SameText(fieldbyname('SERDOC').AsString, '01') Then
           strTipPed := 'B'
      Else strTipPed := '';

      {*****************************************}
      {* VERIFICA SE A COND. DE PAGTO É VALIDA *}
      {**************************************LU*}
      If fValidaCondPagto(fieldbyname('CODPAG').AsString) Then
        strCodCnd := fieldbyname('CODPAG').AsString
      Else
        strCodCnd := fRetCodCndAVista;

      {*****************************************}
      {* VERIFICA SE A COND. DE PAGTO É VALIDA *}
      {**************************************LU*}
      If fValidaFormaPagto(fieldbyname('FORPAG').AsString) Then
        strCodFpg := fieldbyname('FORPAG').AsString
      Else
        strCodFpg := '001';

      {*****************************************}
      {* VERIFICA SE O PEDIDO AINDA NÃO EXISTE *}
      {**************************************LU*}
      If Not fValidaPedido(FieldByName('NUMDOC').AsString) Then
      Begin
        {**************************************************}
        {* VERIFICA SE O CLIENTE E O VENDEDOR SÃO VÁLIDOS *}
        {***********************************************LU*}
        If (fValidaCliente(strCodCli)) And (fValidaVendedor(strCodVen)) Then
        Begin

          {*****************************************************************}
          {* LOCALIZA OS ITENS REFERENTES AO PEDIDO QUE ESTÁ SENDO INCLUSO *}
          {**************************************************************LU*}
          {*****************************************************************}
          {* VERIFICA SE IRÁ FILTRAR PARA GERAR PEDIDOS SEPARADOS PARA OS  *}
          {* ITENS COM SALDO E ITENS SEM SALDO.                            *}
          {**************************************************************LU*}
          If (blnSepSal) Then
            cdsPedidoItem.Filter := 'NUMDOC = ' + QuotedStr(fieldbyname('NUMDOC').AsString) +
                                    ' AND CODVEN = ' + QuotedStr(strCodVen) +
                                    ' AND CODCLI = ' + QuotedStr(strCodCli) +
                                    ' AND SALDOS = ' + QuotedStr(strComSal) +
                                    ' AND CODEMP = ' + QuotedStr(strCodEmp)
          Else
            cdsPedidoItem.Filter := 'NUMDOC = ' + QuotedStr(fieldbyname('NUMDOC').AsString) +
                                    ' AND CODVEN = ' + QuotedStr(strCodVen) +
                                    ' AND CODCLI = ' + QuotedStr(strCodCli) +
                                    ' AND CODEMP = ' + QuotedStr(strCodEmp);

          cdsPedidoItem.Filtered := True;

          If Not cdsPedidoItem.IsEmpty Then
          Begin
            fltTotGer := 0.0;
            fltTotCus := 0.0;
            fltTotMed := 0.0;
            intSeqInc := 0;

            blnInsere := True;

            pgbProdutos.Max := cdsPedidoItem.RecordCount;

            While Not cdsPedidoItem.Eof Do
            Begin
              pgbProdutos.Position := cdsPedidoItem.RecNo;            
              Application.ProcessMessages;

              If fValidaItem(cdsPedidoItem.fieldbyname('CODITE').AsString) Then
              Begin

                If blnInsere Then
                Begin
                  {******************}
                  {* GRAVA O PEDIDO *}
                  {***************LU*}
                  
                  If (VS_strHabilitarCRM) And (Not fEmptyStr(fCfgSis('VENORC', varString))) And (Not fEmptyStr(fCfgSis('VENPED', varString))) Then
                    objOcoCrm := fAtualizaInformacoesCRM(
                                   strNumDoc,
                                   FieldByName('ESPDOC').AsString,
                                   VS_strCodEmp,
                                   strCodCli,
                                   '',
                                   '',
                                   strCodVen,
                                   afcPedido);

                  FillChar(arrDuplic, Sizeof(arrDuplic) , #0);

                  objOcoCrm.strNomFrm := Self.Name;

                  fGravaFatGor(strAutInc,                                                                                   // strIncrem
                               FieldByName('CODEMP').AsString,                                                              //  strCodEmp
                               strNumDoc,                                                                                   //  strNumDoc
                               FieldByName('ESPDOC').AsString,                                                              //  strEspDoc
                               strCodCli,                                                                                   //  strCodCli
                               strCodVen,                                                                                   //  strCodVen
                               '',                                                                                          //  strCodTra
                               '',                                                                                          //  strSerie:
                               StrToDateTime(copy(strDtaEnt,1,2) + '/' + copy(strDtaEnt,3,2) + '/' + copy(strDtaEnt,5,4)),  //  dtaDtaEnt
                               StrToTime(fieldbyname('HORPED').AsString),                                                   //  dtaHorEnt
                               fRetConPagCodCnd(strCodCnd),                                                                 //  strConPag
                               '',                                                                                          //  strEstado
                               '',                                                                                          //  strNomCom
                               '',                                                                                          //  strEndCon
                               '',                                                                                          //  strBaiCon
                               '',                                                                                          //  strCepCon
                               '',                                                                                          //  strCidCon
                               '',                                                                                          //  strEstCon
                               '',                                                                                          //  strCodAti
                               '',                                                                                          //  strTelCon
                               0,                                                                                           //  dtaNasCon
                               '',                                                                                          //  strCgcCpf
                               '',                                                                                          //  strCgcCon
                               '',                                                                                          //  strIesCon
                               '',                                                                                          //  strCli_Rg
                               0.0,                                                                                         //  fltBasSim
                               0.0,                                                                                         //  fltBasIpi
                               0.0,                                                                                         //  fltAlqIpi
                               0.0,                                                                                         //  fltTotIpi
                               0.0,                                                                                         //  fltBasIcm
                               0.0,                                                                                         //  fltAlqIcm
                               0.0,                                                                                         //  fltTotIcm
                               0.0,                                                                                         //  fltTotRet
                               0.0,                                                                                         //  fltAlqRet
                               0.0,                                                                                         //  fltBasRet
                               0.0,                                                                                         //  fltDesEsp
                               fltTotGer,                                                                                   //  fltVlrCon
                               fltTotGer,                                                                                   //  fltTotPro
                               fltTotCus,                                                                                   //  fltTotCus
                               fltTotMed,                                                                                   //  fltTotMed
                               '',                                                                                          //  strTipFre
                               0.0,                                                                                         //  fltTotFre

                               0.0,                                                                                         //  fltTotFre
                               0.0,                                                                                         //  fltTotFre
                               0.0,                                                                                         //  fltTotFre
                               0.0,                                                                                         //  fltTotFre
                               0.0,                                                                                         //  fltTotFre
                               0.0,                                                                                         //  fltTotFre
                               0.0,                                                                                         //  fltTotFre
                               0.0,                                                                                         //  fltTotFre
                               0.0,                                                                                         //  fltTotFre
                               0.0,                                                                                         //  fltTotFre
                               0.0,                                                                                         //  fltTotFre
                               0.0,                                                                                         //  fltTotFre

                               0.0,                                                                                         //  fltDesAce
                               0.0,                                                                                         //  fltPesBru
                               0.0,                                                                                         //  fltPesLiq
                               0,                                                                                           //  fltVolume
                               arrDuplic,                                                                                   //  arrDuplic
                               '',                                                                                          //  strEspeci
                               '',                                                                                          //  strMarca,
                               fieldbyname('OBS001').AsString,                                                              //  strMen001
                               fieldbyname('OBS002').AsString,                                                              //  strMen002
                               False,                                                                                       //  blnJaFatu
                               '',                                                                                          //  strTipFat
                               '',                                                                                          //  strNumFat
                               '',                                                                                          //  strEmpFat
                               0,                                                                                           //  dtaDtaFat
                               '',                                                                                          //  strVenFat
                               '',                                                                                          //  strCndFat
                               0.0,                                                                                         //  fltValFat
                               0.0,                                                                                         //  fltPorDes
                               strLoginUsuarioLogado,                                                                       //  strCodDig
                               strCodCnd,                                                                                   //  strCodCnd
                               strCodFpg,                                                                                   //  strCodFpg
                               recServicos,
                               '',                                                                                          //  strConEnt
                               VS_Date,                                                                                     //  dtaPreVis
                               0.0,                                                                                         //  fltVPgAnt
                               VS_Date,                                                                                     //  dtaUltAlt
                               '',                                                                                          //  strNTrava
                               'A',                                                                                         //  strTipPed
                               '',                                                                                          //  strCliCtt
                               0,                                                                                       //  blnLibera
                               'S',                                                                                         //  strEntFat
                               0.0,                                                                                         //  fltDesCon
                               fieldbyname('TIPTAB').AsString,                                                              //  strTabPre
                               '',                                                                                          //  strEntFut
                               0.0,                                                                                         //  fltMargem
                               fieldbyname('NUMDOC').AsString,                                                              //  strNumPok
                               '',                                                                                          //  strEmp_CD                               
                               False,                                                                                       //  blnEnt_CD
                               'N',                                                                                         //  strOprFlj
                               '',                                                                                          //  strMenExp
                               '',                                                                                          //  strMenExp
                               '',                                                                                          //  strMenExp
                               '',                                                                                          //  strMenExp
                               '',                                                                                          //  strNumReg
                               '',                                                                                          //  strPedSit
                               False,                                                                                       //  blnPedLib
                               VS_Date,
                               'N',
                               'V',
                               VS_Date,                                                                                    //  dtaDtEntr
                               'P',       //strTipFin
                               0,        //fltDesFin
                               '',        //strAutEnt
                               '',
                               '',
                               False,
                               '',
                               Nil,
                               '',
                               '',
                               0,
                               0,
                               0,
                               '',
                               objOcoCrm,
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

                  blnInsere := False;

                  {*****************************************************************}
                  {* RENOMEIA O ARQUIVO E MOVE PARA A PASTA DE ARQUIVOS IMPORTADOS *}
                  {**************************************************************LU*}
                  If (SysUtils.FindFirst(strPath + '\' + FieldByName('NOMARQ').AsString, faAnyFile, srcArquivos) = 0) Then
                  Begin
                    fRenomearArquivo(strPath + '\' + FieldByName('NOMARQ').AsString, fCfgSis('PEDACA') + '\' + FieldByName('NOMARQ').AsString + '.OLD');
                    DeleteFile(strPath + '\' + FieldByName('NOMARQ').AsString);
                  End;

                End;

                {*******************}
                {* INCLUI OS ITENS *}
                {****************LU*}
                strSQL := '';
                strSQL := strSQL + ' SELECT ';
                strSQL := strSQL + '   C.ITE_CODGRU AS CODGRU, ';
                strSQL := strSQL + '   C.ITE_DESITE AS DESITE, ';
                strSQL := strSQL + '   C.ITE_REFERE AS REFERE, ';
                strSQL := strSQL + '   C.ITE_CODMAR AS CODMAR, ';
                strSQL := strSQL + '   C.ITE_CODFOR AS CODFOR, ';
                strSQL := strSQL + '   C.ITE_CODUNI AS CODUNI, ';

                If fCfgSIs('TIPABF') = '1' Then
                  strSQL := strSQL + '   C.ITE_CODABF AS CODABF, '
                Else
                  strSQL := strSQL + '   I.ITE_CODABF AS CODABF, ';

                strSQL := strSQL + '   C.ITE_PESOIT AS PESOIT, ';
                strSQL := strSQL + '   I.ITE_PRECUS AS PRECUS, ';
                strSQL := strSQL + '   I.ITE_PREMED AS PREMED, ';
                strSQL := strSQL + '   I.ITE_COMVAR AS COMVAR ';
                strSQL := strSQL + ' FROM ';
                strSQL := strSQL + '   CADITE C, ';
                strSQL := strSQL + '   ITEGER I ';
                strSQL := strSQL + ' WHERE ';
                strSQL := strSQL + '   I.ITE_CODITE = C.ITE_CODITE AND ';
                strSQL := strSQL + '   I.ITE_CODITE = :CODITE AND ';
                strSQL := strSQL + '   I.ITE_CODEMP = :CODEMP ';

                With qryGenerica Do
                Begin
                  Close;
                  SQL.Clear;
                  SQL.Add(strSQL);
                  ParamByName('CODITE').AsString := cdsPedidoItem.fieldbyname('CODITE').AsString;
                  ParamByName('CODEMP').AsString := cdsPedidoItem.fieldbyname('CODEMP').AsString;
                  Open;

                  fltTotGer := fltTotGer + cdsPedidoItem.fieldbyname('TOTITE').AsFloat;
                  fltTotCus := fltTotCus + (fieldbyname('PRECUS').AsFloat * cdsPedidoItem.fieldbyname('QTDITE').AsFloat);
                  fltTotMed := fltTotMed + (fieldbyname('PREMED').AsFloat * cdsPedidoItem.fieldbyname('QTDITE').AsFloat);;
                End;

                intSeqInc := intSeqInc + 1;

                strDescri := qryGenerica.fieldbyname('DESITE').AsString;

                If (fCfgSis('IMPREF', varBoolean)) Then
                  If (fCfgSis('MONDES', varString) = '1') Then
                    strDescri := strDescri +
                                 IIF(Not fEmptyStr(qryGenerica.fieldbyname('REFERE').AsString),' ' + qryGenerica.fieldbyname('REFERE').AsString,'')
                  Else
                    strDescri := IIF(Not fEmptyStr(qryGenerica.fieldbyname('REFERE').AsString),qryGenerica.fieldbyname('REFERE').AsString + ' ','') +
                                 strDescri;

                strAutFdo := '';
                fGravaFatDor(strAutFdo,
                             strAutInc,                                                                                            // strSeqGer
                             Trim(cdsPedidoItem.fieldbyname('CODEMP').AsString),                                                   //  strCodEmp
                             strCodCli,                                                                                            //  strCodCli
                             strCodVen,                                                                                            //  strCodVen
                             cdsPedidoItem.fieldbyname('CODITE').AsString,                                                         //  strCodIte
                             qryGenerica.fieldbyname('CODMAR').AsString,                                                           //  strCodMar
                             '',                                                                                                   //  strCodDiv
                             strNumDoc,                                                                                            //  strNumDoc
                             FieldByName('ESPDOC').AsString,                                                                       //  strEspDoc
                             '',                                                                                                   //  strSerie:
                             StrToDateTime(copy(cdsPedidoItem.fieldbyname('DTAPED').AsString,1,2) + '/' +                          //  dtaDtaEnt
                                           copy(cdsPedidoItem.fieldbyname('DTAPED').AsString,3,2) + '/' +
                                           copy(cdsPedidoItem.fieldbyname('DTAPED').AsString,5,4)),
                             StrToTime(fieldbyname('HORPED').AsString),                                                            //  dtaHorEnt
                             fRetConPagCodCnd(strCodCnd),                                                                          //  strConPag
                             '',                                                                                                   //  strEstado
                             strDescri,                                                                                            //  strDescri
                             qryGenerica.fieldbyname('REFERE').AsString,                                                           //  strRefere
                             qryGenerica.fieldbyname('CODUNI').AsString,                                                           //  strUnidad
                             qryGenerica.fieldbyname('CODFOR').AsString,                                                           //  strForIte
                             cdsPedidoItem.fieldbyname('QTDITE').AsFloat,                                                          //  fltQtdIte
                             cdsPedidoItem.fieldbyname('UNITAR').AsFloat,                                                          //  fltUnitar
                             cdsPedidoItem.fieldbyname('UNIORI').AsFloat,                                                          //  fltUniOri
                             cdsPedidoItem.fieldbyname('UNIORI').AsFloat,                                                          //  fltUniVis
                             cdsPedidoItem.fieldbyname('TOTITE').AsFloat,                                                          //  fltTotIte
                             cdsPedidoItem.fieldbyname('TOTITE').AsFloat,                                                          //  fltVlrCon
                             qryGenerica.fieldbyname('PRECUS').AsFloat * cdsPedidoItem.fieldbyname('QTDITE').AsFloat,              //  fltTotCus
                             qryGenerica.fieldbyname('PREMED').AsFloat * cdsPedidoItem.fieldbyname('QTDITE').AsFloat,              //  fltTotMed
                             cdsPedidoItem.FieldByName('DESCON').AsFloat,                                                          //  fltDesCon
                             0.0,                                                                                                  //  fltTotFre
                             0.0,                                                                                                  //  fltDesEsp
                             0.0,                                                                                                  //  fltDesAce
                             '',                                                                                                   //  strCodRep
                             '',                                                                                                   //  strCodVe2
                             qryGenerica.fieldbyname('COMVAR').AsFloat,                                                            //  fltPerCom
                             (cdsPedidoItem.fieldbyname('TOTITE').AsFloat / 100) * qryGenerica.fieldbyname('COMVAR').AsFloat,      //  fltTotCom
                             0.0,                                                                                                  //  fltTotCo2
                             '',                                                                                                   //  strClaFis
                             qryGenerica.fieldbyname('CODABF').AsString,                                                           //  strCodFis
                             0.0,                                                                                                  //  fltValIpi
                             0.0,                                                                                                  //  fltAlqIpi
                             0.0,                                                                                                  //  fltBasIpi
                             0.0,                                                                                                  //  fltValIcm
                             0.0,                                                                                                  //  fltAlqIcm
                             0.0,                                                                                                  //  fltBasIcm
                             0.0,                                                                                                  //  fltValRet
                             0.0,                                                                                                  //  fltAlqRet
                             0.0,                                                                                                  //  fltBasRet
                             qryGenerica.fieldbyname('PESOIT').AsFloat * cdsPedidoItem.fieldbyname('QTDITE').AsFloat,              //  fltTotPes
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
                             strCodCnd,                                                                                            //  strCodCnd
                             '',                                                                                                   //  strProEmb
                             strCodFpg,                                                                                            //  strCodFpg
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
                             intSeqInc,                                                                                            //  intSeqInd
                             0.0,                                                                                                  //  fltQtdBai
                             cdsPedidoItem.fieldbyname('UNIORI').AsFloat,                                                          //  fltUniDig
                             '',                                                                                                   //  strComple
                             0.0,                                                                                                  //  fltVolPro
                             '',                                                                                                   //  strCodAca
                             '',                                                                                                   //  strEmpAca
                             False,                                                                                                //  blnProAca
                             '',                                                                                                   //  strTabPre
                             '',                                                                                                   //  strLinha:
                             '',                                                                                                   //  strCatali
                             '',                                                                                                   //  strCodDil
                             0.0,                                                                                                  //  fltPorDil
                             '',                                                                                                   //  strDilCon
                             0.0,                                                                                                  //  fltPorCat
                             'E',                                                                                                  //  strEntRet
                             '',                                                                                                   //  strLocRet
                             'N',                                                                                                  //  strEntFut
                             '',                                                                                                   //  strMotFut
                             0,                                                                                                    //  dtaDtaFut
                             qryGenerica.fieldbyname('PRECUS').AsFloat * cdsPedidoItem.fieldbyname('QTDITE').AsFloat,
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
                             0);

                If (blnSepSal) And (strComSal = 'N') Then
                Begin
                  With cdsPedidoItem Do
                  Begin
                    pGravaInconsistenciasSaldos(StrToDateTime(copy(fieldbyname('DTAPED').AsString,1,2) + '/' +
                                                              copy(fieldbyname('DTAPED').AsString,3,2) + '/' +
                                                              copy(fieldbyname('DTAPED').AsString,5,4)),
                                                strNumDoc,
                                                FieldByName('ESPDOC').AsString,
                                                VS_strCodEmp,
                                                strCodCli,
                                                fRetNomCliente(strCodCli),
                                                FieldByName('CODITE').AsString,
                                                fRetNomProduto(FieldByName('CODITE').AsString),
                                                fRetSiglaUnidade(fRetUnidadeItem(FieldByName('CODITE').AsString)),
                                                FieldByName('QTDITE').AsFloat,
                                                FieldByName('UNITAR').AsFloat,
                                                FieldByName('TOTITE').AsFloat);

                  End;
                End;
              End
              Else
              Begin
                pGravaInconsistencia(fieldbyname('NOMARQ').AsString,
                                     'Item inválido!',
                                     'ITEM: ' + cdsPedidoItem.fieldbyname('CODITE').AsString,
                                     fieldbyname('NUMDOC').AsString);
              End;

              cdsPedidoItem.Next;

            End;

            {**********************************************************************}
            {* SE NESSE MOMENTO ESSA VARIAVEL AINDA ESTIVER TRUE                  *}
            {* SIGNIFICA QUE NENHUM ITEM VALIDO FOI ENCONTRADO PARA O PEDIDO      *}
            {* SENAO ATUALIZA O REGISTRO DO PEDIDO NA TABELA FATGOR COM OS TOTAIS *}
            {*******************************************************************LU*}
            If Not blnInsere Then
            Begin
              strSQL := '';
              strSQL := strSQL + ' UPDATE ';
              strSQL := strSQL + '   FATGOR ';
              strSQL := strSQL + ' SET ';
              strSQL := strSQL + '   FGO_VLRCON = :VLRCON, ';
              strSQL := strSQL + '   FGO_TOTPRO = :TOTPRO, ';
              strSQL := strSQL + '   FGO_TOTCUS = :TOTCUS, ';
              strSQL := strSQL + '   FGO_TOTMED = :TOTMED ';
              strSQL := strSQL + ' WHERE ';
              strSQL := strSQL + '   FGO_NUMDOC = :NUMDOC AND ';
              strSQL := strSQL + '   FGO_ESPDOC = :ESPDOC AND ';
              strSQL := strSQL + '   FGO_CODEMP = :CODEMP ';

              With qryGenerica Do
              Begin
                Close;
                SQL.Clear;
                SQL.Add(strSQL);
                ParamByName('NUMDOC').AsString := strNumDoc;
                ParamByName('ESPDOC').AsString := cdsPedido.FieldByName('ESPDOC').AsString;
                ParamByName('CODEMP').AsString := strCodEmp;
                ParamByName('VLRCON').AsFloat  := fltTotGer;
                ParamByName('TOTPRO').AsFloat  := fltTotGer;
                ParamByName('TOTCUS').AsFloat  := fltTotCus;
                ParamByName('TOTMED').AsFloat  := fltTotMed;
                ExecSQL;
              End;

              {*****************************************************************}
              {* RENOMEIA O ARQUIVO E MOVE PARA A PASTA DE ARQUIVOS IMPORTADOS *}
              {**************************************************************LU*}
              If (SysUtils.FindFirst(strPath + '\' + cdsPedidoItem.FieldByName('NOMARQ').AsString, faAnyFile, srcArquivos) = 0) Then
              Begin
                fRenomearArquivo(strPath + '\' + cdsPedidoItem.FieldByName('NOMARQ').AsString, fCfgSis('PEDACA') + '\' + cdsPedidoItem.FieldByName('NOMARQ').AsString + '.OLD');
                DeleteFile(strPath + '\' + cdsPedidoItem.FieldByName('NOMARQ').AsString);
              End;

            End;

          End;

        End
        Else
        Begin
          pGravaInconsistencia(fieldbyname('NOMARQ').AsString,
                               'Cliente e/ou Vendedor Inválido!',
                               'VEN: ' + fieldbyname('CODVEN').AsString,
                               fieldbyname('NUMDOC').AsString);
        End;
      End
      Else
      Begin
        pGravaInconsistencia(fieldbyname('NOMARQ').AsString,
                             'Pedido já cadastrado!',
                             'VEN: ' + fieldbyname('CODVEN').AsString,
                             fieldbyname('NUMDOC').AsString);
      End;

      Next;

    End;

  End;
end;

procedure TfrmTxtACACIAServerImpAndroid.pGrava_Telefone;
  Var
    strSQL : String;
begin

  With cdsTelefone Do
  Begin

    First;

    While Not Eof Do
    Begin
      Application.ProcessMessages;
      {*****************************************}
      {* ATUALIZA SOMENTE SE O CLIENTE EXISTIR *}
      {**************************************LU*}
      If fValidaCliente(fieldbyname('CODCLI').AsString) Then
      Begin
        strSQL := '';
        strSQL := strSQL + ' UPDATE ';
        strSQL := strSQL + '   CADCLI ';
        strSQL := strSQL + ' SET ';
        strSQL := strSQL + '   CLI_FONE01 = :FONE01, ';
        strSQL := strSQL + '   CLI_EMAIL_ = :EMAIL_, ';
        strSQL := strSQL + '   CLI_CODATI = :CODATI  ';
        strSQL := strSQL + ' WHERE ';
        strSQL := strSQL + '   CLI_CODCLI = :CODCLI ';

        qryUpdate.Close;
        qryUpdate.SQL.Clear;
        qryUpdate.SQL.Add(strSQL);
        qryUpdate.ParamByName('CODCLI').AsString := trim(fieldbyname('CODCLI').AsString);
        qryUpdate.ParamByName('FONE01').AsString := trim(fieldbyname('FONE01').AsString);
        qryUpdate.ParamByName('EMAIL_').AsString := trim(fieldbyname('EMAIL_').AsString);

        {**********************************************}
        {* VERIFICA SE O CODIGO DA ATIVIDADE É VALIDO *}
        {*******************************************LU*}
        If fValidaAtividade(trim(fieldbyname('CODATI').AsString)) Then
        Begin
          qryUpdate.ParamByName('CODATI').AsString := trim(fieldbyname('CODATI').AsString);
          qryUpdate.ExecSQL;
        End
        Else
        Begin
          pGravaInconsistencia(FieldByName('NOMARQ').AsString,
                               'Atividade do cliente não cadastrada!',
                               'CLI: ' + fieldbyname('CODCLI').AsString,
                               EmptyStr);
        End;

      End
      Else
      Begin
        pGravaInconsistencia(fieldbyname('NOMARQ').AsString,
                             'Cliente não cadastrado!',
                             'CLI: ' + fieldbyname('CODCLI').AsString,
                             EmptyStr);      
      End;

      Next;
    End;

  End;

end;

procedure TfrmTxtACACIAServerImpAndroid.pImp_ItensPedido(strNomArq: String);
  Var
    lstArquivo : TStringList;
    intContador: Integer;
    intPosBarra: Integer;
    strLinha   : String;
    strNumDoc  : String;
    strDtaPed  : String;
    strCodCli  : String;
    fltQtdIte  : Double;
    fltUnitar  : Double;
    fltTotImp  : Double;
    strCodite  : String;
    blnInsere  : Boolean;
    fltUniOri  : Double;
    fltDesCon  : Double;
    strCodEmp  : String;
begin
  lstArquivo := TStringList.Create;

  lstArquivo.LoadFromFile(strPath + '\' + strNomArq);

  For intContador := 0 to lstArquivo.Count -1 do
  Begin
    Application.ProcessMessages;

    strLinha    := lstArquivo.Strings[intContador];
    intPosBarra := Pos('|', strLinha);

    strNumDoc := Copy(strLinha, 1, intPosBarra - 1); // posicao 1 do arquivo

    With cdsPedido Do
    Begin
      Filtered := False;
      Filter   := 'NUMDOC = ' + QuotedStr(strNumDoc);
      Filtered := True;

      strCodEmp := Trim(FieldByName('CODEMP').AsString);

      Filtered := False;
    End;

    Delete(strLinha, 1, intPosBarra); // apaga a posicao 1
    intPosBarra := Pos('|',strLinha);
    Delete(strLinha, 1, intPosBarra); // apaga a posicao 2
    intPosBarra := Pos('|',strLinha);

    strDtaPed := Copy(strLinha, 1, intPosBarra - 1); // posicao 3 do arquivo

    Delete(strLinha, 1, intPosBarra); // apaga a posicao 3
    intPosBarra := Pos('|',strLinha);
    Delete(strLinha, 1, intPosBarra); // apaga a posicao 4
    intPosBarra := Pos('|',strLinha);

    strCodCli := Copy(strLinha, 1, intPosBarra - 1); // posicao 5 do arquivo

    Delete(strLinha, 1, intPosBarra); // apaga a posicao 5
    intPosBarra := Pos('|',strLinha);
    Delete(strLinha, 1, intPosBarra); // apaga a posicao 6
    intPosBarra := Pos('|',strLinha);
    Delete(strLinha, 1, intPosBarra); // apaga a posicao 7
    intPosBarra := Pos('|',strLinha);

    strCodite := Copy(strLinha, 1, intPosBarra - 1);  // posicao 8 do arquivo


    {*****************************************}
    {* CALCULA A QUANTIDADE TOTAL QUE JA FOI *}
    {* IMPORTADA DO PRODUTO                  *}
    {**************************************JC*}
    With cdsPedidoItem Do
    Begin
      Filter    := 'CODITE = ' + QuotedStr(Trim(RightStr(strCodite,fTamCodIte)));
      Filtered  := True;

      If Not IsEmpty Then
        fltTotImp := TAggregateField(cdsPedidoItem.FieldByName('TOT_QTDITE')).Value
      Else
        fltTotImp := 0.0;

      Filtered  := False;
    End;

    cdsPedidoItem.Append;
    cdsPedidoItem.FieldByName('CODITE').AsString := Trim(RightStr(strCodite,fTamCodIte));
    cdsPedidoItem.FieldByName('NOMARQ').AsString := strNomArq; // nome do arquivo
    cdsPedidoItem.FieldByName('NUMDOC').AsString := strNumDoc;
    cdsPedidoItem.FieldByName('DTAPED').AsString := strDtaPed;
    cdsPedidoItem.FieldByName('CODCLI').AsString := strCodCli;
    cdsPedidoItem.FieldByName('SALDOS').AsString := 'S';
    cdsPedidoItem.FieldByName('CODEMP').AsString := strCodEmp;

    If Not fExisteItem(cdsPedidoItem.FieldByName('CODITE').AsString) Then
    Begin
      pGravaInconsistencia(strNomArq,
                           'Item não existe.',
                           'ITE: ' + cdsPedidoItem.FieldByName('CODITE').AsString,
                           cdsPedidoItem.FieldByName('NUMDOC').AsString);

      cdsPedidoItem.Cancel;
    End
    Else
    Begin

      Delete(strLinha, 1, intPosBarra); // apaga a posicao 8
      intPosBarra := Pos('|',strLinha);
      Delete(strLinha, 1, intPosBarra); // apaga a posicao 9
      intPosBarra := Pos('|',strLinha);

      cdsPedidoItem.FieldByName('CODPAG').AsString := Copy(strLinha, 1, intPosBarra - 1); // posicao 10 do arquivo

      Delete(strLinha, 1, intPosBarra); // apaga a posicao 10
      intPosBarra := Pos('|',strLinha);
      Delete(strLinha, 1, intPosBarra); // apaga a posicao 11
      intPosBarra := Pos('|',strLinha);
      Delete(strLinha, 1, intPosBarra); // apaga a posicao 12
      intPosBarra := Pos('|',strLinha);
      Delete(strLinha, 1, intPosBarra); // apaga a posicao 13
      intPosBarra := Pos('|',strLinha);

      fltQtdIte := fStrToFloat(AnsiReplaceStr(Copy(strLinha, 1, intPosBarra - 1),'.',',')); // posicao 14 do arquivo

      {****************************************************}
      {* CASO O ITEM NAO POSSUA QUANTIDADE IGNORA O MESMO *}
      {*************************************************JC*}
      If (fltQtdIte <= 0) Then
        cdsPedidoItem.Cancel
      Else
      Begin

        blnInsere := True;

        {************************************************}
        {* CASO O ITEM NAO POSSUA "SALDO" PARA O PEDIDO *}
        {* GRAVA INCOSISTENCIA DE SALDOS DO MESMO       *}
        {*********************************************JC*}
        If (Not blnSepararItensCom_e_SemSaldo) And
           (Not fVerificaSaldo(cdsPedidoItem.FieldByName('CODITE').AsString, fltTotImp + fltQtdIte)) Then
        Begin
          {**************************************************************************}
          {* SOMENTE ADICIONAR NO PEDIDO QUANDO TIVER SALDO, RESPEITAR CONFIGURACAO *}
          {***********************************************************************PH*}
          pGravaInconsistencia(strNomArq,
                               'Sem saldo.',
                               'ITE: ' + cdsPedidoItem.FieldByName('CODITE').AsString,
                               cdsPedidoItem.FieldByName('NUMDOC').AsString);

          {*******************************************}
          {* CASO ESTAJA CONFIGURADO PARA NAO INSERIR*}
          {* PRODUTO SEM SALDO, NAO O FAZ...         *}
          {****************************************JC*}
          If fCfgSis('DELACA', varBoolean) Then
          Begin
            cdsPedidoItem.Cancel;
            blnInsere := False;
          End
          Else
          Begin
            {*******************************************}
            {* MARCA O ITEM QUE NÃO POSSUI SALDO DISP. *}
            {****************************************PZ*}
            cdsPedidoItem.FieldByName('SALDOS').AsString := 'N';
          End;

        End;

        {****************************************************}
        {* CASO ESTAJA TUDO "OK" COM O ITEM, INSERE O MESMO *}
        {*************************************************JC*}
        If blnInsere Then
        Begin
          cdsPedidoItem.FieldByName('QTDITE').AsFloat := fltQtdIte;

          Delete(strLinha, 1, intPosBarra); // apaga a posicao 14
          intPosBarra := Pos('|',strLinha);
          Delete(strLinha, 1, intPosBarra); // apaga a posicao 15
          intPosBarra := Pos('|',strLinha);

          fltUnitar := fStrToFloat(AnsiReplaceStr(Copy(strLinha, 1, intPosBarra - 1),'.',',')); // posicao 16 do arquivo
          cdsPedidoItem.FieldByName('UNITAR').AsFloat := fltUnitar;

          Delete(strLinha, 1, intPosBarra); // apaga a posicao 16
          intPosBarra := Pos('|',strLinha);

          fltUniOri := fStrToFloat(AnsiReplaceStr(Copy(strLinha, 1, intPosBarra - 1),'.',',')); // posicao 17 do arquivo
          cdsPedidoItem.FieldByName('UNIORI').AsFloat := fltUniOri;

          Delete(strLinha, 1, intPosBarra); // apaga a posicao 17
          intPosBarra := Pos('|',strLinha);

          fltDesCon := fStrToFloat(AnsiReplaceStr(Copy(strLinha, 1, intPosBarra - 1),'.',',')); // posicao 18 do arquivo
          cdsPedidoItem.FieldByName('DESCON').AsFloat := fltDesCon;

          Delete(strLinha, 1, intPosBarra); // apaga a posicao 18
          intPosBarra := Pos('|',strLinha);
          Delete(strLinha, 1, intPosBarra); // apaga a posicao 19
          intPosBarra := Pos('|',strLinha);
          Delete(strLinha, 1, intPosBarra); // apaga a posicao 20
          intPosBarra := Pos('|',strLinha);

          cdsPedidoItem.FieldByName('TOTITE').AsFloat := fltQtdIte * fltUnitar;

          Delete(strLinha, 1, intPosBarra); // apaga a posicao 21
          intPosBarra := Pos('|',strLinha);
          Delete(strLinha, 1, intPosBarra); // apaga a posicao 22
          intPosBarra := Pos('|',strLinha);
          Delete(strLinha, 1, intPosBarra); // apaga a posicao 23
          intPosBarra := Pos('|',strLinha);

          If intPosBarra = 0 Then
            intPosBarra := Length(strLinha) + 1;

          cdsPedidoItem.FieldByName('CODVEN').AsString := Copy(strLinha, 1, intPosBarra - 1); // posicao 24 do arquivo

          cdsPedidoItem.Post;
        End;

      End;

    End;

  End;

  FreeAndNil(lstArquivo);
end;

procedure TfrmTxtACACIAServerImpAndroid.pImp_Pedido(strNomArq: String);
  Var
    lstArquivo : TStringList;
    intContador: Integer;
    intPosBarra: Integer;
    strLinha   : String;
    strCodCnd  : String;
    strTabPre  : String;
begin
  lstArquivo := TStringList.Create;

  lstArquivo.LoadFromFile(strPath + '\' + strNomArq);

  For intContador := 0 to lstArquivo.Count -1 do
  Begin
    Application.ProcessMessages;
    cdsPedido.Append;

    strLinha    := lstArquivo.Strings[intContador];
    intPosBarra := Pos('|', strLinha);

    cdsPedido.FieldByName('NOMARQ').AsString := strNomArq; // nome do arquivo

    cdsPedido.FieldByName('NUMDOC').AsString := Copy(strLinha, 1, intPosBarra - 1); // posicao 1 do arquivo

    Delete(strLinha, 1, intPosBarra); // apaga a posicao 1
    intPosBarra := Pos('|',strLinha);
    Delete(strLinha, 1, intPosBarra); // apaga a posicao 2
    intPosBarra := Pos('|',strLinha);

    cdsPedido.FieldByName('DTAPED').AsString := Copy(strLinha, 1, intPosBarra - 1); // posicao 3 do arquivo

    Delete(strLinha, 1, intPosBarra); // apaga a posicao 3
    intPosBarra := Pos('|',strLinha);

    cdsPedido.FieldByName('HORPED').AsString := Copy(strLinha, 1, intPosBarra - 1); // posicao 4 do arquivo

    Delete(strLinha, 1, intPosBarra); // apaga a posicao 4
    intPosBarra := Pos('|',strLinha);
    Delete(strLinha, 1, intPosBarra); // apaga a posicao 5
    intPosBarra := Pos('|',strLinha);
    Delete(strLinha, 1, intPosBarra); // apaga a posicao 6
    intPosBarra := Pos('|',strLinha);
    Delete(strLinha, 1, intPosBarra); // apaga a posicao 7
    intPosBarra := Pos('|',strLinha);

    cdsPedido.FieldByName('CODCLI').AsString := Copy(strLinha, 1, intPosBarra - 1); // posicao 8 do arquivo

    Delete(strLinha, 1, intPosBarra); // apaga a posicao 8
    intPosBarra := Pos('|',strLinha);

    cdsPedido.FieldByName('SERDOC').AsString := Copy(strLinha, 1, intPosBarra - 1); // posicao 9 do arquivo

    Delete(strLinha, 1, intPosBarra); // apaga a posicao 9
    intPosBarra := Pos('|',strLinha);

    strCodCnd := Copy(strLinha, 1, intPosBarra - 1);
    cdsPedido.FieldByName('CODPAG').AsString := Trim(RightStr(strCodCnd,3)); // posicao 10 do arquivo

    Delete(strLinha, 1, intPosBarra); // apaga a posicao 10
    intPosBarra := Pos('|',strLinha);

    cdsPedido.FieldByName('FORPAG').AsString := Copy(strLinha, 1, intPosBarra - 1); // posicao 11 do arquivo

    Delete(strLinha, 1, intPosBarra); // apaga a posicao 11
    intPosBarra := Pos('|',strLinha);

    If (fCfgSis('MODACA') = '2') Then
      cdsPedido.FieldByName('CODUNI').AsString := Copy(strLinha, 1, intPosBarra - 1); // posicao 12 do arquivo

    Delete(strLinha, 1, intPosBarra); // apaga a posicao 12
    intPosBarra := Pos('|',strLinha);

    Delete(strLinha, 1, intPosBarra); // apaga a posicao 13
    intPosBarra := Pos('|',strLinha);

    cdsPedido.FieldByName('CODEMP').AsString := Copy(strLinha, 1, intPosBarra - 1); // posicao 14 do arquivo
    Delete(strLinha, 1, intPosBarra); // apaga a posicao 14
    intPosBarra := Pos('|',strLinha);
    
    Delete(strLinha, 1, intPosBarra); // apaga a posicao 15
    intPosBarra := Pos('|',strLinha);

    strTabPre := Copy(strLinha, 1, intPosBarra - 1);
    cdsPedido.FieldByName('TIPTAB').AsString := Trim(RightStr(strTabPre,1)); // posicao 16 do arquivo

    Delete(strLinha, 1, intPosBarra); // apaga a posicao 16
    intPosBarra := Pos('|',strLinha);
    Delete(strLinha, 1, intPosBarra); // apaga a posicao 17
    intPosBarra := Pos('|',strLinha);
    Delete(strLinha, 1, intPosBarra); // apaga a posicao 18
    intPosBarra := Pos('|',strLinha);
    Delete(strLinha, 1, intPosBarra); // apaga a posicao 19
    intPosBarra := Pos('|',strLinha);

    cdsPedido.FieldByName('OBS001').AsString := Copy(strLinha, 1, intPosBarra - 1); // posicao 20 do arquivo

    Delete(strLinha, 1, intPosBarra); // apaga a posicao 20
    intPosBarra := Pos('|',strLinha);
    Delete(strLinha, 1, intPosBarra); // apaga a posicao 21
    intPosBarra := Pos('|',strLinha);
    Delete(strLinha, 1, intPosBarra); // apaga a posicao 22
    intPosBarra := Pos('|',strLinha);
    Delete(strLinha, 1, intPosBarra); // apaga a posicao 23
    intPosBarra := Pos('|',strLinha);

    cdsPedido.FieldByName('OBS002').AsString := Copy(strLinha, 1, intPosBarra - 1); // posicao 24 do arquivo

    Delete(strLinha, 1, intPosBarra); // apaga a posicao 24
    intPosBarra := Pos('|',strLinha);
    Delete(strLinha, 1, intPosBarra); // apaga a posicao 25
    intPosBarra := Pos('|',strLinha);
    Delete(strLinha, 1, intPosBarra); // apaga a posicao 26
    intPosBarra := Pos('|',strLinha);
    Delete(strLinha, 1, intPosBarra); // apaga a posicao 27
    intPosBarra := Pos('|',strLinha);
    Delete(strLinha, 1, intPosBarra); // apaga a posicao 28
    intPosBarra := Pos('|',strLinha);
    Delete(strLinha, 1, intPosBarra); // apaga a posicao 29
    intPosBarra := Pos('|',strLinha);
    Delete(strLinha, 1, intPosBarra); // apaga a posicao 30
    intPosBarra := Pos('|',strLinha);

    If intPosBarra = 0 Then
      intPosBarra := Length(strLinha) + 1;    

    cdsPedido.FieldByName('CODVEN').AsString := Copy(strLinha, 1, intPosBarra - 1); // posicao 31 do arquivo

    Delete(strLinha, 1, intPosBarra); // apaga a posicao 31
    intPosBarra := Pos('|',strLinha);
    Delete(strLinha, 1, intPosBarra); // apaga a posicao 32
    intPosBarra := Pos('|',strLinha);
    Delete(strLinha, 1, intPosBarra); // apaga a posicao 33
    intPosBarra := Pos('|',strLinha);
    Delete(strLinha, 1, intPosBarra); // apaga a posicao 34
    intPosBarra := Pos('|',strLinha);
    Delete(strLinha, 1, intPosBarra); // apaga a posicao 35
    intPosBarra := Pos('|',strLinha);

    If intPosBarra = 0 Then
      intPosBarra := Length(strLinha) + 1;

    cdsPedido.FieldByName('ESPDOC').AsString := Copy(strLinha, 1, intPosBarra - 1); // posicao 36 do arquivo

    cdsPedido.Post;

  End;

  FreeAndNil(lstArquivo);
end;

procedure TfrmTxtACACIAServerImpAndroid.pImp_Telefone(strNomArq: String);
  Var
    lstArquivo : TStringList;
    intContador: Integer;
    intPosBarra: Integer;
    strLinha   : String;
    strTelefone: String;
begin
  lstArquivo := TStringList.Create;

  lstArquivo.LoadFromFile(strPath + '\' + strNomArq);

  For intContador := 0 to lstArquivo.Count -1 do
  Begin
    Application.ProcessMessages;
    cdsTelefone.Append;

    strLinha    := lstArquivo.Strings[intContador];
    intPosBarra := Pos('|', strLinha);

    cdsTelefone.FieldByName('NOMARQ').AsString := strNomArq; // nome do arquivo

    cdsTelefone.FieldByName('CODCLI').AsString := Copy(strLinha, 1, intPosBarra - 1); // posicao 1 do arquivo

    Delete(strLinha, 1, intPosBarra); // apaga a posicao 1
    intPosBarra := Pos('|',strLinha);

    strTelefone := AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(Copy(strLinha, 1, intPosBarra - 1),')',''),'(',''),'-',''),'.','');
    cdsTelefone.FieldByName('FONE01').AsString := strTelefone; // posicao 2 do arquivo

    Delete(strLinha, 1, intPosBarra); // apaga a posicao 2
    intPosBarra := Pos('|',strLinha);

    cdsTelefone.FieldByName('EMAIL_').AsString := Copy(strLinha, 1, intPosBarra - 1); // posicao 3 do arquivo

    Delete(strLinha, 1, intPosBarra); // apaga a posicao 3
    intPosBarra := Pos('|',strLinha);

    cdsTelefone.FieldByName('CODATI').AsString := Copy(strLinha, 1, intPosBarra - 1); // posicao 4 do arquivo

    cdsTelefone.Post;

  End;

  FreeAndNil(lstArquivo);

end;

procedure TfrmTxtACACIAServerImpAndroid.pSepararProdutosCom_e_SemSaldo;
  var
    cdsTemp: TUniClientDataSet;
    dicQtdImp: TDicionario;
    fltQtdPed, fltSaldo: Double;
    strCodIte: String;

  procedure pInsereItem(fltQtdIte: Double; strComSal: String);
    Var
      intIndex: Integer;
  begin
    cdsTemp.Append;

    For intIndex := 0 To cdsPedidoItem.Fields.Count -1 Do
      cdsTemp.Fields[intIndex].Value := cdsPedidoItem.Fields[intIndex].Value;

    cdsTemp.FieldByName('QTDITE').AsFloat  := fltQtdIte;
    cdsTemp.FieldByName('SALDOS').AsString := strComSal;
    cdsTemp.FieldByName('TOTITE').AsFloat  := fltQtdIte * cdsTemp.FieldByName('UNITAR').AsFloat;

    cdsTemp.Post;
  end;

begin
  {****************************************************************}
  {* CRIA UM CLIENTDATASET COM A MESMA ESTRUTURA DO cdsPedidoItem *}
  {*************************************************************JC*}
  cdsTemp := TUniClientDataSet.Create(Self);
  cdsTemp.Data := cdsPedidoItem.Data;
  cdsTemp.EmptyDataSet;

  dicQtdImp := TDicionario.Create;

  With cdsPedidoItem Do
  Begin
    First;

    While Not Eof Do
    Begin
      strCodIte := FieldByName('CODITE').AsString;
      fltQtdPed := FieldByName('QTDITE').AsFloat;
      fltSaldo  := fRetornaSaldoDisponivel(strCodIte) - IfNull(dicQtdImp[strCodIte], 0); // Subtrai a Qtd ja importada

      If fltSaldo < 0 Then
        fltSaldo := 0;

      If fltQtdPed <= fltSaldo Then
      Begin
        pInsereItem(fltQtdPed, 'S');
        dicQtdImp[strCodIte] := IfNull(dicQtdImp[strCodIte], 0) + fltQtdPed;
      End
      Else
      Begin
        pGravaInconsistencia(FieldByName('NOMARQ').AsString,
                             'Sem saldo.',
                             'ITE: ' + FieldByName('CODITE').AsString,
                             FieldByName('NUMDOC').AsString);

        If fltSaldo > 0 Then
        Begin
          pInsereItem(fltSaldo, 'S');
          dicQtdImp[strCodIte] := IfNull(dicQtdImp[strCodIte], 0) + fltSaldo;
        End;

        pInsereItem(fltQtdPed - fltSaldo, 'N');
      End;

      Next;
    End;

    Data := cdsTemp.Data;
  End;

  FreeAndNil(dicQtdImp);
  FreeAndNil(cdsTemp);
  
end;

procedure TfrmTxtACACIAServerImpAndroid.tmrFechaTimer(Sender: TObject);
begin
  inherited;
  If blnGerou Then
    Self.Close;
end;

end.

