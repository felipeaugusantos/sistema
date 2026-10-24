unit untTBoxEntrega;

interface

uses System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls,
  Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons, Vcl.ImgList, Math,
  Uni, Data.DB, EditFocus, System.UITypes, Vcl.Menus, untFuncFat, untConstantes;

Type
  TTipoBotao     = (tbDocumento, tbSetaAcima, tbSetaAbaixo, tbVago, tbRemover);
  TTipoOrdenacao = (toBox, toCliente);
  TTipoOperacao  = (topRetira, topEntregaImediata);

  TBoxDisponiveis = Array of Integer;

  TDocumentoBox = Record
    strNomCli1 : String;
    strNomCli2 : String;
    strDocOri  : String;
    strEspOri  : String;
    strCodCli  : String;
    dteDataEnt : TDateTime;
    horHoraEnt : TDateTime;
    strCodCnd  : String;
    strConPag  : String;
    strCondPag : String;
    fltValorDoc: Double;
    fltValorEnt: Double;
    intNroBox  : Integer;
    strNumDoc  : String;
    strEspDoc  : String;
    tbTpBotao  : TTipoBotao;
    btnDoc     : TSpeedButton;
    shpDoc     : TShape;
    lblDoc     : TLabel;
    popPend    : TPopupMenu;
    mnuMenu    : TMenuItem;
  End;

  TDocumentosBox = Array of Array of Array of TDocumentoBox;

  TIdentificadorBoxDisponivel = class(TComponent)
  private

    FFatVenda : TFatVenda;

    procedure pRetornaListaDeBoxUtilizados(var stlBox : TStringList; strEntRet : String);
    function fRetornaBoxLivre_Retira          : Integer;
    function fRetornaBoxLivre_EntregaImediata : Integer;
  public
    Constructor Create(objFatVenda : TFatVenda); reintroduce;
    function fRetornarBoxLivre : Integer;
  end;

  TDocumentoBoxEntrega = class(TComponent)
    Const
      iBorder     = 1;
      iWidth      = 180;
      iHeight     = 117;
      iMinLinhas  = 3;
      iGrupos     = 1;
      iMinColunas = 3;

      idxCorLivre = 0;
      idxCorPrazoSemEnt = 1;
      idxCorPrazoComEnt = 2;
      idxCorVista = 3;

  private

    FTipoOperacao : TTipoOperacao;

    FDocumentos: TDocumentosBox;

    FQtdeDocumentos,
    FLinhasGrupo,
    FQtdePaginas,
    FQtdLinhaTotal,
    FQtdColunaTotal,
    FPaginaAtual: Integer;

    FCores: Array of TColor;

    FParent: TPanel;
    FImagemSetas: TImageList;

    FOrdenacao: TTipoOrdenacao;

    procedure pCriarMatrizDocumentos;
    procedure pCriarBotoes(matriz: TDocumentosBox);
    procedure pLimparPanelBotoes(var matriz: TDocumentosBox; qtdPaginas: Integer); overload;
    procedure pLimparPanelBotoes; overload;
    procedure pEventoClick(Sender: TObject);
    procedure pEventoSetaAcimaClick(Sender: TObject);
    procedure pEventoSetaAbaixoClick(Sender: TObject);
    function  fPossuiDocumentos: Boolean;
    function pLiberarBoxEntrega(intBoxEntrega: Integer): Boolean;
    function fVerificarBoxMesmoCliente(strCodCli: String; intNroBox: Integer): String;
    function fRecuperarDocumento(intNroBox: Integer): TDocumentoBox;
    procedure pLimparRecordDocumento(documento: TDocumentoBox);
    function fDocumentoPago(recDocumento: TDocumentoBox): Boolean;
    procedure pEventoClickPopupMenuItem(Sender: TObject);
    function fRetornarListaBoxLivre: TBoxDisponiveis;
  public
    Constructor Create(Owner           : TComponent;
                       var Panel       : TPanel;
                       var ImagemSetas : TImageList;
                       TipoOperacao    : TTipoOperacao); reintroduce;

    function fRetornaSQLWhereOperacao : String;
    function fEhOperacaoDeRetira      : Boolean;

    procedure pDesenharPanelBotoes(intPaginaAtual: Integer; toTipoOrdem: TTipoOrdenacao = toBox);
    procedure pRemoverBotoes;
    procedure pReiniciarPaginas;

    property bPossuiItens: Boolean Read fPossuiDocumentos;
    property intQtdePaginas   : Integer Read FQtdePaginas;
    property intLinhasGrupo   : Integer Read FLinhasGrupo;
    property intQtdColunaTotal: Integer Read FQtdColunaTotal;
    property arrDocumentos: TDocumentosBox Read FDocumentos;
  end;

implementation

{ TDocumentoBoxEntrega }

uses untFuncoesSimples, untTypesSistema,
  untLiberacao, untFuncoesRel, untFuncoesRel2;

constructor TDocumentoBoxEntrega.Create(Owner           : TComponent;
                                        var Panel       : TPanel;
                                        var ImagemSetas : TImageList;
                                        TipoOperacao    : TTipoOperacao);
begin

  inherited Create(Owner);

  FTipoOperacao := TipoOperacao;

  SetLength(FCores, 4);

  FCores[idxCorLivre]       := fCfgSis(IIF(fEhOperacaoDeRetira, 'BOXLIV', 'BEILIV'), varInteger);
  FCores[idxCorPrazoSemEnt] := fCfgSis(IIF(fEhOperacaoDeRetira, 'BOXPRA', 'BEIPRA'), varInteger);
  FCores[idxCorPrazoComEnt] := fCfgSis(IIF(fEhOperacaoDeRetira, 'BOXPRE', 'BEIPRE'), varInteger);
  FCores[idxCorVista]       := fCfgSis(IIF(fEhOperacaoDeRetira, 'BOXVIS', 'BEIVIS'), varInteger);

  FParent      := Panel;
  FImagemSetas := ImagemSetas;
  
  FQtdLinhaTotal  := Trunc(Panel.Height / (iHeight + (iBorder * 1)));
  FQtdColunaTotal := Trunc(Panel.Width  / (iWidth  + (iBorder * 1)));
  FLinhasGrupo    := Trunc(FQtdLinhaTotal / iGrupos);

  FPaginaAtual    := 0;
  FQtdeDocumentos := 0;
  FOrdenacao      := toBox;

  If (FQtdLinhaTotal >= iMinLinhas) And (FQtdColunaTotal >= iMinColunas) Then Begin
    pCriarMatrizDocumentos();
  End
  Else
  Begin
    fMensagem('ALERTA', 'Resolução da tela não comporta os requisitos mínimos para criação dos ' +
      'atalhos de Box de Entrada dos documentos de venda!', ['&Ok']);
  End;
end;

procedure TDocumentoBoxEntrega.pCriarBotoes(matriz: TDocumentosBox);
  var
    i, j, k: Integer;
    imagem : TBitmap;

  function fCriarSpeedButton(documento: TDocumentoBox): TSpeedButton;
  begin
    Result := TSpeedButton.Create(FParent);
    Result.Height  := iHeight;
    Result.Width   := iWidth;
    Result.Flat    := True;
    Result.Font.Color := clHighlightText;
    Result.Font.Size  := 10;
    Result.ShowHint   := False;

    Case (documento.tbTpBotao) Of
      tbDocumento: Begin
                     Result.Tag        := documento.intNroBox;
                     Result.OnClick    := pEventoClick;
                     Result.PopupMenu  := documento.popPend;
                   End;

      tbSetaAcima,
      tbSetaAbaixo: Begin
                      Result.Tag  := 0;

                      imagem := TBitmap.Create;

                      If (documento.tbTpBotao = tbSetaAcima) Then
                      Begin
                        If (FLinhasGrupo > 1) Then
                        Begin
                          Result.OnClick := pEventoSetaAcimaClick;
                          FImagemSetas.GetBitmap(0, imagem);
                        End
                        Else
                        Begin
                          Result.OnClick := pEventoSetaAbaixoClick;
                          FImagemSetas.GetBitmap(2, imagem);
                        End;
                      End
                      Else
                      Begin
                        Result.OnClick := pEventoSetaAbaixoClick;
                        FImagemSetas.GetBitmap(1, imagem);
                      End;

                      Result.Glyph.Assign(imagem);
                      FreeAndNil(imagem);

                      Result.Enabled := (FQtdePaginas > 1);
                    End;

      tbVago: Result.Enabled := False;
    End;
  end;

  function pRetornarIndiceCor(strCondPag: String): Integer;
  begin
    If (strCondPag = 'À VISTA') Then
    Begin
      Result := idxCorVista;
    End
    Else
    If (strCondPag = 'A PRAZO COM ENTRADA') Then
    Begin
      Result := idxCorPrazoComEnt;
    End
    Else
    If (strCondPag = 'A PRAZO SEM ENTRADA') Then
    Begin
      Result := idxCorPrazoSemEnt;
    End
    Else
    Begin
      Result := idxCorLivre;
    End;
  end;

  function fCriarShape(documento: TDocumentoBox): TShape;
  begin
    Result := TShape.Create(FParent);
    Result.Height  := iHeight;
    Result.Width   := iWidth;
    Result.Shape   := stRectangle;

    If (Not (documento.tbTpBotao In [tbSetaAcima, tbSetaAbaixo])) Then
      Result.Brush.Color := FCores[pRetornarIndiceCor(documento.strCondPag)]
    Else
      Result.Brush.Color := clWhite;
  end;

  function fCriarLabel(documento: TDocumentoBox): TLabel;
  begin
    Result := TLabel.Create(FParent);

    Result.StyleElements := [];
    Result.ParentColor   := False;
    Result.ParentFont    := False;

    Result.Alignment  := taLeftJustify;
    Result.Font.Style := [fsBold];
    Result.Font.Name  := 'Arial';
    Result.Caption    := '[' + FormatFloat('##00', documento.intNroBox) + ']' + #13#10 +
                         IIF(fEmptyStr(documento.strNumDoc), '', 'Documento: ' + documento.strNumDoc + '-' + documento.strEspDoc) + #13#10 +
                         documento.strNomCli1 + #13#10 +
                         documento.strNomCli2 + #13#10 +
                         IIF(documento.dteDataEnt = 0, '', 'Expedido em: ' + FormatDateTime('dd/mm/yyyy' +
                           IIF(documento.horHoraEnt > 0, ' hh:mm', ''), documento.dteDataEnt + documento.horHoraEnt)) + #13#10 +
                         documento.strCondPag  + #13#10 +
                         IIF(documento.fltValorDoc = 0, '', 'Valor Total: R$ ' + FormatFloat('#,##0.00', documento.fltValorDoc)) + #13#10 +
                         IIF(documento.fltValorEnt = 0, '', 'Valor Entrada: R$ ' + FormatFloat('#,##0.00', documento.fltValorEnt));
    Result.Font.Size  := 8;

    If (fCalcularContraste(documento.shpDoc.Brush.Color, clBlack) > 125) Then
      Result.Font.Color := clBlack
    Else If (fCalcularContraste(documento.shpDoc.Brush.Color, clWhite) > 125) Then
      Result.Font.Color := clWhite
    Else
      Result.Font.Color := clBlack;
  end;

  function fCriarPopup: TPopupMenu;
  begin
    Result := TPopupMenu.Create(FParent);
    Result.AutoHotkeys := maAutomatic;
    Result.AutoPopup   := True;
    Result.TrackButton := tbRightButton;
  end;

  function fCriarPopupMenuItem(Var popMenu: TPopupMenu; documento: TDocumentoBox): TMenuItem;
  begin
    Result := TMenuItem.Create(popMenu);
    Result.Caption := 'Consultar Pedidos Pendentes';
    Result.OnClick := pEventoClickPopupMenuItem;
    Result.Visible := True;
    Result.Tag     := documento.intNroBox;
    Result.Hint    := documento.strCodCli;

    popMenu.Items.Add(Result);
  end;

begin
  For i := 0 To FQtdePaginas - 1 Do
  Begin
    For j := 0 To FLinhasGrupo - 1 Do
    Begin
      For k := 0 To FQtdColunaTotal - 1 Do
      Begin
        If (matriz[i][j][k].tbTpBotao in [tbDocumento, tbSetaAcima, tbSetaAbaixo, tbVago]) Then
        Begin
          matriz[i][j][k].popPend := fCriarPopup();
          matriz[i][j][k].mnuMenu := fCriarPopupMenuItem(matriz[i][j][k].popPend, matriz[i][j][k]);
          matriz[i][j][k].btnDoc  := fCriarSpeedButton(matriz[i][j][k]);
          matriz[i][j][k].shpDoc  := fCriarShape(matriz[i][j][k]);

          If (Not (matriz[i][j][k].tbTpBotao in [tbSetaAcima, tbSetaAbaixo])) Then
            matriz[i][j][k].lblDoc := fCriarLabel(matriz[i][j][k]);
        End;
      End;
    End;
  End;
end;

procedure TDocumentoBoxEntrega.pCriarMatrizDocumentos;
  Var
    sSQL: String;
    stlNomCli: TStringList;
    qryDocumentos: TUniQuery;

  procedure pPreencherMatrizItens(var matriz: TDocumentosBox);
    var
      i, j, k, l, idxBox: Integer;
      arrBoxDisponiveis: TBoxDisponiveis;
  begin
    FQtdeDocumentos := fCfgSis(IIF(fEhOperacaoDeRetira, 'QTDBOX', 'QTDBEI'), varInteger);

    If (FQtdeDocumentos > 0) Then
    Begin
      FQtdePaginas := Ceil(FQtdeDocumentos / (FLinhasGrupo * (FQtdColunaTotal)));

      If (FQtdePaginas > 1) Then
        FQtdePaginas := Ceil(FQtdeDocumentos / (FLinhasGrupo * (FQtdColunaTotal - 1)));
    End Else
      FQtdePaginas := 1;

    SetLength(matriz, FQtdePaginas, FLinhasGrupo, FQtdColunaTotal);

    qryDocumentos.First;

    stlNomCli := TStringList.Create();

    l := 1;

    If (FOrdenacao = toBox) Then
    Begin
      For i := 0 To FQtdePaginas - 1 Do
      Begin
        For j := 0 To FLinhasGrupo - 1 Do
        Begin
          For k := 0 To FQtdColunaTotal - 1 Do
          Begin
            If (k < FQtdColunaTotal - IIF(FQtdePaginas > 1, 1, 0)) Then
            Begin
              If (l = qryDocumentos.FieldByName('NROBOX').AsInteger) Then
              Begin
                stlNomCli.Text := WrapText(qryDocumentos.FieldByName('NOMCLI').AsString, 25);

                matriz[i][j][k].strNomCli1  := IIF(stlNomCli.Count > 0, stlNomCli[0], '');

                If (stlNomCli.Count > 1) Then
                  matriz[i][j][k].strNomCli2  := IIF(stlNomCli.Count > 1, stlNomCli[1], '')
                Else
                  matriz[i][j][k].strNomCli2  := '';

                matriz[i][j][k].strCodCli   := qryDocumentos.FieldByName('CODCLI').AsString;
                matriz[i][j][k].strDocOri   := qryDocumentos.FieldByName('DOCORI').AsString;
                matriz[i][j][k].strEspOri   := qryDocumentos.FieldByName('ESPORI').AsString;
                matriz[i][j][k].dteDataEnt  := qryDocumentos.FieldByName('DTAENT').AsDateTime;
                matriz[i][j][k].horHoraEnt  := qryDocumentos.FieldByName('HORENT').AsDateTime;
                matriz[i][j][k].strCondPag  := qryDocumentos.FieldByName('CNDPAG').AsString;
                matriz[i][j][k].fltValorDoc := qryDocumentos.FieldByName('VLRCON').AsFloat;
                matriz[i][j][k].fltValorEnt := qryDocumentos.FieldByName('VLRENT').AsFloat;
                matriz[i][j][k].intNroBox   := qryDocumentos.FieldByName('NROBOX').AsInteger;
                matriz[i][j][k].strNumDoc   := qryDocumentos.FieldByName('NUMDOC').AsString;
                matriz[i][j][k].strEspDoc   := qryDocumentos.FieldByName('ESPDOC').AsString;
                matriz[i][j][k].strCodCnd   := qryDocumentos.FieldByName('CODCND').AsString;
                matriz[i][j][k].strConPag   := qryDocumentos.FieldByName('CONPAG').AsString;
                matriz[i][j][k].tbTpBotao   := tbDocumento;

                qryDocumentos.Next;

                l := l + 1;
              End
              Else
              Begin
                pLimparRecordDocumento(matriz[i][j][k]);
                matriz[i][j][k].intNroBox := l;

                If (l <= FQtdeDocumentos) Then
                  matriz[i][j][k].tbTpBotao := tbVago
                Else
                  matriz[i][j][k].tbTpBotao := tbRemover;

                l := l + 1;
              End;
            End
            Else
            Begin
              pLimparRecordDocumento(matriz[i][j][k]);

              If (j In [0 ,1]) And (FQtdePaginas > 1) Then
              Begin
                matriz[i][j][k].tbTpBotao := IIF(j = 0, tbSetaAcima, tbSetaAbaixo);
              End
              Else
              Begin
                matriz[i][j][k].tbTpBotao := tbRemover;
              End;
            End;

            matriz[i][j][k].btnDoc  := nil;
            matriz[i][j][k].shpDoc  := nil;
            matriz[i][j][k].lblDoc  := nil;
            matriz[i][j][k].popPend := nil;
          End;
        End;
      End;
    End
    Else
    Begin
      idxBox := 0;
      arrBoxDisponiveis := fRetornarListaBoxLivre();

      For i := 0 To FQtdePaginas - 1 Do
      Begin
        For j := 0 To FLinhasGrupo - 1 Do
        Begin
          For k := 0 To FQtdColunaTotal - 1 Do
          Begin
            If (k < FQtdColunaTotal - IIF(FQtdePaginas > 1, 1, 0)) Then
            Begin
              If (l <= qryDocumentos.RecordCount) Then
              Begin
                stlNomCli.Text := WrapText(qryDocumentos.FieldByName('NOMCLI').AsString, 25);

                matriz[i][j][k].strNomCli1  := IIF(stlNomCli.Count > 0, stlNomCli[0], '');

                If (stlNomCli.Count > 1) Then
                  matriz[i][j][k].strNomCli2  := IIF(stlNomCli.Count > 1, stlNomCli[1], '')
                Else
                  matriz[i][j][k].strNomCli2  := '';

                matriz[i][j][k].strCodCli   := qryDocumentos.FieldByName('CODCLI').AsString;
                matriz[i][j][k].strDocOri   := qryDocumentos.FieldByName('DOCORI').AsString;
                matriz[i][j][k].strEspOri   := qryDocumentos.FieldByName('ESPORI').AsString;
                matriz[i][j][k].dteDataEnt  := qryDocumentos.FieldByName('DTAENT').AsDateTime;
                matriz[i][j][k].horHoraEnt  := qryDocumentos.FieldByName('HORENT').AsDateTime;
                matriz[i][j][k].strCondPag  := qryDocumentos.FieldByName('CNDPAG').AsString;
                matriz[i][j][k].fltValorDoc := qryDocumentos.FieldByName('VLRCON').AsFloat;
                matriz[i][j][k].fltValorEnt := qryDocumentos.FieldByName('VLRENT').AsFloat;
                matriz[i][j][k].intNroBox   := qryDocumentos.FieldByName('NROBOX').AsInteger;
                matriz[i][j][k].strNumDoc   := qryDocumentos.FieldByName('NUMDOC').AsString;
                matriz[i][j][k].strEspDoc   := qryDocumentos.FieldByName('ESPDOC').AsString;
                matriz[i][j][k].strCodCnd   := qryDocumentos.FieldByName('CODCND').AsString;
                matriz[i][j][k].strConPag   := qryDocumentos.FieldByName('CONPAG').AsString;
                matriz[i][j][k].tbTpBotao   := tbDocumento;

                qryDocumentos.Next;

                l := l + 1;
              End
              Else
              Begin
                pLimparRecordDocumento(matriz[i][j][k]);

                If (l <= FQtdeDocumentos) Then
                Begin
                  matriz[i][j][k].intNroBox := arrBoxDisponiveis[idxBox];
                  Inc(idxBox);

                  matriz[i][j][k].tbTpBotao := tbVago
                End Else
                  matriz[i][j][k].tbTpBotao := tbRemover;

                l := l + 1;
              End;
            End
            Else
            Begin
              pLimparRecordDocumento(matriz[i][j][k]);

              If (j In [0 ,1]) And (FQtdePaginas > 1) Then
              Begin
                matriz[i][j][k].tbTpBotao := IIF(j = 0, tbSetaAcima, tbSetaAbaixo);
              End
              Else
              Begin
                matriz[i][j][k].tbTpBotao := tbRemover;
              End;
            End;

            matriz[i][j][k].btnDoc  := nil;
            matriz[i][j][k].shpDoc  := nil;
            matriz[i][j][k].lblDoc  := nil;
            matriz[i][j][k].popPend := nil;
          End;
        End;
      End;
    End;

    FreeAndNil(stlNomCli);
    pCriarBotoes(matriz);
  end;

begin
  Try
    sSQL := 'SELECT ';
    sSQL := sSQL + '  GER_NOMCON AS NOMCLI, ';
    sSQL := sSQL + '  GER_CODCLI AS CODCLI, ';
    sSQL := sSQL + '  GER_DTLBEX AS DTAENT, ';
    sSQL := sSQL + '  GER_HRLBEX AS HORENT, ';
    sSQL := sSQL + '  GER_CODCND AS CODCND, ';
    sSQL := sSQL + '  GER_CONPAG AS CONPAG, ';
    sSQL := sSQL + '  IF( ';
    sSQL := sSQL + '    GER_CONPAG = "01000", ';
    sSQL := sSQL + '    "À VISTA", ';
    sSQL := sSQL + '    IF( ';
    sSQL := sSQL + '      GER_CONPAG <> "01000" ';
    sSQL := sSQL + '      AND SUBSTR(GER_CONPAG, 3, 3) = "000", ';
    sSQL := sSQL + '      "A PRAZO COM ENTRADA", ';
    sSQL := sSQL + '      "A PRAZO SEM ENTRADA" ';
    sSQL := sSQL + '    ) ';
    sSQL := sSQL + '  ) AS CNDPAG, ';
    sSQL := sSQL + '  GER_VLRCON AS VLRCON, ';
    sSQL := sSQL + '  GER_NROBOX AS NROBOX, ';
    sSQL := sSQL + '  GER_NUMDOC AS NUMDOC, ';
    sSQL := sSQL + '  GER_ESPDOC AS ESPDOC, ';
    sSQL := sSQL + '  SUM(IF((GER_CONPAG <> "01000") AND SUBSTR(GER_CONPAG, 3, 3) = "000", ';
    sSQL := sSQL + '    IFNULL(CTR_VALORI, 0), 0)) AS VLRENT, ';
    sSQL := sSQL + '  FGO_NUMDOC AS DOCORI, ';
    sSQL := sSQL + '  FGO_ESPDOC AS ESPORI ';
    sSQL := sSQL + 'FROM ';
    sSQL := sSQL + '  MOVGER ';
    sSQL := sSQL + '  LEFT JOIN CADCLI ';
    sSQL := sSQL + '    ON GER_CODCLI = CLI_CODCLI ';
    sSQL := sSQL + '  LEFT JOIN CADCND ';
    sSQL := sSQL + '    ON GER_CODCND = CND_CODIGO ';
    sSQL := sSQL + '  LEFT JOIN CADREC ';
    sSQL := sSQL + '    ON CTR_NUMDUP = GER_NUMDOC ';
    sSQL := sSQL + '   AND CTR_PARCEL = "A" ';
    sSQL := sSQL + '   AND CTR_ESPDOC = GER_ESPDOC ';
    sSQL := sSQL + '   AND CTR_CODCLI = GER_CODCLI ';
    sSQL := sSQL + '   AND CTR_CODEMP = GER_CODEMP ';
    sSQL := sSQL + '   AND CTR_VALDUP = 0 ';
    sSQL := sSQL + '  LEFT JOIN FATGOR ';
    sSQL := sSQL + '    ON FGO_NUMFAT = GER_NUMDOC ';
    sSQL := sSQL + '   AND FGO_TIPFAT = GER_ESPDOC ';
    sSQL := sSQL + '   AND FGO_CODCLI = GER_CODCLI ';
    sSQL := sSQL + '   AND FGO_CODEMP = GER_CODEMP ';
    sSQL := sSQL + 'WHERE GER_NROBOX > 0 AND GER_CODEMP = :CODEMP ';

    If (fEhOperacaoDeRetira) Then
      sSQL := sSQL + '  AND GER_ENTFAT <> "S" '
    Else
      sSQL := sSQL + '  AND GER_ENTFAT = "S" AND GER_ENTFUT <> "S" ';

    sSQL := sSQL + 'GROUP BY GER_NROBOX ';

    If (FOrdenacao = toBox) Then
      sSQL := sSQL + 'ORDER BY GER_NROBOX '
    Else
      sSQL := sSQL + 'ORDER BY GER_NOMCON, GER_ESPDOC, GER_NUMDOC ';

    Try
      qryDocumentos := fCriaQuery();

      qryDocumentos.Close();
      qryDocumentos.SQL.Clear();
      qryDocumentos.SQL.Text := sSQL;
      qryDocumentos.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryDocumentos.Open;

      FDocumentos     := nil;
      FQtdeDocumentos := 0;

      pPreencherMatrizItens(FDocumentos);
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TDocumentoBoxEntrega.pCriarMatrizDocumentos]');
      End;
    End;
  Finally
    FreeAndNil(qryDocumentos);
  End;
end;

function TDocumentoBoxEntrega.fDocumentoPago(recDocumento: TDocumentoBox): Boolean;
  Var
    qryAux: TUniQuery;
begin
  Try
    Result := False;

    Try
      qryAux := fCriaQuery();
      qryAux.SQL.Clear();
      qryAux.SQL.Add('SELECT');
      qryAux.SQL.Add('  AUTOINCREM');
      qryAux.SQL.Add('FROM');
      qryAux.SQL.Add('  CADREC');
      qryAux.SQL.Add('WHERE CTR_NUMDUP = :NUMDOC');
      qryAux.SQL.Add('  AND CTR_ESPDOC = :ESPDOC');
      qryAux.SQL.Add('  AND CTR_CODEMP = :CODEMP');
      qryAux.SQL.Add('  AND CTR_CODCLI = :CODCLI');
      qryAux.SQL.Add('  AND CTR_SEQBAI = 0');
      qryAux.SQL.Add('  AND CTR_VALDUP = 0');
      qryAux.SQL.Add('  AND CTR_DTABAI IS NOT NULL');

      If (recDocumento.strCondPag <> 'À VISTA') Then
        qryAux.SQL.Add('  AND CTR_PARCEL = "A"');

      qryAux.ParamByName('NUMDOC').AsString  := recDocumento.strNumDoc;
      qryAux.ParamByName('ESPDOC').AsString  := recDocumento.strEspDoc;
      qryAux.ParamByName('CODEMP').AsString  := VS_strCodEmp;
      qryAux.ParamByName('CODCLI').AsString  := recDocumento.strCodCli;

      qryAux.Open();

      Result := (Not qryAux.IsEmpty);
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TDocumentoBoxEntrega.fDocumentoPago]');
    End;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function TDocumentoBoxEntrega.fEhOperacaoDeRetira: Boolean;
begin
  Result := (FTipoOperacao = topRetira);
end;

function TDocumentoBoxEntrega.fPossuiDocumentos: Boolean;
begin
  Result := (FQtdeDocumentos > 0);
end;

function TDocumentoBoxEntrega.fRecuperarDocumento(intNroBox: Integer): TDocumentoBox;
  Var
      i, j, k: Integer;
begin
  pLimparRecordDocumento(Result);

  If (intNroBox > FQtdeDocumentos) Then
    Exit;

  For i := 0 To FQtdePaginas - 1 Do
    For j := 0 To FLinhasGrupo - 1 Do
      For k := 0 To FQtdColunaTotal - 1 Do
        If (FDocumentos[i][j][k].intNroBox = intNroBox) Then
        Begin
          Result := FDocumentos[i][j][k];
          Exit;
        End;
end;

constructor TIdentificadorBoxDisponivel.Create(objFatVenda : TFatVenda);
begin
  inherited Create(objFatVenda);
  FFatVenda := objFatVenda;
end;

function TIdentificadorBoxDisponivel.fRetornaBoxLivre_EntregaImediata: Integer;
  Var
    i         : Integer;
    intBoxDis : Integer;
    stlBox    : TStringList;
begin

  Result := SEM_BOX_DISPONIVEL;

  Try

    Try

      stlBox := TStringList.Create();

      pRetornaListaDeBoxUtilizados(stlBox, 'E');

      If (stlBox.Count <= 0) Then
        Exit(PRIMEIRO_BOX_DISPONIVEL);

      For i := 1 To fCfgSis('QTDBEI', varInteger) Do
      Begin
        intBoxDis := i;

        If (Not ((i <= stlBox.Count) And (StrToInt(stlBox[i - 1]) = i))) Then
        Begin
          Result := intBoxDis;
          Break;
        End;

      End;

    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TDocumentoBoxEntrega.fRetornaBoxLivre_EntregaImediata]');
    End;

  Finally
    FreeAndNil(stlBox);
  End;

end;

function TIdentificadorBoxDisponivel.fRetornaBoxLivre_Retira: Integer;
  Var
    i         : Integer;
    intBoxDis : Integer;
    stlBox    : TStringList;
begin

  Result := SEM_BOX_DISPONIVEL;

  Try

    Try

      stlBox := TStringList.Create();

      pRetornaListaDeBoxUtilizados(stlBox, 'R');

      If (stlBox.Count <= 0) Then
        Exit(PRIMEIRO_BOX_DISPONIVEL);

      For i := 1 To fCfgSis('QTDBOX', varInteger) Do
      Begin
        intBoxDis := i;

        If (Not ((i <= stlBox.Count) And (StrToInt(stlBox[i - 1]) = i))) Then
        Begin
          Result := intBoxDis;
          Break;
        End;

      End;

    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TDocumentoBoxEntrega.fRetornaBoxLivre_Retira]');
    End;

  Finally
    FreeAndNil(stlBox);
  End;

end;

function TIdentificadorBoxDisponivel.fRetornarBoxLivre : Integer;

  function fUtilizaControleDeBox_Retira : Boolean;
  begin

    Result := False;

    If Not (fCfgSis('USABOX', varBoolean)) Then
      Exit;

    If Not (FFatVenda.strOpcDoc <> 'CF') Then
      Exit;

    If Not (Pos(FFatVenda.strEspDoc, 'NF_FF_IF_') > 0) Then
      Exit;

    If Not (FFatVenda.fPossuiSomenteItensRetira()) Then
      Exit;

    If Not (Pos(FFatVenda.strClafis, fCfgSis('CLAVEN', varString)) > 0) Then
      Exit;

    Result := True;

  end;

  function fUtilizaControleDeBox_EntregaImediata : Boolean;
  begin

    Result := False;

    If Not (fCfgSis('USABEI', varBoolean)) Then
      Exit;

    If Not (FFatVenda.strOpcDoc <> 'CF') Then
      Exit;

    If Not (Pos(FFatVenda.strEspDoc, 'NF_FF_IF_') > 0) Then
      Exit;

    If Not (FFatVenda.fSomenteItensEntregaImediata()) Then
      Exit;

    If Not (Pos(FFatVenda.strClafis, fCfgSis('CLAVEN', varString)) > 0) Then
      Exit;

    If Not (fCampoTabela('TRA_UTIBOX', 'CADTRA', ['TRA_CODTRA'], [FFatVenda.strCodTra]) = 'S') Then
      Exit;

    Result := True;

  end;

begin

  Result := NAO_UTILIZA_BOX;

  if not fUtilizaControleDeBox_Retira then
    if not fUtilizaControleDeBox_EntregaImediata then
      Exit;

  Try

    Try
      if not fLock_Unlock(CONTROLE_BOX_MOVGER, True, True, True, '', False) then
        Result := SEM_BOX_DISPONIVEL
      else if fUtilizaControleDeBox_Retira then
        Result := fRetornaBoxLivre_Retira
      else if fUtilizaControleDeBox_EntregaImediata then
        Result := fRetornaBoxLivre_EntregaImediata;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TFatVenda.fRetornarBoxLivre]');
    End;

  Finally
    If (Result <= SEM_BOX_DISPONIVEL) Then
      fLock_Unlock(CONTROLE_BOX_MOVGER, False, False);
  End;

end;

function TDocumentoBoxEntrega.fRetornarListaBoxLivre: TBoxDisponiveis;
  Var
    i, j: Integer;
    qryAux: TUniQuery;

  procedure pInicializarQuery;
  begin
    qryAux := fCriaQuery(Self);
    qryAux.Close();
    qryAux.SQL.Add('SELECT GER_NROBOX AS NROBOX');
    qryAux.SQL.Add('FROM MOVGER');
    qryAux.SQL.Add('WHERE GER_NROBOX > 0 AND GER_CODEMP = :CODEMP');

    If (fEhOperacaoDeRetira) Then
      qryAux.SQL.Add('AND GER_ENTFAT <> "S"')
    Else
      qryAux.SQL.Add('AND GER_ENTFAT = "S" AND GER_ENTFUT <> "S"');

    qryAux.SQL.Add('ORDER BY GER_NROBOX');
    qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryAux.Open();
    qryAux.First();
  end;
begin

  Try
    pInicializarQuery();

    i := qryAux.RecordCount;
    j := fCfgSis(IIF(fEhOperacaoDeRetira, 'QTDBOX', 'QTDBEI'), varInteger);
    SetLength(Result, (j - i));

    j := 0;

    For i := 1 To fCfgSis(IIF(fEhOperacaoDeRetira, 'QTDBOX', 'QTDBEI'), varInteger) Do
    Begin
      If (Not qryAux.Locate('NROBOX', i, [])) Then
      Begin
        Result[j] := i;
        Inc(j);
      End;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TDocumentoBoxEntrega.fRetornarListaBoxLivre]');
  End;
end;

function TDocumentoBoxEntrega.fRetornaSQLWhereOperacao: String;
Const
  RETIRA           = ' GER_ENTFAT <> "S" ';
  ENTREGA_IMEDIATA = ' GER_ENTFAT = "S" AND GER_ENTFUT <> "S" ';
begin
  Result := IIF(fEhOperacaoDeRetira, RETIRA, ENTREGA_IMEDIATA);
end;

function TDocumentoBoxEntrega.fVerificarBoxMesmoCliente(strCodCli: String;
  intNroBox: Integer): String;
  var
    i, j, k: Integer;
begin
  Result := '';

  For i := 0 To FQtdePaginas - 1 Do
  Begin
    For j := 0 To FLinhasGrupo - 1 Do
    Begin
      For k := 0 To FQtdColunaTotal - 1 Do
      Begin
        If (FDocumentos[i][j][k].strCodCli = strCodCli) And (FDocumentos[i][j][k].intNroBox <> intNroBox) Then
          Result := Result + FormatFloat('##00', FDocumentos[i][j][k].intNroBox) + ', ';
      End;
    End;
  End;

  If (Not fEmptyStr(Result)) Then
    Result := Copy(Result, 1, Length(Result) - 2);
end;

procedure TDocumentoBoxEntrega.pDesenharPanelBotoes(intPaginaAtual: Integer; toTipoOrdem: TTipoOrdenacao = toBox);
  var
    i, j, k, l, grupos: Integer;

  procedure pAjustarComponentes(var matriz: TDocumentosBox; m, n, o, p: Integer);
  begin
    //PopupMenu
    If (Assigned(matriz[m][n][p].popPend)) Then
    Begin
      matriz[m][n][p].popPend.Items[0].Visible := True;
    End;

    //Shape
    If (Assigned(matriz[m][n][p].shpDoc)) Then
    Begin
      matriz[m][n][p].shpDoc.Top     := (iBorder * (o + 1)) + (iHeight * o);
      matriz[m][n][p].shpDoc.Left    := (iBorder * (p + 1)) + (iWidth  * p);
      matriz[m][n][p].shpDoc.Visible := (Not (matriz[m][n][p].tbTpBotao = tbRemover));
      matriz[m][n][p].shpDoc.SetParentComponent(FParent);
    End;

    //Label
    If (Assigned(matriz[m][n][p].lblDoc)) Then
    Begin
      matriz[m][n][p].lblDoc.Top     := (iBorder * (o + 1)) + (iHeight * o) + Trunc((iHeight - matriz[m][n][p].lblDoc.Height) / 2);
      matriz[m][n][p].lblDoc.Left    := (iBorder * (p + 1)) + (iWidth  * p) + 5;
      matriz[m][n][p].lblDoc.Visible := (Not (matriz[m][n][p].tbTpBotao = tbRemover));
      matriz[m][n][p].lblDoc.SetParentComponent(FParent);
    End;

    //Buttons
    If (Assigned(matriz[m][n][p].btnDoc)) Then
    Begin
      matriz[m][n][p].btnDoc.Top     := (iBorder * (o + 1)) + (iHeight * o);
      matriz[m][n][p].btnDoc.Left    := (iBorder * (p + 1)) + (iWidth  * p);
      matriz[m][n][p].btnDoc.Visible := (Not (matriz[m][n][p].tbTpBotao = tbRemover));
      matriz[m][n][p].btnDoc.SetParentComponent(FParent);
    End;
  end;

begin
  k := 0;

  pLimparPanelBotoes();
  FOrdenacao := toTipoOrdem;

  If (intPaginaAtual = -1) Then
    pCriarMatrizDocumentos();

  grupos := iGrupos;

  For i := 0 To grupos - 1 Do
  Begin
    pLimparPanelBotoes(FDocumentos, FQtdePaginas);

    For j := 0 To FLinhasGrupo - 1 Do
    Begin
      For l := 0 To FQtdColunaTotal - 1 Do
        pAjustarComponentes(FDocumentos, IIF(intPaginaAtual = -1, FPaginaAtual, intPaginaAtual), j, k, l);

      k := k + 1;
    End;
  End;
end;

procedure TDocumentoBoxEntrega.pEventoClick(Sender: TObject);
  Var
    objDocumento: TDocumentoBox;
    strBoxMesmoCliente: String;

    function fPermissaoLiberarBoxAVista: Boolean;
      Var
        objLiberacao : TLiberacao;
    begin
      Result := True;

      If (Not fVerificaAcessoSistema('LIBBXVI')) Then
      Begin
        objLiberacao := Tliberacao.Create;
        try
          objLiberacao.objMsgLibera.pAddTexto('Box de Entrega - Liberar documento à vista que ainda não quitado.');
          objLiberacao.objMsgLibera.pAddTextoCaption('Cliente'       , objDocumento.strCodCli+'-'+objDocumento.strNomCli1                 , 13);
          objLiberacao.objMsgLibera.pAddTextoCaption('Documento'     , objDocumento.strNumDoc+'-'+objDocumento.strEspDoc+'-'+VS_strCodEmp , 13);
          objLiberacao.objMsgLibera.pAddTextoCaption('Cond. Pgto'    , objDocumento.strCodCnd+'-'+fFormataCondPag(objDocumento.strConPag) , 13);
          objLiberacao.objMsgLibera.pAddTextoCaption('Valor Total'   , FormatFloat('#,##0.00', objDocumento.fltValorDoc)                  , 13);
          objLiberacao.objMsgLibera.pAddTextoCaption('Número do Box' , '[' + FormatFloat('##00', objDocumento.intNroBox) + ']'            , 13);

          objLiberacao.strDirAce := 'LIBBXVI';
          objLiberacao.strMsgSen := 'Box de Entrega - Liberar documento à vista que ainda não quitado.';
          objLiberacao.strCodOpe := strLoginUsuarioLogado;

          Result := objLiberacao.fLibera;
        finally
          FreeAndNil(objLiberacao);
        end;
      End;
    End;

begin
  objDocumento := fRecuperarDocumento(TSpeedButton(Sender).Tag);

  If (Not fEmptyStr(objDocumento.strCodCli)) Then
  Begin

    If (objDocumento.strCondPag = 'À VISTA') Or (objDocumento.strCondPag = 'A PRAZO COM ENTRADA') Then
    Begin
      If (Not fDocumentoPago(objDocumento)) Then
      Begin
        If (objDocumento.strCondPag = 'À VISTA') Then
        Begin
          If (Not fPermissaoLiberarBoxAVista) Then
          Begin
            pMensagemOk('Operador sem direito de acesso para liberar documento à vista não quitado!');
            Exit;
          End;
        End
        Else If (objDocumento.strCondPag = 'A PRAZO COM ENTRADA') Then
        Begin
          pMensagemOk('Entrada do documento não está quitada, verifique!');
          Exit;
        End;
      End;
    End;

    strBoxMesmoCliente := fVerificarBoxMesmoCliente(objDocumento.strCodCli, objDocumento.intNroBox);

    If (Not fEmptyStr(strBoxMesmoCliente)) Then
      fMensagem('AVISO', 'Cliente possui documento(s) pendente(s) no(s) Box: ' + strBoxMesmoCliente + '.', ['&OK']);

    If (fMensagem('CONFIRMAÇÃO', 'Deseja realizar a entrega do Box ' + IntToStr(objDocumento.intNroBox) + '?', ['&Sim', '&Não']) = 1) Then
    Begin
      If (pLiberarBoxEntrega(objDocumento.intNroBox)) Then
      Begin
        fMensagem('AVISO', 'Box de entrega liberado com sucesso!', ['&OK']);
        pDesenharPanelBotoes(-1, FOrdenacao);
      End;
    End;
  End;
end;

procedure TDocumentoBoxEntrega.pEventoClickPopupMenuItem(Sender: TObject);
begin

  If (fEmptyStr(TMenuItem(Sender).Hint)) Then Begin
    fMensagem('ALERTA', 'Nenhum Box de Entrega foi selecionado para consultar o cliente relacionado!', ['&OK']);
    Exit;
  End;

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(193, 7488, [7489],
                        ['CODCLI'],
                        [TMenuItem(Sender).Hint],
                        Sender,
                        nil,
                        True);
  End;

end;

procedure TDocumentoBoxEntrega.pEventoSetaAbaixoClick(Sender: TObject);
  procedure pAtualizaIndice(var paginaAtual: Integer; qtdPaginas: Integer);
  begin
    If ((paginaAtual + 1) > (qtdPaginas - 1)) Then
    Begin
      paginaAtual := 0;
    End
    Else
    Begin
      Inc(paginaAtual);
    End;
  end;
begin
  pAtualizaIndice(FPaginaAtual, FQtdePaginas);
  pDesenharPanelBotoes(FPaginaAtual, FOrdenacao);
end;

procedure TDocumentoBoxEntrega.pEventoSetaAcimaClick(Sender: TObject);
  procedure pAtualizaIndice(var paginaAtual: Integer; qtdPaginas: Integer);
  begin
    If ((paginaAtual - 1) < 0) Then
    Begin
      paginaAtual := qtdPaginas - 1;
    End
    Else
    Begin
      Dec(paginaAtual);
    End;
  end;
begin
  pAtualizaIndice(FPaginaAtual, FQtdePaginas);
  pDesenharPanelBotoes(FPaginaAtual, FOrdenacao);
end;

function TDocumentoBoxEntrega.pLiberarBoxEntrega(intBoxEntrega: Integer): Boolean;
  Var
    qryAux: TUniQuery;
begin
  Try
    Result := False;

    Try
      qryAux := fCriaQuery();
      qryAux.SQL.Clear();
      qryAux.SQL.Add('UPDATE MOVGER SET GER_NROBOX = NULL WHERE GER_NROBOX = :NROBOX AND GER_CODEMP = :CODEMP AND ' + fRetornaSQLWhereOperacao);
      qryAux.ParamByName('NROBOX').AsInteger := intBoxEntrega;
      qryAux.ParamByName('CODEMP').AsString  := VS_strCodEmp;
      qryAux.ExecSQL();

      Result := True;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TDocumentoBoxEntrega.pLiberarBoxEntrega]');
    End;
  Finally
    FreeAndNil(qryAux);
  End;
end;

procedure TDocumentoBoxEntrega.pLimparPanelBotoes;
begin
  If (Assigned(FDocumentos)) Then
    pLimparPanelBotoes(FDocumentos, FQtdePaginas);
end;

procedure TDocumentoBoxEntrega.pLimparRecordDocumento(documento: TDocumentoBox);
begin
  documento.strNomCli1  := '';
  documento.strNomCli2  := '';
  documento.strCodCli   := '';
  documento.strDocOri   := '';
  documento.strEspOri   := '';
  documento.dteDataEnt  := 0;
  documento.horHoraEnt  := 0;
  documento.strCondPag  := '';
  documento.fltValorDoc := 0;
  documento.intNroBox   := 0;
  documento.strNumDoc   := '';
  documento.strEspDoc   := '';
  documento.tbTpBotao   := tbVago;
  documento.btnDoc      := nil;
  documento.shpDoc      := nil;
  documento.lblDoc      := nil;
  documento.popPend     := nil;
end;

procedure TDocumentoBoxEntrega.pReiniciarPaginas;
begin
  FPaginaAtual := 0;
end;

procedure TDocumentoBoxEntrega.pRemoverBotoes;
begin
  pLimparPanelBotoes();
end;

procedure TIdentificadorBoxDisponivel.pRetornaListaDeBoxUtilizados(var stlBox: TStringList; strEntRet: String);
  var
    qryAux : TUniQuery;
  const
    RETIRA           = 'R';
    ENTREGA_IMEDIATA = 'E';
begin

  qryAux := fCriaQuery(Nil);

  Try

    qryAux.Close();
    qryAux.SQL.Add('SELECT GER_NROBOX AS NROBOX');
    qryAux.SQL.Add('FROM MOVGER');
    qryAux.SQL.Add('WHERE GER_NROBOX > 0 AND GER_CODEMP = :CODEMP');

    If (strEntRet.Equals(RETIRA)) Then
      qryAux.SQL.Add('AND GER_ENTFAT <> "S"')

    Else

    If (strEntRet.Equals(ENTREGA_IMEDIATA)) Then
      qryAux.SQL.Add('AND GER_ENTFAT = "S" AND GER_ENTFUT <> "S"');

    qryAux.SQL.Add('ORDER BY GER_NROBOX');
    qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryAux.Open();

    stlBox.Clear;

    qryAux.First();
    While (Not qryAux.Eof) Do
    Begin
      stlBox.Add(qryAux.FieldByName('NROBOX').AsString);
      qryAux.Next();
    End;

  Finally
    FreeAndNil(qryAux);
  End;

end;

procedure TDocumentoBoxEntrega.pLimparPanelBotoes(var matriz: TDocumentosBox; qtdPaginas: Integer);
  var
    i, j, k: Integer;
begin
  For i := 0 To qtdPaginas - 1 Do
  Begin
    For j := 0 To FLinhasGrupo - 1 Do
    Begin
      For k := 0 To FQtdColunaTotal - 1 Do
      Begin
        If (Assigned(matriz[i][j][k].btnDoc)) Then
          matriz[i][j][k].btnDoc.Visible := False;

        If (Assigned(matriz[i][j][k].shpDoc)) Then
          matriz[i][j][k].shpDoc.Visible := False;

        If (Assigned(matriz[i][j][k].lblDoc)) Then
          matriz[i][j][k].lblDoc.Visible := False;

        If (Assigned(matriz[i][j][k].popPend)) Then
          matriz[i][j][k].popPend.Items[0].Visible := False;
      End;
    End;
  End;
end;

end.
