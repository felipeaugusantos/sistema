unit untGeoSales;

interface

uses

  (* -- Classes que Serão importadas para o Array de arquivos de Exportação --*)
  untGeoSale_Base,
  untGeoSale_Cliente,
  untGeoSale_Organizacao_Venda,
  untGeoSale_Vendedor,
  untGeoSale_Tabela_Preco,
  untGeoSale_Grupo_mpgto,
  untGeoSale_Item_Grupo_mpgto,
  untGeoSale_Org_venda_cliente,
  untGeoSale_Grupo_Mpgto_Org,
  untGeoSale_Grupo_Condicao_Pagamento,
  untGeoSale_Grupo_Meio_Pagamento,
  untGeoSale_Fornecedor,
  untGeoSale_Familia_Produto,
  untGeoSale_Produto,
  untGeoSale_Sequencial,
  untGeoSale_Lista_Produto,
  untGeoSale_Titulo,
  untGeoSale_Produto_Estoque,
  untGeoSale_Estoque,
  untGeoSale_Faixa_Preco_Produto,
  untGeoSale_Transp_Cliente,
  untGeoSale_Transportadora,
  untGeoSale_Pedido,
  untGeoSale_Item_Pedido,
  untGeoSale_Desconto_Cliente,

  (* -- FIM -- *)

  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass, System.StrUtils,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters,
  cxClasses, dxGaugeCustomScale, dxGaugeQuantitativeScale, dxGaugeCircularScale,
  dxGaugeControl, cxContainer, cxEdit, cxCheckListBox, Vcl.ImgList,
  cxProgressBar, Data.DB, Uni, EditFocus, untTypesSistema, System.ImageList, Vcl.CheckLst,
  cxCustomListBox;

Type
  TArqExp = Record
    Classe : TGeoSale_BaseClass;
    strArqNam : String;
  End;

  TfrmGeoSales = class(TfrmPai)
    dxGaugeControl: TdxGaugeControl;
    CircularScale: TdxGaugeCircularScale;
    lblArqAtu: TLabel;
    cblArquivos: TcxCheckListBox;
    imgLista: TImageList;
    Bevel1: TBevel;
    lblInicial: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    lblIniExp: TLabel;
    lblDuracao: TLabel;
    lblArqProc: TLabel;
    lblTotArq: TLabel;
    Label8: TLabel;
    lblInform: TLabel;
    btnExporta: TBitBtnLocked;
    tmrDuracao: TTimer;
    pnl2: TPanel;
    mmoLogImp: TMemo;
    pnlProgressoGeral: TPanel;
    lblProgressoGeral: TLabel;
    pgbProgressoGeral: TcxProgressBar;
    pnlProgressoDetalhes: TPanel;
    lblProgressoDetalhes: TLabel;
    pgbProgressoDetalhes: TcxProgressBar;
    pnl4: TPanel;
    pnlEmpresa: TPanel;
    clbEmpresa: TCheckListBox;
    btnPopMenu: TBitBtnLocked;
    popCriaConf: TPopupMenu;
    Gravararquivoparageraoautomtica1: TMenuItem;
    tmrAutomatico: TTimer;
    procedure btnExportaClick(Sender: TObject);
    procedure tmrDuracaoTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Gravararquivoparageraoautomtica1Click(Sender: TObject);
    procedure btnPopMenuClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure tmrAutomaticoTimer(Sender: TObject);
  private
    FHraIni    : TDateTime;
    FAutomatico: Boolean;
    blnExporta : Boolean;

    procedure pImportarDados(strNomDir : String);
    procedure pExportarDados(strNomDir : String);
    Function fGravarDados : Boolean;
    procedure pRegistrarProgresso(strTexto: String; lblInformacao: TLabel;
      pgbProgresso: TCxProgressBar; intInicio, intAtual, intFinal: Integer);
    procedure pRegistraLogImp(strTexto: String);
    function fGetEmpresasSelecionadas: String;
    procedure pCarregarCfg(var strDiretorio : String);
    procedure pContarArquivos;

    Const arrArquivos : Array[0..21] Of TArqExp = ( (Classe: TGeoSale_Cliente                  ; strArqNam: 'Cliente.TXT'),
                                                    (Classe: TGeoSale_Organizacao_Venda        ; strArqNam: 'Organizacao_Venda.TXT'),
                                                    (Classe: TGeoSale_Vendedor                 ; strArqNam: 'Vendedor.TXT'),
                                                    (Classe: TGeoSale_Tabela_Preco             ; strArqNam: 'Tabela_Preco.TXT'),
                                                    (Classe: TGeoSale_Grupo_mpgto              ; strArqNam: 'Grupo_mpgto.TXT'),
                                                    (Classe: TGeoSale_Item_Grupo_mpgto         ; strArqNam: 'Item_Grupo_mpgto.TXT'),
                                                    (Classe: TGeoSale_Org_venda_cliente        ; strArqNam: 'Org_venda_cliente.TXT'),
                                                    (Classe: TGeoSale_Grupo_Mpgto_Org          ; strArqNam: 'Grupo_Mpgto_Org.TXT'),
                                                    (Classe: TGeoSale_Grupo_Condicao_Pagamento ; strArqNam: 'Condicao_Pagamento.TXT'),
                                                    (Classe: TGeoSale_Grupo_Meio_Pagamento     ; strArqNam: 'Meio_Pagamento.TXT'),
                                                    (Classe: TGeoSale_Fornecedor               ; strArqNam: 'Fornecedor.TXT'),
                                                    (Classe: TGeoSale_Familia_Produto          ; strArqNam: 'Familia_Produto.TXT'),
                                                    (Classe: TGeoSale_Produto                  ; strArqNam: 'Produto.TXT'),
                                                    (Classe: TGeoSale_Sequencial               ; strArqNam: 'Sequencial.TXT'),
                                                    (Classe: TGeoSale_Lista_Produto            ; strArqNam: 'Lista_Produto.TXT'),
                                                    (Classe: TGeoSale_Titulo                   ; strArqNam: 'Titulo.TXT'),
                                                    (Classe: TGeoSale_Produto_Estoque          ; strArqNam: 'Produto_Estoque.TXT'),
                                                    (Classe: TGeoSale_Estoque                  ; strArqNam: 'Estoque.TXT'),
                                                    (Classe: TGeoSale_Faixa_Preco_Produto      ; strArqNam: 'Faixa_Preco_Produto.TXT'),
                                                    (Classe: TGeoSale_Transp_Cliente           ; strArqNam: 'Transp_Cliente.TXT'),
                                                    (Classe: TGeoSale_Transportadora           ; strArqNam: 'Transportadora.TXT'),
                                                    (Classe: TGeoSale_Desconto_Cliente         ; strArqNam: 'Desconto_Cliente.TXT')
                                                 );

    Var arrArquivosImp : Array[0..1] Of TArqExp;

  public
    Class Procedure pImporta(blnAutomatico : Boolean = False);
    Class Procedure pExporta(blnAutomatico : Boolean = False);
  end;

implementation

{$R *.dfm}

uses untRTTIEngine, Vcl.FileCtrl, untFuncoesSimples,
  untGeoSalePedidoSingletonCollection, Faturamento.Classes.TEmitirPedido, untRTTILayout,
  untConsultas, untFuncoesConsulta;

procedure TfrmGeoSales.btnExportaClick(Sender: TObject);
  Var
    strNomDir : String;
begin
  strNomDir := 'C:\';
  If Not SelectDirectory(strNomDir, [sdAllowCreate, sdPerformCreate, sdPrompt], 0) Then
    Exit;

  strNomDir := IncludeTrailingPathDelimiter(strNomDir);

  pContarArquivos;

  if Not blnExporta Then
    pImportarDados(strNomDir)
  Else
    pExportarDados(strNomDir);

end;

procedure TfrmGeoSales.pContarArquivos;
  Var
    intIndex  : Integer;
Begin
  lblTotArq.Tag := 0;
  For intIndex := 0 To cblArquivos.Items.Count-1 Do
  Begin
    If cblArquivos.Items[intIndex].State = cbsChecked Then
      lblTotArq.Tag := lblTotArq.Tag + 1;
  End;
  lblTotArq.Caption := IntToStr( lblTotArq.Tag );
End;

procedure TfrmGeoSales.pExportarDados(strNomDir : String);
  Var
    intWait   : Cardinal;
    intHandle : Integer;
    intIndex  : Integer;
    objEngine : TRTTIEngine;
    strEmpresa: String;
Begin
  strEmpresa := fGetEmpresasSelecionadas;
  If fEmptyStr(strEmpresa) Then
  Begin
    fMensagem('ATENÇÃO', 'É obrigatório selecionar pelo menos uma empresa!', ['&OK']);
    Exit;
  End;

  Try
    Self.Enabled := False;
    Screen.Cursor := crHourGlass;

    FHraIni := fNow();
    tmrDuracao.Enabled := True;

    For intIndex := 0 To cblArquivos.Items.Count-1 Do
    Begin
      If cblArquivos.Items[intIndex].State = cbsChecked Then
      Begin
        lblArqAtu.Caption := 'Exportando: ' + arrArquivos[intIndex].strArqNam;

        objEngine := TRTTIEngine.Create(arrArquivos[intIndex].Classe.Create(strNomDir, strEmpresa), lblInform);

        intHandle := objEngine.Handle;

        objEngine.Start;

        Repeat
          intWait:= WaitForSingleObject(intHandle, 0);

          CircularScale.Value := objEngine.fltStatus;
          Application.ProcessMessages;
          Sleep(500);

        Until intWait <> WAIT_TIMEOUT;

        objEngine.Free;

        CircularScale.Value := 0;

        cblArquivos.Items[intIndex].State := cbsUnchecked;

        lblArqProc.Caption := IntToStr(intIndex+1);

      End;

    End;

    tmrDuracao.Enabled := False;
    If not FAutomatico Then
      fMensagem('', 'Fim da Geração!', ['&OK']);
  Finally
    Self.Enabled := True;
    Screen.Cursor := crDefault;
  End;

End;

procedure TfrmGeoSales.pImportarDados(strNomDir : String);
  Var
    intWait   : Cardinal;
    intHandle : Integer;
    intIndex  : Integer;
    objEngine : TRTTIEngine;
Begin
  If (not FileExists( strNomDir + VS_strCodEmp + 'P.TXT')) Then
  Begin
    If Not FAutomatico Then
      fMensagem('','Arquivo "'+ VS_strCodEmp + 'P.TXT" não encontrado no diretório selecionado!', ['OK']);
    Exit;
  End;

  If (not FileExists( strNomDir + VS_strCodEmp + 'I.TXT')) Then
  Begin
    If Not FAutomatico Then
      fMensagem('','Arquivo "' + VS_strCodEmp + 'I.TXT" não encontrado no diretório selecionado!', ['OK']);
    Exit;
  End;

  Try
    Self.Enabled := False;
    Screen.Cursor := crHourGlass;

    cblArquivos.Items.Clear;

    With cblArquivos.Items.Add Do
    Begin
      Text  := 'Pedido';
      State := cbsChecked;
    End;
    With cblArquivos.Items.Add Do
    Begin
      Text  := 'Item Pedido';
      State := cbsChecked;
    End;


    FHraIni := fNow();
    tmrDuracao.Enabled := True;

    For intIndex := 0 To cblArquivos.Items.Count-1 Do
    Begin
      If cblArquivos.Items[intIndex].State = cbsChecked Then
      Begin
        lblArqAtu.Caption := 'Importando: ' + arrArquivosImp[intIndex].strArqNam;

        objEngine := TRTTIEngine.Create(arrArquivosImp[intIndex].Classe.Create(strNomDir, '' ), lblInform);
        intHandle := objEngine.Handle;

        objEngine.Start;

        Repeat
          intWait:= WaitForSingleObject(intHandle, 0);

          CircularScale.Value := objEngine.fltStatus;
          Application.ProcessMessages;
          Sleep(500);

        Until intWait <> WAIT_TIMEOUT;

        objEngine.Free;

        CircularScale.Value := 0;

        cblArquivos.Items[intIndex].State := cbsUnchecked;

        lblArqProc.Caption := IntToStr(intIndex+1);

      End;

    End;

    tmrDuracao.Enabled := False;
    lblArqAtu.Caption   := 'Importando: Iniciando gravação';

    If fGravarDados and FAutomatico Then
    Begin
      RenameFile(strNomDir + VS_strCodEmp + 'P.TXT', strNomDir + VS_strCodEmp + 'P.IMP');
      RenameFile(strNomDir + VS_strCodEmp + 'I.TXT', strNomDir + VS_strCodEmp + 'P.IMP');
    End;

    If Not FAutomatico Then
      fMensagem('', 'Fim da Geração!', ['&OK']);

  Finally
    Self.Enabled := True;
    Screen.Cursor := crDefault;
  End;
End;


function TfrmGeoSales.fGravarDados : Boolean;
  Var
    objPedidoAux : TPedidoAux;
    objItens     : TGeoSale_Item_Pedido;

    dadosItem: TDadosProduto;
    dadosPedido: TDadosPedido;
    objEmitirPedido: TEmitirPedido;

    intQtdPedido : Integer;
    intQtdItens  : Integer;
    fltDesEspL   : Double;
    intTamCodIte : Integer;

  function fVerificaPedidoExistente : Boolean;
    Var
      qryConsulta : TUniQuery;
  Begin
    Try
      qryConsulta := fCriaQuery(Self);
      With qryConsulta, SQL Do
      Begin
        Add(' SELECT *                   ');
        Add(' FROM FATGOR                ');
        Add(' WHERE FGO_NUMPOK = :NUMPOK ');
        Add('   AND FGO_CODEMP = :CODEMP ');

        ParamByName('NUMPOK').AsString := dadosPedido.strNumPok;
        ParamByName('CODEMP').AsString := VS_strCodEmp;

        Open;

        Result := IsEmpty;

        If Not Result Then
        Begin
          pRegistraLogImp('O pedido ' + dadosPedido.strNumPok + ' já esta importado com o numero: ' + FieldByName('FGO_NUMDOC').AsString +
                          ' Cliente: ' + FieldByName('FGO_CODCLI').AsString + ' - ' + fRetNomCliente(FieldByName('FGO_CODCLI').AsString) );

        End;


      End;
    Finally
      FreeAndNil(qryConsulta);
    End;




  End;

Begin
  Result := True;
  intQtdPedido := 0;
  For objPedidoAux in TGeoSalePedidoSingletonCollection.Instance.lstPedido.Values Do
  Begin
    Inc(intQtdPedido);

    With objPedidoAux, objPedido Do
    Begin

      pRegistrarProgresso('Aguarde, Gravando Pedidos...', lblProgressoGeral, pgbProgressoGeral, 0, intQtdPedido, TGeoSalePedidoSingletonCollection.Instance.lstPedido.Count);

      objEmitirPedido := TEmitirPedido.Create(Self);

      objEmitirPedido.mmoInformacao := mmoLogImp;
      objEmitirPedido.lblInformacao := lblProgressoDetalhes;
      objEmitirPedido.pgbProgresso  := pgbProgressoDetalhes;

      fltDesEspL := 0;
      For objItens in lstItens Do
        fltDesEspL := fltDesEspL + (objItens.VR_ITEM * objItens.PC_DESCONTO / 100);

      With dadosPedido Do
      Begin
        strCodCli := fStrZero(IntToStr(CD_CLIENTE), 8 );
        strCodVen := fStrZero(IntToStr(CD_VENDEDOR), 3 );

        If fCfgSis('USADIG', varBoolean) Then
          strCodDig := fStrZero(IntToStr(CD_VENDEDOR), 3 )
        Else
          strCodDig := strLoginUsuarioLogado;

        strConPag := fRetConPag( fStrZero(IntToStr(CD_COND_PGTO), 3 ) );
        strCodCnd := fStrZero(IntToStr(CD_COND_PGTO), 3 );
        strCodFpg := fStrZero(Trim(CD_MEIO_PGTO), 3 );
        fltDesEsp := fltDesEspL; //VR_PEDIDO * PC_DESCONTO / 100;
        strMen001 := Copy(DS_OBSERVACAO, 01, 80);
        strMen002 := Copy(DS_OBSERVACAO, 81, 80);
        strMenExp := DS_OBSERVACAO;

        strTipPed := 'A';
        strTipOpe := 'E';
        strTipFre := IfThen(ID_TIPO_FRETE = 'C', '1', IfThen(ID_TIPO_FRETE='F','2','9'));
        strTabPre := IntToStr(CD_TAB_PRECO);
        strTipFin := 'P';
        strEntFat := 'N';
        strNumPok := IntToStr(CD_PEDIDO_PALM);
        dtaGraPed := DT_EMISSAO;
        dtaPreVis := DT_ENTREGA;
        dtaDtaOri := DT_EMISSAO;
        fltValFre := 0;
        strCodTra := IfThen( CD_TRANSPORTADORA <= 0, '', fStrZero(IntToStr(CD_TRANSPORTADORA), 5 ));
        dtaHorImp := 0;
        dtaDtaTra := 0;
        dtaHorTra := 0;
      End;

      Result := objEmitirPedido.fIniciarPedido(dadosPedido);

      If (Result) And (Assigned(objEmitirPedido.objFatVenda)) Then
      Begin
        objEmitirPedido.objFatVenda.blnImportacaoGeoSales := True;
      End;

      If Not fVerificaPedidoExistente Then
      Begin
        Result := False;
      End;

      If Not Result Then
        pRegistraLogImp('Nao foi possivel importar o Pedido ' + dadosPedido.strNumPok);

      If Result Then
      Begin
        intTamCodIte := fTamCodIte;
        Result := lstItens.Count > 0;
        intQtdItens := 0;
        For objItens in lstItens Do
        Begin
          If not Result Then
            Break;

          Inc(intQtdItens);

          pRegistrarProgresso('Aguarde, Inserindo Itens do Pedido...', lblProgressoDetalhes, pgbProgressoDetalhes, 0, intQtdItens, lstItens.Count);
          With dadosItem Do
          Begin
            dtaDtaPed := DT_EMISSAO;
            strCodIte := fStrZero(IntToStr(objItens.CD_PRODUTO), intTamCodIte );
            strDesIte := fRetNomProduto(strCodIte);
            fltQtdIte := objItens.QT_ITEM;
            fltUnitar := objItens.VR_ITEM;
            fltUniOri := objItens.VR_ITEM_ORIGINAL;
            strEntRet := 'R';
            strPromoc := '';
            strIdePro := 'NOR';
          End;

          Result := objEmitirPedido.fInserirProduto(dadosItem);

          If Not Result Then
            pRegistraLogImp('Nao foi possivel importar o produto ' + dadosItem.strCodIte + ' do Pedido ' + dadosPedido.strNumPok);

        End;

        If Result Then
          Result := objEmitirPedido.fCalcularTotais And
                    objEmitirPedido.fGravarPedido;

        If Result Then
          pRegistraLogImp('Importou o Pedido ' + dadosPedido.strNumPok + ' -> ' + objEmitirPedido.strDocEmitido)
        Else
          pRegistraLogImp('Nao foi possivel importar o Pedido ' + dadosPedido.strNumPok);

      End;

      FreeAndNil(objEmitirPedido);

    End;

  End;

  TGeoSalePedidoSingletonCollection.Instance.Destroy;

End;

procedure TfrmGeoSales.FormActivate(Sender: TObject);
begin
  inherited;
  If FAutomatico Then
    tmrAutomatico.Enabled := True;

end;

procedure TfrmGeoSales.FormCreate(Sender: TObject);
  Var
    qryGen: TUniQuery;
begin
  inherited;
  arrArquivosImp[0].Classe    := TGeoSale_Pedido;
  arrArquivosImp[0].strArqNam := VS_strCodEmp + 'P.TXT';

  arrArquivosImp[1].Classe    := TGeoSale_Item_Pedido;
  arrArquivosImp[1].strArqNam := VS_strCodEmp + 'I.TXT';

  qryGen := fCriaQuery;
  With qryGen, SQL Do
  Begin
    clbEmpresa.Items.Clear;
    Clear;
    Add('SELECT CONCAT(EMP_CODEMP," - ", EMP_NOMEMP) AS EMPNOM FROM CADEMP');
    Open;
    First;
    While Not Eof Do
    Begin
      clbEmpresa.Items.Add(FieldByName('EMPNOM').AsString);
      clbEmpresa.Checked[clbEmpresa.Items.Count-1] := True;
      Next;
    End;
    Close;
  End;
  FreeAndNil(qryGen);

end;

procedure TfrmGeoSales.Gravararquivoparageraoautomtica1Click(Sender: TObject);
  Var
    strNomDir : String;
    intIndex  : Integer;
begin
  inherited;
  strNomDir := 'C:\';
  If Not SelectDirectory(strNomDir, [sdAllowCreate, sdPerformCreate, sdPrompt], 0) Then
  Begin
    fMensagem('','Não é possível gerar o arquivo sem um diretório de destino!', ['&OK']);
    Exit;
  End;

  fArqIni(1, 'GERAL', 'PATH', strNomDir, 'GeoSalesCfg.txt');
  For intIndex := 0 To cblArquivos.Items.Count - 1 Do
    fArqIni(1, 'GERAL', cblArquivos.Items[intIndex].Text, IfThen(cblArquivos.Items[intIndex].Checked, '1', '0'), 'GeoSalesCfg.txt');

  For intIndex := 0 To clbEmpresa.Items.Count - 1 Do
    fArqIni(1, 'GERAL', Copy(clbEmpresa.Items[intIndex],1,3), IfThen(clbEmpresa.Checked[intIndex], '1', '0'), 'GeoSalesCfg.txt');

  fMensagem('','Arquivo de configuração gerado com sucesso!' + #13 +
               'Para iniciar o Autcom em modo de exportação automática coloque o comando "GeoSales_Exportar" nos parametros de inicialização!', ['&OK']);

end;

procedure TfrmGeoSales.pCarregarCfg(var strDiretorio : String);
  Var
    intIndex : Integer;
Begin
  strDiretorio := fArqIni(0, 'GERAL', 'PATH', '', 'GeoSalesCfg.txt');
  For intIndex := 0 To cblArquivos.Items.Count - 1 Do
    cblArquivos.Items[intIndex].Checked := StrToBool(fArqIni(0, 'GERAL', cblArquivos.Items[intIndex].Text, '0', 'GeoSalesCfg.txt'));

  For intIndex := 0 To clbEmpresa.Items.Count - 1 Do
    clbEmpresa.Checked[intIndex] := StrToBool(fArqIni(0, 'GERAL', Copy(clbEmpresa.Items[intIndex],1,3), '0', 'GeoSalesCfg.txt'));

End;

procedure TfrmGeoSales.pRegistrarProgresso(strTexto: String;
  lblInformacao: TLabel; pgbProgresso: TCxProgressBar; intInicio, intAtual, intFinal: Integer);
begin
  pgbProgresso.properties.Max := intFinal;
  pgbProgresso.properties.Min := intInicio;
  pgbProgresso.Position := intAtual;
  lblInformacao.Caption := Format('%s %d / %d',  [strTexto ,intAtual, intFinal]);
  Application.ProcessMessages;
end;

procedure TfrmGeoSales.pRegistraLogImp(strTexto: String);
begin
  mmoLogImp.Lines.Add(FormatDateTime('hh:mm:ss', fTime()) + ' - ' + strTexto);
end;

procedure TfrmGeoSales.tmrAutomaticoTimer(Sender: TObject);
  Var
    strNomDir : String;
begin
  inherited;
  tmrAutomatico.Enabled := False;
  If FAutomatico and blnExporta Then
  Begin
    pCarregarCfg(strNomDir);
    pContarArquivos;
    pExportarDados(strNomDir);
    Close;
  End

  Else
  If FAutomatico and (not blnExporta) Then
  Begin
    strNomDir := IncludeTrailingPathDelimiter(fCfgSis('IMPGEO', varString));
    pContarArquivos;
    pImportarDados(strNomDir);
    Close;
  End;
end;

procedure TfrmGeoSales.tmrDuracaoTimer(Sender: TObject);
begin
  inherited;
  lblIniExp.Caption  := FormatDateTime('hh:nn:ss', FHraIni);
  lblDuracao.Caption := FormatDateTime('hh:nn:ss', fNow() - FHraIni);

end;

class procedure TfrmGeoSales.pExporta(blnAutomatico : Boolean = False);
  var
    frmGeoSales: TfrmGeoSales;
    intIndex   : Integer;
begin
  Try
    pCriarFormularios(TfrmGeoSales, frmGeoSales);
    With frmGeoSales Do
    Begin
      blnExporta := True;

      pnl2.Visible := False;
      Height := Height - pnl2.Height;

      lblTotArq.Caption := IntToStr(High(arrArquivos) + 1);

      For intIndex := 0 To High(arrArquivos) Do
      Begin
        With cblArquivos.Items.Add Do
        Begin
          Text  := ReplaceStr(ReplaceStr(arrArquivos[intIndex].strArqNam, '.TXT', ''), '_', ' ');
          State := cbsChecked;
        End;
      End;

      FHraIni := 0;

      FAutomatico := blnAutomatico;

    End;
    frmGeoSales.ShowModal;

  Finally
    FreeAndNil(frmGeoSales);
  End;

end;

class procedure TfrmGeoSales.pImporta(blnAutomatico : Boolean = False);
  var
    frmGeoSales: TfrmGeoSales;
begin
  Try
    pCriarFormularios(TfrmGeoSales, frmGeoSales);
    With frmGeoSales Do
    Begin
      blnExporta := False;
      FHraIni := 0;
      Caption             := 'Importação - GeoSales';
      lblArqAtu.Caption   := 'Importando: *********';
      btnExporta.Caption  := 'Importar';
      cblArquivos.Enabled := False;

      btnPopMenu.Visible := False;
      pnlEmpresa.Visible := False;
      Height := Height - pnlEmpresa.Height;

      With cblArquivos.Items.Add Do
      Begin
        Text  := 'Pedido';
        State := cbsChecked;
      End;
      With cblArquivos.Items.Add Do
      Begin
        Text  := 'Item Pedido';
        State := cbsChecked;
      End;
      FAutomatico := blnAutomatico;

    End;
    frmGeoSales.ShowModal;

  Finally
    FreeAndNil(frmGeoSales);
  End;

end;

procedure TfrmGeoSales.btnPopMenuClick(Sender: TObject);
  Var
    pnt : TPoint;
begin
  inherited;
  pnt.X := btnExporta.Left;
  pnt.Y := btnExporta.Top;
  pnt   := btnExporta.ClientToScreen( pnt );
  pnt.Y := pnt.Y + btnExporta.Height + 1;
  popCriaConf.Popup(pnt.X, pnt.Y);
end;

function TfrmGeoSales.fGetEmpresasSelecionadas: String;
  Var
    intContador: Integer;
begin
  Result := '';
  For intContador := 0 To clbEmpresa.Items.Count -1 Do
  Begin
    If clbEmpresa.Checked[intContador] Then
      Result := Result + LeftStr(clbEmpresa.Items[intContador],3) + '_';
  End;
End;


end.
