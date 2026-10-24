unit untLayoutsImpressao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiOrdena, ExtCtrls, DB, UniClientDataSet, UniDataSetProvider, 
  Uni, AppEvnts, Menus, StdCtrls, EditFocus, Mask, untIFastPrint, untTypesSistema,
  MaskEditFocus, Grids, DBGridCitel, DBGrids, Buttons, untFastPrintEditor, BitBtnLockedIncrem,
  MemDS, DBAccess, Datasnap.Provider, frxClass, frxExportCSVTestabilidade,
  Datasnap.DBClient, untGravando;

type
  TfrmLayoutsImpressao = class(TfrmPaiOrdena)
    imgPrint: TImage;
    imgEdit: TImage;
    imgPreview: TImage;
    imgDel: TImage;
    imgConfig: TImage;
    cdsConsultaLAY_CODLAY: TStringField;
    cdsConsultaLAY_NOMLAY: TStringField;
    cdsConsultaLAY_CODEMP: TStringField;
    cdsConsultaLAY_TIPLAY: TStringField;
    cdsConsultaLAY_EDITAR: TStringField;
    cdsConsultaLAY_VISUALIZAR: TStringField;
    cdsConsultaLAY_IMPRIMIR: TStringField;
    cdsConsultaLAY_CONFIGURAR: TStringField;
    imgExp: TImage;
    imgImp: TImage;
    procedure dbgConsultaDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgConsultaMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbgConsultaCellClick(Column: TColumn);
    procedure cdsConsultaAfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
    X_POS_GRID, Y_POS_GRID: Integer;

    intREC_NO: Integer;
    intCOR_ZEBRA: Integer;

    function fGetLayout(strCodLay: String): IFastPrintFile;
    procedure pCarregaLayouts;
  public
    { Public declarations }
  end;

Const
  ARR_LAYOUTS: Array[0..29] Of String = ( 'CPVPPF',   {COMPROVANTE DA QUANTIDADE DE PONTOS DO PROFISSIONAL}
                                          'RECCTR',   {RECIBO CONTAS A RECEBER}
                                          'RECCRR',   {RECIBO CONTAS A RECEBER - (MEIA FOLHA)}
                                          'RECCTP',   {RECIBO CONTAS A PAGAR}
                                          'RECCPR',   {RECIBO CONTAS A PAGAR - MEIA FOLHA}
                                          'EXTPRO',   {EXTRATO DE COMISSÃO DO PROFISSIONAL}
                                          'MERCTR',   {IMPRESSÃO DUPLICATA MERCANTIL}
                                          'AUTABA',   {AUTORIZAÇÃO DE ABASTECIMENTO}
                                          'BORCTP',   {BORDERÓ - CONTAS A PAGAR}
                                          'AGCTR_',   {RECIBO DE AGRUPAMENTOS - CONTAS A RECEBER - MODELO 1,2,3 e 4 (CFG = MODAGR)}
                                          'BOLCTR',   {BOLETO - CONTAS A RECEBER}
                                          'PROMIS',   {NOTA PROMISSORIA}
                                          'CPCTP_',   {CP - CONTAS A PAGAR - FOLHA INTEIRA COM 3 POR PÁGINA, FOLHA INTEIRA, MEIA FOLHA (CFG = LAY_CP)}
                                          'FECRCX',   {RELATÓRIO DE FECHAMENTO DO CAIXA}
                                          'CMPTF_',   {COMPROVANTE DE TRANSFERÊNCIA DE CAIXA - MODELO 40 E 80 COLUNAS (CFG = COLTRF)}
                                          'MDRPA_',   {COMISSÃO DE PROFISSIONAIS - MODELO 1,2,3 e 4 (CFG = MODRPA)}
                                          'RECAV_',   {RECIBO AVULSO - 1 - 40 COLUNAS; 2 - 80 COLUNAS; CFG -> CFG_COLRAV }
                                          'RECCOB',   {RECIBO DE COBRANÇA}
                                          'RECPFM',   {RECIBO DE PAGTO DE FUNCIONARIOS - MENSAL}
                                          'RECPFE',   {RECIBO DE PAGTO DE FUNCIONARIOS - EVENTO}
                                          'FICFUN',   {FICHA CADASTRAL DE FUNCIONARIOS}
                                          'DUPCTR',   {DUPLICATA - CONTAS A RECEBER}
                                          'COMPMV',   {COMPROVANTE MOVIMENTAÇÃO/TRANSFERÊNCIA DE CONTA BANCO}
                                          'ADCTR_',   {RECIBO DE ADIANTAMENTOS - CONTAS A RECEBER / ADIANTAMENTOS - MODELO 1,2,3 (CFG = RECRCX)}
                                          'RECBB_',   {RECIBO DE BAIXA DE BOCA DE CAIXA - 1-)MODELO RETRATO E 2-)NORMAL (CFG = ORBXBC)}
                                          'RELDOC',   {RELAÇÃO DE DOCUMENTOS BAIXADOS}
                                          'CPVVPF',   {COMPROVANTE DO VALOR DE COMISSÃO DO PROFISSIONAL}
                                          'FICCLI',   {FICHA CADASTRAL DE CLIENTES}
                                          'CRTCOB',   {CARTA DE COBRANÇA DE CLIENTES}
                                          'RECCRI');  {RECIBO CONTAS A RECEBER - REIMPRESSAO}

implementation

uses untComprovantePontosProfissional, untFuncoesSimples, untReciboCtr, untReciboCtp,
  untExtratoComissaoProfissional, untReciboCtrMeiaFolha, untRelCtrMercantil, untRelAutAba,
  untRelCtpBordero, untRelCtrAgrupDupRecibo, untBoletoContasReceber,
  untRelNotaPromissoria, untRelCtpCompPgtoMod, untRelFechamentoRcx,untRelCtrComissaoProfissionais, untComprovanteTransf,
  untRecAvulso,untRelQckRcxReciboCob, untRelRecPagtoFuncCtr, untRelFichaCadFuncionarioCtr, untRelCtrCompRecbMod,
  untRelComprovanteMovimentacao, untRelCtrReciboAdiantamento, untRecBaixaBocaCaixa, untRelacaoDocsBaixados, untRelFichaCadCliente,
  untReciboCtpMeiaFolha, untRelCartaCobClientes, untReciboCtrReimpressao;

{$R *.dfm}

{ TfrmLayoutsImpressao }

function TfrmLayoutsImpressao.fGetLayout(strCodLay: String): IFastPrintFile;
begin
       if strCodLay = 'CPVPPF' Then Result := TComprovantePontosProfissional.Create('CPVPPF')
  else if strCodLay = 'CPVVPF' Then Result := TComprovantePontosProfissional.Create('CPVVPF')
  else if strCodLay = 'RECCTR' Then Result := TReciboCtr.Create
  else if strCodLay = 'RECCRR' Then Result := TReciboCtrMeiaFolha.Create
  else if strCodLay = 'RECCTP' Then Result := TReciboCtp.Create
  else if strCodLay = 'RECCPR' Then Result := TReciboCtpMeiaFolha.Create
  else if strCodLay = 'EXTPRO' Then Result := TExtratoComissaoProfissional.Create
  else if strCodLay = 'MERCTR' Then Result := TRelCtrMercantil.Create
  else if strCodLay = 'AUTABA' Then Result := TRelAutAba.Create
  else if strCodLay = 'BORCTP' Then Result := TRelCtpBordero.Create
  else if copy(strCodLay, Pos(strCodLay,'_'), 5) = 'AGCTR' Then Result := TRelCtrAgrupDupRecibo.Create
  else if strCodLay = 'BOLCTR' Then Result := TBoletoContasReceber.Create
  else if Pos('PROM', strCodLay) > 0 Then Result := TRelNotaPromissoria.Create
  else if copy(strCodLay, Pos(strCodLay,'_'), 5) = 'CPCTP' Then Result := TRelCtpCompPgtoMod.Create
  else if Pos('FECRC', strCodLay) > 0 Then Result := TRelFechamentoRcx.Create
  else if copy(strCodLay, Pos(strCodLay,'_'), 5) = 'CMPTF' Then Result := TComprovanteTransf.Create
  else if Pos('MDRPA', strCodLay) > 0 Then Result := TRelCtrComissaoProfissionais.Create
  else if Pos('RECAV', strCodLay) > 0 then Result := TRecAvulso.Create
  else if strCodLay = 'RECCOB' Then Result := TRelQckRcxReciboCob.Create
  else if strCodLay = 'RECPFM' Then Result := TRecPagtoFuncCtr.Create('MENSAL')
  else if strCodLay = 'RECPFE' Then Result := TRecPagtoFuncCtr.Create('EVENTO')
  else if strCodLay = 'FICFUN' Then Result := TFichaCadFuncionarioCtr.Create
  else if strCodLay = 'DUPCTR' Then Result := TRelCtrCompRecbMod.Create
  else if strCodLay = 'COMPMV' Then Result := TRelComprovanteMovimentacao.Create
  else if copy(strCodLay, Pos(strCodLay,'_'), 5) = 'ADCTR' Then Result := TRelCtrReciboAdiantamento.Create
  else if Pos('RECBB', strCodLay) > 0 Then Result := TRecBaixaBocaCaixa.Create
  else if strCodLay = 'RELDOC' Then Result := TRelacaoDocsBaixados.Create
  else if strCodLay = 'FICCLI' Then Result := TFichaCadCliente.Create
  else if strCodLay = 'CRTCOB' Then Result := TRelCartaCobClientes.Create
  else if strCodLay = 'RECCRI' Then Result := TReciboCtrReimpressao.Create  ;
end;

procedure TfrmLayoutsImpressao.cdsConsultaAfterScroll(DataSet: TDataSet);
begin
  inherited;
  intREC_NO := DataSet.RecNo;
end;

procedure TfrmLayoutsImpressao.dbgConsultaCellClick(Column: TColumn);
  var
    strCodLay: String;
    fastEditor: TFastPrintFileEditor;
    SMensagemValidacao : String;

  procedure pSetAndLoadLayout;
  begin
    fastEditor.pSetFastPrintFile(fGetLayout(strCodLay));
    fastEditor.fLoadReport;
  end;

begin
  inherited;

  strCodLay := cdsConsultaLAY_CODLAY.AsString;
  fastEditor := TFastPrintFileEditor.Create(Self);

  If Column.FieldName = 'LAY_EDITAR' Then
  Begin
    pSetAndLoadLayout;

    fastEditor.pEditLayout;

    If fastEditor.fChanged And
      (fMensagem('','Salvar alterações no layout?', ['', '']) = 1) Then
    Begin
      if strCodLay = 'BOLCTR' then
      begin
        if not TBoletoContasReceber(fastEditor).fValidaLayoutImpressao(fastEditor.FrxReport, SMensagemValidacao) then
        begin

          repeat
            if fMensagem('', SMensagemValidacao+'. Deseja carregar novamente o layout recém modificado?', ['Sim','Não']) = 2 then
              Exit;

            fastEditor.pEditLayout;

            if (fMensagem('','Salvar alterações no layout?', ['', '']) = 2) then
              Exit;

          until (TBoletoContasReceber(fastEditor).fValidaLayoutImpressao(fastEditor.FrxReport, SMensagemValidacao)) ;

          fastEditor.fSaveReport;
        end
        else
          fastEditor.fSaveReport;
      end
      else
        fastEditor.fSaveReport;
    End;
  End;

  If Column.FieldName = 'LAY_VISUALIZAR' Then
  Begin
    pSetAndLoadLayout;
    fastEditor.pPreview;
  End;

  If Column.FieldName = 'LAY_IMPRIMIR' Then
  Begin
    pSetAndLoadLayout;
    fastEditor.pPrint;
  End;

  If Column.FieldName = 'LAY_CONFIGURAR' Then
  Begin
    pSetAndLoadLayout;
    fastEditor.pConfigPrinter;

    cdsConsulta.Edit;
    cdsConsultaLAY_TIPLAY.AsString := IIF(fGetLayout(strCodLay).fGetFastType = ffLaser, 'J', 'M');
    cdsConsulta.Post;
  End;

  If Column.FieldName = 'LAY_EXPORTAR' Then
  Begin
    pSetAndLoadLayout;
    TfrmGravando.fExecutarModal(fastEditor.pExport, 'Aguarde... Realizando Exportação...', '');
  End;

  If Column.FieldName = 'LAY_IMPORTAR' Then
  Begin
    pSetAndLoadLayout;
    TfrmGravando.fExecutarModal(fastEditor.pImport, 'Aguarde... Realizando Importação...', '');
  End;

  FreeAndNil(fastEditor);

end;

procedure TfrmLayoutsImpressao.dbgConsultaDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);

  function fInsideRect: Boolean;
  begin
    Result := (( rect.Left   ) <= X_POS_GRID ) And (( rect.Right  ) >= X_POS_GRID ) And
              (( rect.Top    ) <= Y_POS_GRID ) And (( rect.Bottom ) >= Y_POS_GRID ) ;
  End;

  procedure pDesenhaImagem(bmp: TBitmap);
  begin
    With dbgConsulta.Canvas, Rect Do
    Begin
      FillRect(Rect);

      If fInsideRect Then
      Begin
        Brush.Color := cl3DLight;
        FillRect(Rect);
      End;

      Draw(Left + (Column.Width div 2 - bmp.Width div 2), Top + 1, bmp);

      If fInsideRect Then
      Begin
        Pen.Color := clBlack;
        Brush.Style := bsClear;
        Rectangle(Rect.Left, Rect.Top, Rect.Right, Rect.Bottom);
      End;

    End;
  end;

  procedure pPintarZebra;
  begin
    If (cdsConsulta.Active) And
       (cdsConsulta.RecordCount > 0) Then
    Begin
      If (cdsConsulta.RecNo Mod 2) = 0 Then
      Begin
        dbgConsulta.Canvas.Brush.Color := intCOR_ZEBRA;
        dbgConsulta.Canvas.FillRect(Rect);
        dbgConsulta.DefaultDrawColumnCell(Rect,DataCol,Column,State);
      End;
    End;
  end;

begin

  inherited;

  pPintarZebra;

  if Column.FieldName = 'LAY_TIPLAY' then
  begin
    dbgConsulta.Canvas.Font.Style := [fsBold];
    dbgConsulta.Canvas.Font.Size  := 10;

    If cdsConsultaLAY_TIPLAY.AsString = 'M' Then
      dbgConsulta.Canvas.Font.Color := clRed
    Else
      dbgConsulta.Canvas.Font.Color := clBlue;

    dbgConsulta.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;

  if Column.FieldName = 'LAY_EDITAR' then
  begin
    pDesenhaImagem(imgEdit.Picture.Bitmap);
  end;

  if Column.FieldName = 'LAY_VISUALIZAR' then
  begin
    pDesenhaImagem(imgPreview.Picture.Bitmap);
  end;

  if Column.FieldName = 'LAY_IMPRIMIR' then
  begin
    pDesenhaImagem(imgPrint.Picture.Bitmap);
  end;

  if Column.FieldName = 'LAY_CONFIGURAR' then
  begin
    pDesenhaImagem(imgConfig.Picture.Bitmap);
  end;

  if Column.FieldName = 'LAY_EXPORTAR' then
  begin
    pDesenhaImagem(imgExp.Picture.Bitmap);
  end;

  if Column.FieldName = 'LAY_IMPORTAR' then
  begin
    pDesenhaImagem(imgImp.Picture.Bitmap);
  end;

  With dbgConsulta, Canvas Do
  Begin
    Pen.Color := clBlack;
    Brush.Style := bsClear;
    Rectangle(0, 0, Width, Height);
  End;

end;

procedure TfrmLayoutsImpressao.dbgConsultaMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  X_POS_GRID := X;
  Y_POS_GRID := Y;
  dbgConsulta.Refresh;
end;

procedure TfrmLayoutsImpressao.FormCreate(Sender: TObject);
begin
  inherited;
  blnTemSelecao := False;
  blnSempreRelerBanco := False;
  blnSelecionaComEnter := False;
  blnSelecionaComEspaco := False;
  blnTemPesquisa := True;
  blnPodeIncluir := True;

  intCOR_ZEBRA := StrToIntDef(fCfgSis('CORZEB'), clWhite);
end;

procedure TfrmLayoutsImpressao.FormShow(Sender: TObject);
begin
  inherited;
  pCarregaLayouts;
end;

procedure TfrmLayoutsImpressao.pCarregaLayouts;
  var
    intLay: Integer;
    layout: IFastPrintFile;
begin
  cdsConsulta.CreateDataSet;

  For intLay := 0 To Length(ARR_LAYOUTS) -1 Do
  Begin
    layout := fGetLayout(ARR_LAYOUTS[intLay]);

    cdsConsulta.Append;
    cdsConsultaLAY_CODLAY.AsString := layout.fGetKey;
    cdsConsultaLAY_NOMLAY.AsString := layout.fGetName;
    cdsConsultaLAY_CODEMP.AsString := VS_strCodEmp;
    cdsConsultaLAY_TIPLAY.AsString := IIF(layout.fGetFastType = ffLaser, 'J', 'M');
    cdsConsulta.Post;
  End;

  blnPodeIncluir := False;
  cdsConsulta.First;
end;

end.
