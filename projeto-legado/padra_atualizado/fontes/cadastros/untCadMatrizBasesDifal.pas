unit untCadMatrizBasesDifal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.Mask, Vcl.DBCtrls,
  DBEditFocus, Data.DB, Vcl.Grids, Vcl.DBGrids, DBGridCitel, Datasnap.DBClient,
  UniClientDataSet, MemDS, DBAccess, Uni;

type
  TfrmCadMatrizBasesDifal = class(TfrmPaiCad)
    pnlPrincipal: TPanel;
    Label1: TLabel;
    dbeCodMat: TDBEditFocus;
    Label2: TLabel;
    dbeDesMat: TDBEditFocus;
    dbgMatrizBasesDifal: TDBGridCitel;
    dscMATDIF: TDataSource;
    cdsDIFBAS: TUniClientDataSet;
    dscDIFBAS: TDataSource;
    cdsDIFBASAUTOINCREM: TStringField;
    cdsDIFBASDIF_CODMAT: TStringField;
    cdsDIFBASDIF_ESTADO: TStringField;
    cdsDIFBASDIF_ORIPER: TFloatField;
    cdsDIFBASDIF_DESPER: TFloatField;
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    procedure pCarregarEstados(blnRegistroNovo : Boolean = False);
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender : TWinControl; blnBuscaPorChave : Boolean):Boolean; Override;
    procedure pNewRecord(DataSet : TDataSet);
  public
    { Public declarations }
  end;

implementation

uses
  untTypesSistema, untConsultas, untFuncoesSimples, untConstantes;

{$R *.dfm}

procedure TfrmCadMatrizBasesDifal.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodMat, dbeDesMat, False);
  dbgMatrizBasesDifal.Enabled := True;
end;

procedure TfrmCadMatrizBasesDifal.btnCancelaClick(Sender: TObject);
begin

  inherited;

  cdsDIFBAS.EmptyDataSet;
  If Not fEmptyStr(dbeCodMat.Text) Then
    pCarregarEstados;

  dbgMatrizBasesDifal.Enabled := False;

end;

procedure TfrmCadMatrizBasesDifal.btnExcluirClick(Sender: TObject);
var
  strCodMat : String;
  qryExc    : TUniQuery;
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    strCodMat := dbeCodMat.Text;
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadMatrizBasesDifal.btnExcluirClick]');
    End;
  End;

  If (blnExcluiu) Then
  Begin
    qryExc := fCriaQuery();
    Try
      qryExc.Close;
      qryExc.SQL.Clear;
      qryExc.SQL.Add('DELETE FROM DIFBAS WHERE DIF_CODMAT = :CODMAT');
      qryExc.ParamByName('CODMAT').AsString := strCodMat;
      qryExc.ExecSQL;
    Finally
      fCommit;
      FreeAndNil(qryExc);
    End;
    cdsDIFBAS.EmptyDataSet;
  End
  Else
    fRollBack;

end;

procedure TfrmCadMatrizBasesDifal.btnGravarClick(Sender: TObject);
var
  qryDIFBAS : TUniQuery;
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
    If blnGravou Then
    Begin

      qryDIFBAS := fCriaQuery;
      cdsDIFBAS.DisableControls;

      Try

        cdsDIFBAS.First;
        If fEmptyStr(cdsDIFBASAUTOINCREM.AsString) Then
        Begin

          qryDIFBAS.Close;
          qryDIFBAS.SQL.Clear;
          qryDIFBAS.SQL.Add('SELECT * FROM DIFBAS WHERE FALSE');
          qryDIFBAS.Open;

          cdsDIFBAS.First;
          While Not cdsDIFBAS.Eof Do
          Begin

            qryDIFBAS.Append;
            qryDIFBAS.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('DIFBAS', VS_strCodEmp);
            qryDIFBAS.FieldByName('DIF_CODMAT').AsString := dbeCodMat.Text;
            qryDIFBAS.FieldByName('DIF_ESTADO').AsString := cdsDIFBASDIF_ESTADO.AsString;
            qryDIFBAS.FieldByName('DIF_ORIPER').AsFloat  := cdsDIFBASDIF_ORIPER.AsFloat;
            qryDIFBAS.FieldByName('DIF_DESPER').AsFloat  := cdsDIFBASDIF_DESPER.AsFloat;
            qryDIFBAS.Post;

            cdsDIFBAS.Next;

          End;

        End
        Else
        Begin

          cdsDIFBAS.First;
          While Not cdsDIFBAS.Eof Do
          Begin

            qryDIFBAS.Close;
            qryDIFBAS.SQL.Clear;
            qryDIFBAS.SQL.Add('SELECT * FROM DIFBAS WHERE AUTOINCREM = :AUTINC');
            qryDIFBAS.ParamByName('AUTINC').AsString := cdsDIFBASAUTOINCREM.AsString;
            qryDIFBAS.Open;

            If Not qryDIFBAS.IsEmpty Then
            Begin

              If (qryDIFBAS.FieldByName('DIF_ORIPER').AsFloat <> cdsDIFBASDIF_ORIPER.AsFloat) Or
                 (qryDIFBAS.FieldByName('DIF_DESPER').AsFloat <> cdsDIFBASDIF_DESPER.AsFloat) Then
              Begin
                qryDIFBAS.Edit;
                qryDIFBAS.FieldByName('DIF_ORIPER').AsFloat  := cdsDIFBASDIF_ORIPER.AsFloat;
                qryDIFBAS.FieldByName('DIF_DESPER').AsFloat  := cdsDIFBASDIF_DESPER.AsFloat;
                qryDIFBAS.Post;
              End;

            End;

            cdsDIFBAS.Next;

          End;

        End;

      Finally
        fCommit;
        cdsDIFBAS.EnableControls;
        FreeAndNil(qryDIFBAS);
        dbgMatrizBasesDifal.Enabled := False;
      End;

      If Not cdsDIFBAS.IsEmpty Then
        cdsDIFBAS.First;

    End
    Else
      fRollBack;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadMatrizBasesDifal.btnGravarClick]');
    End;
  End;

end;

procedure TfrmCadMatrizBasesDifal.btnIncluirClick(Sender: TObject);
begin

  inherited;

  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodMat, dbeDesMat, False)
  Else
    pHabilitaCodigo(dbeCodMat, dbeDesMat, True);

  pCarregarEstados(True);
  dbgMatrizBasesDifal.Enabled := True;

end;

procedure TfrmCadMatrizBasesDifal.btnPesquisaClick(Sender: TObject);
Var
  chrKey : Char;
  arrMat : TConsultasArray;
begin
  chrKey := '/';
  If fPesqMatrizBasesDifal(Self, Nil, Nil, qryTabela, chrKey, arrMat) Then
  Begin
    pSetFocus(btnAlterar);
    pCarregarEstados;
  End;
end;

procedure TfrmCadMatrizBasesDifal.FormCreate(Sender: TObject);
begin

  inherited;

  strNomeTabela     := 'MATDIF';
  strNomeCampo      := 'DIF_CODMAT';
  qryTabela         := fCriarQuery('SELECT * FROM MATDIF', Self);
  dscMATDIF.DataSet := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodMat;

  cdsDIFBAS.CreateDataSet;
  cdsDIFBAS.EmptyDataSet;

end;

function TfrmCadMatrizBasesDifal.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin

  Result := Inherited fValidaCampos(Sender, blnBuscaPorChave);

  If Result Then
  Begin

    If (Sender = dbeDesMat) Then
    Begin

      if fEmptyStr(dbeDesMat.Text) Then
      Begin
        fMensagem('', 'Informe a descrição!', ['&OK']);
        Result := False;
      End;

    End;

  End;

  If not Result Then
    pSetFocus(Sender);

end;

procedure TfrmCadMatrizBasesDifal.pCarregarEstados(blnRegistroNovo : Boolean = False);
var
  intContador : Integer;
  qryDIFBAS   : TUniQuery;
begin

  cdsDIFBAS.OnNewRecord := Nil;
  cdsDIFBAS.EmptyDataSet;

  If (blnRegistroNovo) Then
  Begin

    For intContador := 0 To 27 Do
    Begin

      If (blnRegistroNovo) Then
      Begin
        cdsDIFBAS.Append;
        cdsDIFBASAUTOINCREM.AsString := '';
        cdsDIFBASDIF_CODMAT.AsString := '';
        cdsDIFBASDIF_ESTADO.AsString := String(ESTADOS[intContador]);
        cdsDIFBASDIF_ORIPER.AsFloat  := 100;
        cdsDIFBASDIF_DESPER.AsFloat  := 100;
        cdsDIFBAS.Post;
      End

    End;

  End
  Else
  Begin

    If fEmptyStr(dbeCodMat.Text) Then
      Exit;

    qryDIFBAS := fCriaQuery;

    Try

      qryDIFBAS.Close;
      qryDIFBAS.SQL.Add('SELECT * FROM DIFBAS WHERE DIF_CODMAT = :CODMAT');
      qryDIFBAS.ParamByName('CODMAT').AsString := dbeCodMat.Text;
      qryDIFBAS.Open;

      If Not qryDIFBAS.IsEmpty Then
      Begin

        qryDIFBAS.First;
        While Not qryDIFBAS.Eof Do
        Begin

          cdsDIFBAS.Append;
          cdsDIFBASAUTOINCREM.AsString := qryDIFBAS.FieldByName('AUTOINCREM').AsString;
          cdsDIFBASDIF_CODMAT.AsString := qryDIFBAS.FieldByName('DIF_CODMAT').AsString;
          cdsDIFBASDIF_ESTADO.AsString := qryDIFBAS.FieldByName('DIF_ESTADO').AsString;
          cdsDIFBASDIF_ORIPER.AsFloat  := qryDIFBAS.FieldByName('DIF_ORIPER').AsFloat;
          cdsDIFBASDIF_DESPER.AsFloat  := qryDIFBAS.FieldByName('DIF_DESPER').AsFloat;
          cdsDIFBAS.Post;

          qryDIFBAS.Next;

        End;

      End;

    Finally
      FreeAndNil(qryDIFBAS);
    End;

  End;

  If Not cdsDIFBAS.IsEmpty Then
    cdsDIFBAS.First;

  cdsDIFBAS.OnNewRecord := pNewRecord;

end;

procedure TfrmCadMatrizBasesDifal.pInicializaIndices;
begin

  inherited;

  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('DIF_CODMAT');
  stlCampos.Add('DIF_DESCRI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('DIF_DESCRI');
  stlCamInd.Add('DIF_CODMAT');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');

end;

procedure TfrmCadMatrizBasesDifal.pNewRecord(DataSet: TDataSet);
begin
  Abort;
end;

end.
