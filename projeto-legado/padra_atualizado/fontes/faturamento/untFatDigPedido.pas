unit untFatDigPedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.StdCtrls, frxClass, Data.DB,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Uni, untFuncFat,
  System.StrUtils, BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus, UniClientDataSet;

type
  TfrmFatDigPedido = class(TfrmPaiConfirma)
    pnlDados: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    edtNumPed: TEditFocus;
    edtCodEmp: TEditFocus;
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FFatVenda: TFatVenda;
    FcdsDados: TUniClientDataSet;
    FAlterandoOrc: Boolean;
    intQtdIteTin: Integer;

    procedure pCriaClient;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    function fValidaPedido: Boolean;

    property fatVenda: TFatVenda         Read FFatVenda     Write FFatVenda;
    property cdsDados: TUniClientDataSet Read FcdsDados     Write FcdsDados;
    property blnAlterandoOrc: Boolean    Read FAlterandoOrc Write FAlterandoOrc;
  end;

var
  frmFatDigPedido: TfrmFatDigPedido;

implementation

{$R *.dfm}

uses untFuncoesSimples, untObservacao, untIFatEntregaFutura, untTFatEntregaFutura;

{ TfrmFatDigPedido }

procedure TfrmFatDigPedido.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  If intQtdIteTin > 0 Then
    fMensagem('ATENÇÃO', 'Existem itens neste pedidos que são tinta de máquina. Os mesmo não poderão ser adicionados neste orçamento!', ['&Ok']);
end;

procedure TfrmFatDigPedido.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(edtNumPed);
end;

procedure TfrmFatDigPedido.FormCreate(Sender: TObject);
begin
  inherited;

  FAlterandoOrc := False;
  edtNumPed.MaxLength := fTamDocCadRec;
  edtNumPed.TamCampo  := fTamDocCadRec;
end;

procedure TfrmFatDigPedido.FormDestroy(Sender: TObject);
begin
  inherited;

  If Assigned(FcdsDados) Then
    FreeAndNil(FcdsDados);
end;

procedure TfrmFatDigPedido.FormShow(Sender: TObject);
begin
  inherited;

  edtCodEmp.Text := VS_strCodEmp;
end;

function TfrmFatDigPedido.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If Inherited fValidaCampos(Sender, blnBuscaPorChave) Then
  Begin
    If (Sender = edtNumPed) Then
    Begin
      If fEmptyStr(edtNumPed.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'Defina um número do pedido.', ['&Ok']);
        Result := False;
      End
      Else
        Result := fValidaPedido;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmFatDigPedido.fValidaPedido: Boolean;
  Var
    strSQL: String;
    qryPed: TUniQuery;
    strMsg: String;

    blnJaFatu,
    blnJaExpe: Boolean;

    fltSaldoItemAtu: Double;
    intQtdIte: Integer;

  function fGetSQLPDReferencia: String;
  Begin
    Result := '';
    Result := Result + ' (SELECT ';
    Result := Result + '    FGO_NUMDOC ';
    Result := Result + '  FROM FATGOR ';
    Result := Result + '    JOIN EXTGOR ON (FATGOR.AUTOINCREM = EXTGOR.FGO_SEQFGO) ';
    Result := Result + '  WHERE ';
    Result := Result + '    FGO_NPDROR = :NUMDOC AND ';
    Result := Result + '    FGO_EPDROR = :CODEMP) AS FGO_NPDROR, ';

    Result := Result + ' (SELECT ';
    Result := Result + '    FGO_CODEMP ';
    Result := Result + '  FROM FATGOR ';
    Result := Result + '    JOIN EXTGOR ON (FATGOR.AUTOINCREM = EXTGOR.FGO_SEQFGO) ';
    Result := Result + '  WHERE ';
    Result := Result + '    FGO_NPDROR = :NUMDOC AND ';
    Result := Result + '    FGO_EPDROR = :CODEMP) AS FGO_EPDROR, ';
  End;
begin
  blnJaFatu := False;
  blnJaExpe := False;
  intQtdIte := 0;

  Result := True;
  strMsg := '';

  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + fGetSQLPDReferencia;
  strSQL := strSQL + '   FGO_JAFATU, ';
  strSQL := strSQL + '   FDO_JAFATU, ';
  strSQL := strSQL + '   FGO_ENT_CD, ';
  strSQL := strSQL + '   FDO_CODITE, ';
  strSQL := strSQL + '   FDO_QTDITE, ';
  strSQL := strSQL + '   FDO_NUMLOT, ';
  strSQL := strSQL + '   FDO_CODACA, ';
  strSQL := strSQL + '   FDO_EMPACA, ';
  strSQL := strSQL + '   FDO_CODEMP, ';
  strSQL := strSQL + '   FDO_IDEPRO, ';
  strSQL := strSQL + '   FDO_QTDBAI  ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   FATDOR ';
  strSQL := strSQL + ' JOIN FATGOR ON (FATGOR.AUTOINCREM = FATDOR.FDO_SEQGER) ';
  strSQL := strSQL + ' WHERE  ';
  strSQL := strSQL + '   FDO_NUMDOC = :NUMDOC AND ';
  strSQL := strSQL + '   FDO_ESPDOC = "PD"    AND ';
  strSQL := strSQL + '   FDO_CODEMP = :CODEMP ';

  Try
    qryPed := fCriaQuery;

    With qryPed Do
    Begin
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDOC').AsString := edtNumPed.Text;
      ParamByName('CODEMP').AsString := edtCodEmp.Text;
      Open;

      If Not IsEmpty Then
      Begin
        If Assigned(FcdsDados) Then
          FreeAndNil(FcdsDados);

        pCriaClient;
        First;

        If (Not fEmptyStr(FieldByName('FGO_NPDROR').AsString)) And
           (Not fEmptyStr(FieldByName('FGO_EPDROR').AsString)) And
           (Not blnAlterandoOrc)                               Then
          strMsg := strMsg + 'Pedido já foi referenciado no Orçamento ' + FieldByName('FGO_NPDROR').AsString + '-' + FieldByName('FGO_EPDROR').AsString + #13#10;

        If FieldByName('FGO_JAFATU').AsInteger = 1 Then
          strMsg := strMsg + 'Pedido já foi faturado' + #13#10;

        If FieldByName('FGO_ENT_CD').AsString = 'S' Then
          strMsg := strMsg + 'Pedido feito através de entrega pelo CD' + #13#10;

        While Not Eof Do
        Begin
          If FieldByName('FDO_IDEPRO').AsString = 'NOR' Then
          Begin
            If (FieldByName('FGO_JAFATU').AsInteger = 0) And
               (FieldByName('FDO_JAFATU').AsInteger = 1) And
               (Not blnJaFatu) Then
            Begin
              strMsg := strMsg + 'Pedido já foi parcialmente faturado' + #13#10;
              blnJaFatu := True;
            End;

            If (FieldByName('FGO_JAFATU').AsInteger = 0) And
               (FieldByName('FDO_QTDBAI').AsFloat > 0)   And
               (Not blnJaExpe) Then
            Begin
              strMsg := strMsg + 'Pedido já foi parcialmente expedido' + #13#10;
              blnJaExpe := True;
            End;

            fltSaldoItemAtu := fRetSaldosEmpresa(FieldByName('FDO_CODITE').AsString,
                                                 FieldByName('FDO_CODEMP').AsString,
                                                 FieldByName('FDO_NUMLOT').AsString);

            If fUsaQtdPendenteEntregaFutura Then
              fltSaldoItemAtu := fltSaldoItemAtu + TEntregaFutura.New(
                                                     TParamEF.New()
                                                       .CodIte(FieldByName('FDO_CODITE').AsString)
                                                       .CodEmp(FieldByName('FDO_CODEMP').AsString)
                                                       .Faturamento(True)
                                                     ).Total();

            fltSaldoItemAtu := fatVenda.fRetornaSaldoDisponivelItemNormal(FieldByName('FDO_CODEMP').AsString,
                                                                          FieldByName('FDO_CODITE').AsString,
                                                                          FieldByName('FDO_NUMLOT').AsString,
                                                                          '',
                                                                          FieldByName('FDO_CODACA').AsString,
                                                                          FieldByName('FDO_EMPACA').AsString,
                                                                          fltSaldoItemAtu,
                                                                          False);

            fltSaldoItemAtu := fltSaldoItemAtu + FieldByName('FDO_QTDITE').AsFloat;

            If fltSaldoItemAtu > 0 Then
              Inc(intQtdIte);

            If cdsDados.Locate('CODITE;NUMLOT', VarArrayOf([FieldByName('FDO_CODITE').AsString, FieldByName('FDO_NUMLOT').AsString]), []) Then
            Begin
              cdsDados.Edit;
              cdsDados.FieldByName('QTDITE').AsFloat := cdsDados.FieldByName('QTDITE').AsFloat +
                                                        FieldByName('FDO_QTDITE').AsFloat;
            End
            Else
            Begin
              cdsDados.Append;
              cdsDados.FieldByName('CODITE').AsString := FieldByName('FDO_CODITE').AsString;
              cdsDados.FieldByName('DESITE').AsString := fRetNomProduto(FieldByName('FDO_CODITE').AsString);
              cdsDados.FieldByName('NUMLOT').AsString := FieldByName('FDO_NUMLOT').AsString;
              cdsDados.FieldByName('QTDITE').AsFloat  := FieldByName('FDO_QTDITE').AsFloat;
              cdsDados.FieldByName('SALDIS').AsFloat  := fltSaldoItemAtu;
              cdsDados.FieldByName('QTDDIG').AsFloat  := 0;

              If cdsDados.FieldByName('SALDIS').AsFloat <= 0 Then
              Begin
                If cdsDados.FieldByName('QTDITE').AsFloat = cdsDados.FieldByName('QTDDIG').AsFloat Then
                  cdsDados.FieldByName('QTDDIF').AsFloat := 0
                Else
                  cdsDados.FieldByName('QTDDIF').AsFloat := cdsDados.FieldByName('QTDDIG').AsFloat - cdsDados.FieldByName('QTDITE').AsFloat;
              End
              Else
              Begin
                If cdsDados.FieldByName('SALDIS').AsFloat < cdsDados.FieldByName('QTDITE').AsFloat Then
                  cdsDados.FieldByName('QTDDIF').AsFloat := (cdsDados.FieldByName('SALDIS').AsFloat + cdsDados.FieldByName('QTDDIG').AsFloat) - cdsDados.FieldByName('QTDITE').AsFloat
                Else
                  cdsDados.FieldByName('QTDDIF').AsFloat := 0;
              End;
            End;

            cdsDados.Post;
          End
          Else
            Inc(intQtdIteTin);

          Next;
        End;
      End
      Else
        strMsg := 'Pedido não foi encontrado';

      If (RecordCount > 0)         And
         (intQtdIte = RecordCount) Then
        strMsg := 'Saldo dos itens do pedido já foram totalmente atendido';

      If Not fEmptyStr(strMsg) Then
      Begin
        If Assigned(FcdsDados) Then
          FreeAndNil(FcdsDados);

        pCriarFormularios(TfrmObservacao, frmObservacao);
        frmObservacao.lblMensagem.Caption := 'O pedido ' + edtNumPed.Text + '-' + edtCodEmp.Text + ' não pode ser selecionado, pois:';
        frmObservacao.memObs.Texto := strMsg;
        frmObservacao.ShowModal;
        pFreeAndNil(frmObservacao);
        intQtdIteTin := 0;

        Result := False;
      End;
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fValidaPedido]');
    End;
  End;

  FreeAndNil(qryPed);
end;

procedure TfrmFatDigPedido.pCriaClient;
begin
  cdsDados := TUniClientDataSet.Create(Self);

  With cdsDados Do
  Begin
    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'CODITE';
      DataType := ftString;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'DESITE';
      DataType := ftString;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'NUMLOT';
      DataType := ftString;
      Required := False;
      Size := VS_Size_NumLot;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'QTDITE';
      DataType := ftFloat;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'SALDIS';
      DataType := ftFloat;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'QTDDIG';
      DataType := ftFloat;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'QTDDIF';
      DataType := ftFloat;
      Required := False;
    End;

    IndexFieldNames := 'CODITE;NUMLOT';
    CreateDataSet;
    Open;
  End;
end;

end.
