unit untMensagemExplicativa_ComConsultaProdutos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.ComCtrls, untTypesSistema, AgrupamentoDeOndaDeSeparacao.Types;

type
  TfrmMensagemExplicativa_ComConsultaProdutos = class(TfrmPai)
    mmoInstru: TMemo;
    RitchObservacao: TRichEdit;
    btnConsultaProdutos: TBitBtnLocked;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnConsultaProdutosClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
  private
    FItensRemessa : TItensRemessa;
    function TemItensNaoAtendidos : Boolean;
  public
    { Public declarations }
    Class Procedure pMensagem(strMensagem: String; intAltura: Integer = 0; intLargura: Integer = 0);

    property ItensRemessa : TItensRemessa Read FItensRemessa Write FItensRemessa;

  end;

implementation

{$R *.dfm}

uses untFuncoesSimples, untConsultas, untPanelCxItem, untPanelCxBanner, untPanelCxPreFiltro,
     Uni, untReimpressao, untAgregados, untFatRequisicaoCompras, untDigCndPagamentoEsp, untPnlBanner, untPnlPreFiltroCarro,
     untFatGor;

procedure TfrmMensagemExplicativa_ComConsultaProdutos.btnConsultaProdutosClick(Sender: TObject);
  Var
    chrKey: Char;
    arrSel: TConsultasArray;
    objfrmPnl: TPanelCxItem;
    objfrmPnlBanner: TPanelCxBanner;
    objfrmPreFiltroCarro: TPanelCxPreFiltro;
    strTabPre: String;
    strCfgBan: String;
    qryConsulta: TUniQuery;
begin
  strTabPre    :=  IIF(fEmptyStr(fCfgSis('TABPAD', varString)), '1', fCfgSis('TABPAD', varString));
  chrKey       := '/';

  Try
    objfrmPnl := TPanelCxItem.New();

    Try
      objFrmPnl.procMostraDocumentoReimpressao := pMostraDocumentoReimpressao;
      objFrmPnl.strNomForm := Self.Name;
      objFrmPnl.recParametros.strCodCli  := '';
      objFrmPnl.strCodVen  := '';
      objFrmPnl.strCodDig  := '';
      objFrmPnl.intPraMedio:= 0;
      objFrmPnl.blnFaturamento := True;
      objFrmPnl.recParametros.strTabPre  := strTabPre;
      objfrmPnl.strNumOrc  := '';
      objfrmPnl.strEspOrc  := '';
      objFrmPnl.procExibeAgregados := TfrmAgregados.pExibe;
      objFrmPnl.procExibeRequisicaoCompra := TfrmFatRequisicaoCompras.pExibe;
      objFrmPnl.blnCndPag := (fCfgSis('PANITE', VarBoolean) And fCfgSis('CPDNPI', VarBoolean));
      objFrmPnl.procExibeCndPag := TfrmDigCndPagamentoEsp.pExibe;

      strCfgBan := fCfgSis('BANVEN', VarString);

      If (Pos('1', strCfgBan) > 0) Then
      Begin
        objfrmPnlBanner := TPanelCxBanner.Create(TfrmPnlBanner);
        objfrmPnlBanner.strTabPre := strTabPre;
      End;

      objfrmPreFiltroCarro := Nil;

      If fCfgSis('PROVEI', varBoolean) Then
        objfrmPreFiltroCarro := TPanelCxPreFiltro.Create(TfrmPnlPreFiltroCarro);

      qryConsulta := fCriaQuery(Nil);

      fPesqItem(conIteCompleta,
                Self,
                Nil,
                Nil,
                qryConsulta,
                chrKey,
                arrSel,
                True,
                objfrmPnl,
                'Consulta de Produtos',
                strTabPre,
                '',
                0,
                false,
                false,
                -1, // SEGUE A CONFIGURAÇÃO DE ATIVOS
                cdrCodIte,
                '',
                False,   {* Se é pedido de compra                        *}
                '',
                '',
                True,
                False,
                True,
                '', // Codigo do Comprador
                False,
                False,
                False,
                False,
                False,
                False,
                False,
                False,
                '',
                -1,
                False,
                '',
                True,
                '',
                '',
                '',
                '',
                '',
                '',
                False,
                False,
                False,
                objFrmPnlBanner,
                objfrmPreFiltroCarro);
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[btnConsultaProdutosClick]');
      End;
    End;

  Finally
    FreeAndNil(qryConsulta);
    FreeAndNil(objfrmPnl);

    If Assigned(objfrmPnlBanner) Then
      FreeAndNil(objfrmPnlBanner);

    If Assigned(objfrmPreFiltroCarro) Then
      FreeAndNil(objfrmPreFiltroCarro);
  End;
end;

procedure TfrmMensagemExplicativa_ComConsultaProdutos.btnSairClick(Sender: TObject);
  const
    SQL = 'SELECT ' +
          '  F.AUTOINCREM ' +
          'FROM           ' +
          '  FATGOR F     ' +
           ' JOIN EXTGOR E ON (E.FGO_SEQFGO = F.AUTOINCREM) ' +
           ' JOIN FATDOR D ON (D.FDO_SEQGER = F.AUTOINCREM) ' +
          'WHERE ' +
          '  E.FGO_SEQSEP IN ([SEQSEP]) AND ' +
          '  D.FDO_CODITE = :CODITE        ' +
          'GROUP BY                        ' +
          '  F.AUTOINCREM                  ';

  var
    ItemRemessa : TItemRemessa;
    PedidosNaoAtendidos : TUniQuery;
    LExcluirExtLar: Boolean;
begin
  inherited;

  If Not (TemItensNaoAtendidos) Then
  Begin
    ModalResult := mrClose;
    Exit;
  End;

  LExcluirExtLar := fValidaExcluiEXTLAR;

  fStartTransaction;

  Try

    PedidosNaoAtendidos := fCriaQuery;

    Try

      for ItemRemessa in FItensRemessa do
      begin

        PedidosNaoAtendidos.Close;
        PedidosNaoAtendidos.SQL.Clear;
        PedidosNaoAtendidos.SQL.Add(StringReplace(SQL, '[SEQSEP]', ItemRemessa.CodigoDaRemessa, [rfReplaceAll]));
        PedidosNaoAtendidos.ParamByName('CODITE').AsString := ItemRemessa.CodigoDoItem;
        PedidosNaoAtendidos.Open;

        PedidosNaoAtendidos.First;
        While Not PedidosNaoAtendidos.Eof Do
        Begin
          fLimpaExpedicaoPedido(PedidosNaoAtendidos.FieldByName('AUTOINCREM').AsString, False, IIF(LExcluirExtLar, eeloExcluir, eeloNaoExcluir));
          PedidosNaoAtendidos.Next;
        End;

      end;

    Finally
      FreeAndNil(PedidosNaoAtendidos);
    End;

    If fCommit Then
      ModalResult := mrRetry;

  Except

    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '');
    End;

  End;

end;

procedure TfrmMensagemExplicativa_ComConsultaProdutos.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_ESCAPE) Then
    Close;
end;

procedure TfrmMensagemExplicativa_ComConsultaProdutos.FormShow(Sender: TObject);
begin
  inherited;
  If TemItensNaoAtendidos Then
    btnSair.Caption := '&Prosseguir';
end;

class procedure TfrmMensagemExplicativa_ComConsultaProdutos.pMensagem(strMensagem: String; intAltura, intLargura: Integer);
  var
    LMenExp : TfrmMensagemExplicativa_ComConsultaProdutos;
begin

  pCriarFormularios(TfrmMensagemExplicativa_ComConsultaProdutos, LMenExp);

  Try

    LMenExp.Caption := 'Aviso';
    LMenExp.pnlStatus.Visible := False;

    If intAltura > 0 Then
      LMenExp.Height := intAltura;

    If intLargura > 0 Then
      LMenExp.Width := intLargura;

    LMenExp.mmoInstru.Text := strMensagem;

    LMenExp.btnSair.Left := (LMenExp.ClientWidth - LMenExp.btnSair.Width) Div 2;

    LMenExp.ShowModal;

  Finally
    pFreeAndNil(LMenExp);
  End;

end;

function TfrmMensagemExplicativa_ComConsultaProdutos.TemItensNaoAtendidos: Boolean;
begin
  Result := Assigned(FItensRemessa) And (Length(FItensRemessa) > 0);
end;

end.
