unit untPedeMIFF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiEdit, AppEvnts, Menus, StdCtrls, Buttons, BitBtnLockedIncrem,
  ExtCtrls, EditFocus, untTypesSistema, frxClass, frxExportCSVTestabilidade,
  Vcl.Mask, MaskEditFocus;

type
  TfrmPedeMIFF = class(TfrmPaiEdit)
    btnConfirma: TBitBtnLocked;
    edtNumDoc: TEditFocus;
    edtEspDoc: TEditFocus;
    edtCodEmp: TEditFocus;
    lblNumDoc: TLabel;
    lblEspDoc: TLabel;
    lblCodEmp: TLabel;
    edtSerie: TEditFocus;
    lblSerie: TLabel;
    mskDtaCad: TMaskEditFocus;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure mskDtaCadExit(Sender: TObject);
    procedure mskDtaCadKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    strCliente: String;
    teqTipEtq: TTipoEtiqueta;
  protected

    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  end;

var
  frmPedeMIFF: TfrmPedeMIFF;

implementation

uses untFuncoesSimples, StrUtils;

{$R *.dfm}

procedure TfrmPedeMIFF.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;

  If ModalResult = mrOk Then
  Begin
    If Not fVerificaCampos Then
      Action := caNone;
  End;
end;

procedure TfrmPedeMIFF.FormCreate(Sender: TObject);
begin
  inherited;
  edtNumDoc.TamCampo  := fTamDocCadRec;
  edtNumDoc.MaxLength := fTamDocCadRec;
end;

procedure TfrmPedeMIFF.FormShow(Sender: TObject);
begin
  inherited;

  Case teqTipEtq Of
    tpeTA,
    tpeSepNota,
    tpeSepNotaObs,
    tpeAJ     : Begin
                  edtEspDoc.ReadOnly := False;
                  edtEspDoc.TabStop  := True;
                End;

    tpeSF,
    tpeSepSF  : Begin
                  edtNumDoc.MaxLength := fTamNumDoc;
                  edtNumDoc.TamCampo  := edtNumDoc.MaxLength;
                End;

    tpeOrdProImobiliaria,
    tpeOrdProAutomotiva: Begin
                           edtEspDoc.ReadOnly := False;
                           edtEspDoc.TabStop := True;
                           edtCodEmp.ReadOnly := False;
                           edtCodEmp.TabStop := True;
                         End;

  End;

  Case teqTipEtq Of
    tpeSF,
    tpeSepSF  : ;
    tpeOrdemServico,
    tpeOrdemServicoTermoResp,
    tpeOrdemServicoTermoDev,
    tpeOrdemServicoOrdExecucao,
    tpeOrdemServicoImagem,
    tpeSepRomaneio           : Begin
                                 edtNumDoc.TamCampo := 6;
                                 edtNumDoc.MaxLength := 6;
                               End;

    tpeSepItem               : Begin
                                 edtNumDoc.TamCampo := fTamCodIte;
                                 edtNumDoc.MaxLength := edtNumDoc.TamCampo;
                               End;

    tpeOrdPro                : Begin
                                 edtNumDoc.TamCampo  := 12;
                                 edtNumDoc.MaxLength := 12;
                               End;
    tpeCarnePagamento,
    tpeDuplicata,
    tpeComprovanteGeracaoCredito,
    tpeLiberacaoArmazenagem : Begin
                                edtEspDoc.ReadOnly := False;
                                edtEspDoc.TabStop := True;
                                edtEspDoc.Text := '';

                                edtSerie.ReadOnly := False;
                                edtSerie.TabStop := True;
                                edtSerie.Text := '';
                              End;
    tpeInspecaoEnt,
    tpeInspecaoSai         : Begin
                               lblSerie.Visible  := False;
                               edtSerie.Visible  := False;
                               lblEspDoc.Visible := False;
                               edtEspDoc.Visible := False;
                             End;


    tpeLocacaoEquipamento    : Begin
                               lblSerie.Visible  := False;
                               edtSerie.Visible  := False;
                               lblEspDoc.Visible := False;
                               edtEspDoc.Visible := False;
                             End;

    tpeProcessoDeExtrusao: Begin
                             edtSerie.ReadOnly := False;
                             edtSerie.TabStop := True;
                             edtSerie.Text := '';
                             edtCodEmp.ReadOnly := False;
                             edtCodEmp.TabStop := True;
                             mskDtaCad.Visible := True;
                             mskDtaCad.TabStop := True;
                           End;

    tpeRL,
    tpeFaturaLocacao: Begin
                        lblSerie.Visible  := False;
                        edtSerie.Visible  := False;
                      End;

    tpeEnderecamentoDeProduto : Begin
                                  edtSerie.ReadOnly := False;
                                  edtSerie.TabStop := True;
                                  edtSerie.Text := '';
                                  edtEspDoc.ReadOnly := False;
                                  edtEspDoc.TabStop := True;
                                  edtEspDoc.Text := '';
                                  edtCodEmp.ReadOnly := False;
                                  edtCodEmp.TabStop := True;
                                End;

    tpeCupomPromocao : Begin
                         mskDtaCad.Visible := False;
                         edtSerie.Visible  := False;
                         lblSerie.Visible  := False;

                         edtEspDoc.ReadOnly := False;
                         edtEspDoc.TabStop := True;
                         edtEspDoc.Text := '';

                         edtCodEmp.ReadOnly := False;
                         edtCodEmp.TabStop := True;

                       End;

    tpeRemessaDevolucao : Begin
                            mskDtaCad.Visible := False;
                            edtSerie.Visible  := False;
                            lblSerie.Visible  := False;

                            edtEspDoc.ReadOnly := True;
                            edtEspDoc.TabStop  := False;
                            edtEspDoc.Text     := 'RD';

                            edtCodEmp.ReadOnly := False;
                            edtCodEmp.TabStop := True;
                          End;

    tpeRB           : Begin
                        lblSerie.Visible  := False;
                        edtSerie.Visible  := False;

                        edtEspDoc.ReadOnly := True;
                        edtEspDoc.TabStop  := False;
                        edtEspDoc.Text     := 'RB';
                      End;

    tpeCupomProxDesc : edtEspDoc.ReadOnly := False;

    tpeSolicitacaoManutencaoEquipamentos : Begin
                                             edtNumDoc.TamCampo  := 8;
                                             edtNumDoc.MaxLength := 8;
                                             lblSerie.Visible  := False;
                                             edtSerie.Visible  := False;
                                             lblEspDoc.Visible := False;
                                             edtEspDoc.Visible := False;
                                           End;

    Else Begin
           edtNumDoc.MaxLength := fTamDocCadRec;
           edtNumDoc.TamCampo  := edtNumDoc.MaxLength;
         End;

  End;


  If mskDtaCad.Visible Then
    pSetFocus(mskDtaCad)
  Else
    pSetFocus(edtNumDoc);
end;

function TfrmPedeMIFF.fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean;

   Function fDocumentoExiste: Boolean;
   Begin
     Case teqTipEtq Of
       tpeROTin,
       tpeMI,
       tpeFF,
       tpeBR,
       tpeTR,
       tpeDV,
       tpeAJ,
       tpeTA,
       tpeEP,
       tpeBE,
       tpeUS,
       tpeCS,
       tpeCR,
       tpeTE,
       tpePI,
       tpeTicketDV,
       tpeRL,
       tpeFaturaLocacao,
       tpeFFDocumentosCR : Begin
                             strCliente := fCampoTabela('GER_CODCLI', 'MOVGER', ['GER_NUMDOC', 'GER_CODEMP', 'GER_ESPDOC'],
                               [edtNumDoc.Text, VS_strCodEmp, edtEspDoc.Text]);

                             If fEmptyStr(strCliente) Then
                               strCliente := fCampoTabela('GER_CODCLI', 'NOTGER', ['GER_NUMDOC', 'GER_CODEMP', 'GER_ESPDOC'],
                                             [edtNumDoc.Text, VS_strCodEmp, edtEspDoc.Text]);

                           End;

       tpeGA      : Begin
                      strCliente := fCampoTabela('GAG_CODCLI', 'MOVGAG', ['GAG_NUMENT', 'GAG_CODEMP'],
                                    [edtNumDoc.Text, VS_strCodEmp]);
                    End;

       tpeContGC  : strCliente := fCampoTabela('DET_CODCLI', 'MOVDET', ['DET_NUMDOC', 'DET_CODEMP', 'DET_ESPDOC'],
                                    [edtNumDoc.Text, VS_strCodEmp, edtEspDoc.Text]);

       tpeGF, tpeContGF,tpeContGR   : strCliente := fCampoTabela('DET_CODFOR', 'MOVDET', ['DET_NUMDOC', 'DET_CODEMP', 'DET_ESPDOC'],
                                    [edtNumDoc.Text, VS_strCodEmp, edtEspDoc.Text]);

       tpeSepNota,
       tpeSepNotaObs,
       tpeNF,
       tpeNS,
       tpeTicketNF,
       tpeIF : Begin
                 strCliente := fCampoTabela('GER_CODCLI', 'MOVGER', ['GER_NUMDOC', 'GER_CODEMP', 'GER_ESPDOC'],
                               [edtNumDoc.Text, VS_strCodEmp, edtEspDoc.Text]);

                 If fEmptyStr(strCliente) Then
                   strCliente := fCampoTabela('GER_CODCLI', 'NOTGER', ['GER_NUMDOC', 'GER_CODEMP', 'GER_ESPDOC'],
                                 [edtNumDoc.Text, VS_strCodEmp, edtEspDoc.Text]);
                 End;

       tpeSF,
       tpeSepSF: begin
                   strCliente := fCampoTabela('GER_CODFOR', 'MOVGER', ['GER_NUMDOC', 'GER_CODEMP', 'GER_ESPDOC'],
                     [edtNumDoc.Text, VS_strCodEmp, edtEspDoc.Text]);

                   If fEmptyStr(strCliente) Then
                     strCliente := fCampoTabela('GER_CODFOR', 'NOTGER', ['GER_NUMDOC', 'GER_CODEMP', 'GER_ESPDOC'],
                       [edtNumDoc.Text, VS_strCodEmp, edtEspDoc.Text]);
                 End;

       tpeD1       : strCliente := fCampoTabela('GER_CODCLI', 'NOTGER', ['GER_NUMDOC', 'GER_CODEMP', 'GER_ESPDOC'],   [edtNumDoc.Text, VS_strCodEmp, edtEspDoc.Text]);

       tpeCupomServico : strCliente := fCampoTabela('GER_CODCLI', 'MOVGER', ['GER_NUMDOC', 'GER_CODEMP', 'GER_ESPDOC'],[edtNumDoc.Text, VS_strCodEmp, edtEspDoc.Text]);

       tpePD,
       tpeOR,
       tpePR,
       tpeAmostraProdutoAuto,
       tpeSepPedido,
       tpePDExterior,
       tpeORExterior: strCliente := fCampoTabela('FGO_CODCLI', 'FATGOR', ['FGO_NUMDOC', 'FGO_CODEMP', 'FGO_ESPDOC'],
                                                 [edtNumDoc.Text, VS_strCodEmp, edtEspDoc.Text]);

       tpeSepRomaneio: strCliente := fCampoTabela('GER_CODCLI', 'ROMGERX', ['GER_NUMROM', 'GER_EMPROM'], [edtNumDoc.Text, VS_strCodEmp]);

       tpeOrdemServico,
       tpeOrdemServicoTermoResp,
       tpeOrdemServicoTermoDev,
       tpeOrdemServicoOrdExecucao,
       tpeOrdemServicoImagem: strCliente := fCampoTabela('EQU_CODCLI', 'EQUGER', ['EQU_NUMOSE', 'EQU_CODEMP'],
                                                                           [edtNumDoc.Text, VS_strCodEmp]);
       tpeReqMaterialConsumo : strCliente := fCampoTabela('REQ_FORCLI', 'MOVRQG', ['REQ_NUMREQ', 'REQ_CODEMP'], [edtNumDoc.Text, VS_strCodEmp]);
       tpeReqMaterialConsumoVidro : strCliente := fCampoTabela('GER_CODCLI', 'MOVGER', ['GER_NUMDOC', 'GER_CODEMP', 'GER_ESPDOC'],
                                     [edtNumDoc.Text, VS_strCodEmp, edtEspDoc.Text]);

       tpeSepItem : strCliente := fCampoTabela('ITE_CODITE', 'CADITE', ['ITE_CODITE'], [edtNumDoc.Text]);

       tpeOrdPro  : strCliente := fCampoTabela('PRO_CODPRO', 'MOVPRO', ['PRO_CODPRO', 'PRO_CODEMP'], [edtNumDoc.Text, edtCodEmp.Text]);

       tpeProcessoDeExtrusao :Begin
                                If Not fEmptyStr(mskDtaCad.Text) Then
                                  strCliente := fCampoTabela('ORD_CODORD','ORDGER',['ORD_CODEMP', 'ORD_CODORD', 'ORD_DTACAD'], [edtCodEmp.Text, edtSerie.Text, FormatDateTime('yyyy-mm-dd', StrToDate(mskDtaCad.Text))]);
                              End;

       tpeCarnePagamento,
       tpeComprovanteGeracaoCredito,
       tpeDuplicata: Begin
                       strCliente := fCampoTabela('GER_CODCLI', 'MOVGER', ['GER_NUMDOC', 'GER_CODEMP', 'GER_ESPDOC'],
                                     [edtNumDoc.Text, VS_strCodEmp, edtEspDoc.Text]);

                       If fEmptyStr(strCliente) Then
                         strCliente := fCampoTabela('GER_CODCLI', 'NOTGER', ['GER_NUMDOC', 'GER_CODEMP', 'GER_ESPDOC'],
                                                    [edtNumDoc.Text, VS_strCodEmp, edtEspDoc.Text]);
                     End;

       tpeInspecaoEnt,
       tpeInspecaoSai,
       tpeDevolucaoLocacao : strCliente := fCampoTabela('EQL_CODCLI', 'CONEQL', ['EQL_NROCON', 'EQL_CODEMP'], [edtNumDoc.Text, edtCodEmp.Text]);

       tpeLiberacaoArmazenagem,
       tpeEnderecamentoDeProduto : begin
                                     strCliente := fCampoTabela('GER_CODFOR', 'MOVGER', ['GER_NUMDOC', 'GER_CODEMP', 'GER_ESPDOC', 'GER_SERIE_','GER_TIP_FC'],
                                       [edtNumDoc.Text, VS_strCodEmp, edtEspDoc.Text, edtSerie.Text,'F']);

                                     If fEmptyStr(strCliente) Then
                                       strCliente := fCampoTabela('GER_CODFOR', 'NOTGER', ['GER_NUMDOC', 'GER_CODEMP', 'GER_ESPDOC', 'GER_SERIE_','GER_TIP_FC'],
                                         [edtNumDoc.Text, VS_strCodEmp, edtEspDoc.Text, edtSerie.Text,'F']);
                                   End;

       tpeLocacaoEquipamento: strCliente := fCampoTabela('EQL_NROCON', 'CONEQL', ['EQL_NROCON', 'EQL_CODEMP'], [edtNumDoc.Text, edtCodEmp.Text]);

       tpeCupomProxDesc: strCliente := fCampoTabela('MCU_CODCLI', 'MOVCUP', ['MCU_NUMDOC', 'MCU_CODEMP', 'MCU_ESPDOC'],
                                                                            [edtNumDoc.Text, edtCodEmp.Text, edtEspDoc.Text]);
     End;

     If teqTipEtq In [tpeOrdProImobiliaria, tpeOrdProAutomotiva] Then
     Begin
       If Pos(edtEspDoc.Text, 'PD_OR_') > 0 Then
       Begin
         strCliente := fCampoTabela('FDO_CODCLI', 'TINDOR', ['FDO_NUMDOC', 'FDO_CODEMP', 'FDO_ESPDOC'],
          [edtNumDoc.Text, edtCodEmp.Text, edtEspDoc.Text]);
       End
       Else
       Begin
         strCliente := fCampoTabela('DET_CODCLI', 'TINDET', ['DET_NUMDOC', 'DET_CODEMP', 'DET_ESPDOC'],
          [edtNumDoc.Text, edtCodEmp.Text, edtEspDoc.Text]);
       End;
     End;

     If teqTipEtq In [tpePedidoCompra] Then
     Begin
       strCliente := fCampoTabela('PCG_CODFOR', 'PCMGER', ['PCG_NUMPED', 'PCG_CODEMP', 'PCG_ESPDOC', 'PCG_BAIXAD', 'IFNULL(PCG_DOCORI, "")'],
          [edtNumDoc.Text, edtCodEmp.Text, edtEspDoc.Text, '0', '']);
     End;

     If teqTipEtq In [tpeCupomPromocao] Then
     Begin

       If Pos(edtEspDoc.Text, 'NF_IF_FF') > 0 then
       begin
         strCliente := fCampoTabela('GER_CODCLI', 'MOVGER', ['GER_CODEMP', 'GER_NUMDOC', 'GER_ESPDOC'], [edtCodEmp.Text, edtNumDoc.Text, edtEspDoc.Text], False);
       end
       else

       If Pos(edtEspDoc.Text, 'PD') > 0 then
       begin
         strCliente := fCampoTabela('FGO_CODCLI', 'FATGOR', ['FGO_CODEMP', 'FGO_NUMDOC', 'FGO_ESPDOC'], [edtCodEmp.Text, edtNumDoc.Text, edtEspDoc.Text], False);
       end;

     end;

     If teqTipEtq In [tpeSolicitacaoManutencaoEquipamentos] Then
     Begin
       strCliente := fCampoTabela('MEI_CODIGO', 'MNEQIG', ['MEI_CODIGO', 'MEI_CODEMP'],
          [edtNumDoc.Text, edtCodEmp.Text]);
     End;

     If teqTipEtq In [tpeRemessaDevolucao] Then
     Begin
       strCliente := fCampoTabela('RMV_NUMREM', 'REMDEV', ['RMV_NUMREM', 'RMV_EMPREM', 'RMV_ESPREM'],
          [edtNumDoc.Text, edtCodEmp.Text, edtEspDoc.Text]);
     End;

     If fEmptyStr(strCliente) and (not (teqTipEtq  in [tpeContGRBaixa, tpeSeparacaoGondola])) Then
     Begin
       fMensagem('', 'Documento não encontrado!', ['&O k']);
       Result := False;
     End

     Else Result := True;

     If Result and (teqTipEtq In [tpeSolicitacaoManutencaoEquipamentos]) Then
       strCliente := '';
   End;

begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin

    If (Sender = edtNumDoc) Then
    Begin

      If fEmptyStr(edtNumDoc.Text) And edtNumDoc.Visible Then
      Begin
        fMensagem('', 'Informe o código do Documento!', ['&O k']);
        Result := False;
      End Else
      Begin

        If edtEspDoc.ReadOnly Then
          Result := fDocumentoExiste;
      End;

    End

    Else If (Sender = mskDtaCad) Then
    Begin
      If (mskDtaCad.Visible) And (strToDateDef(mskDtaCad.Text, 0) = 0) Then
      Begin
        fMensagem('ATENÇÃO!', mskDtaCad.Text + ' não é uma data válida!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtEspDoc) Then
    Begin

      If Not edtEspDoc.ReadOnly Then
        Result := fDocumentoExiste;

     End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmPedeMIFF.mskDtaCadExit(Sender: TObject);
begin
  inherited;
  fValidaCampos(mskDtaCad, True);
end;

procedure TfrmPedeMIFF.mskDtaCadKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If Key = VK_RETURN Then
    SelectNext(ActiveControl, True, True)
end;

end.
