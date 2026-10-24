unit untRelFatEtiArmazenamento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiRelatorio, Vcl.ExtCtrls,
  frxExportCSVTestabilidade, Vcl.AppEvnts, frxDesgn, frxClass, frxDBSet,
  frxDMPExport, frxExportPDF, frxExportHTML, frxExportXLS, frxExportRTF,
  RLFilters, RLDraftFilter, Vcl.Menus, Vcl.StdCtrls, EditFocus, QColorLabel,
  Vcl.Buttons, BitBtnLockedIncrem, Data.DB, MemDS, DBAccess, Uni,
  Datasnap.DBClient, UniClientDataSet;

type
  TfrmRelFatEtiArmazenamento = class(TfrmPaiRelatorio)
    Label2: TLabel;
    edtCodIte: TEditFocus;
    edtDesIte: TEditFocus;
    lblQuantidade: TLabel;
    Label1: TLabel;
    edtQtdIte: TEditFocus;
    edtQtdEti: TEditFocus;
    UniClientDataSet1: TUniClientDataSet;
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
  published
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}

uses TypesRel, untFuncoesSimples, untConstantes, untTypesSistema,
  untFuncoesEtiquetas, untConsultas;

procedure TfrmRelFatEtiArmazenamento.btnImprimirClick(Sender: TObject);
var
  qryEtique : TUniQuery;
  cdsEtique : TUniClientDataSet;
  prmDllEtq : TParamDllEtiquetas;
  strTipEti : String;
  strSequen : String;
  i         : Integer;
begin
  inherited;
  If blnImprime then
  begin
    qryEtique := fCriaQuery(nil);
    try
      qryEtique.SQL.Add('SELECT                                                     ');
      qryEtique.SQL.Add('  CD.ITE_CODITE AS CODITE,                                 ');
      qryEtique.SQL.Add('  CD.ITE_DESITE AS DESITE,                                 ');
      qryEtique.SQL.Add('  :QTDITE    AS QTDITE,                                    ');
      qryEtique.SQL.Add('  CAST("" AS CHAR(100)) AS SEQDET,                         ');
      qryEtique.SQL.Add('  CURRENT_DATE AS DTAEMI,                                  ');
      qryEtique.SQL.Add('  CD.ITE_CODBAR AS CODBAR,                                 ');
      qryEtique.SQL.Add('  CD.ITE_BAREMB AS BAREMB,                                 ');
      qryEtique.SQL.Add('  IT.ITE_LOCFIS AS LOCFIS,                                 ');
      qryEtique.SQL.Add('  IT.ITE_LOCSUP AS LOCSUP,                                 ');
      qryEtique.SQL.Add('  U.UNI_SIGUNI AS SIGUNI                                   ');
      qryEtique.SQL.Add('FROM                                                       ');
      qryEtique.SQL.Add('  CADITE CD                                                ');
      qryEtique.SQL.Add('  LEFT JOIN ITEGER IT                                      ');
      qryEtique.SQL.Add('   ON IT.ITE_CODITE = CD.ITE_CODITE                        ');
      qryEtique.SQL.Add('   AND IT.ITE_CODEMP = ' +QuotedStr(VS_strCodEmp)+ '       ');
      qryEtique.SQL.Add('  LEFT JOIN CADUNI U ON U.UNI_CODUNI = ITE_UNICOM          ');
      qryEtique.SQL.Add('WHERE                                                      ');
      qryEtique.SQL.Add('  CD.ITE_CODITE = :CODITE                                  ');

      qryEtique.ParamByName('CODITE').AsString  := edtCodIte.Text;
      qryEtique.ParamByName('QTDITE').AsFloat := fStrToFloat(edtQtdIte.Text);

      qryEtique.Open;

      if qryEtique.IsEmpty then
      begin
        pMensagemOk('Não existem dados para impressão!');
        exit;
      end;

      cdsEtique := fCriaClientDatset(qryEtique, True);
      try

        for i := 1 to StrToInt(edtQtdEti.Text) do
        begin
          qryEtique.First;
          while not qryEtique.Eof do
          begin
            pCopiaRegistroDataSet(qryEtique, cdsEtique);
            cdsEtique.Edit;
            strSequen := IntToStr(i)+'/'+edtQtdEti.Text;
            cdsEtique.FieldByName('SEQDET').AsString := strSequen;
            cdsEtique.Post;
            qryEtique.Next;
          end;
        end;


        prmDllEtq := TParamDllEtiquetas.Create;
        try

          strTipEti := fCfgSis('ETIARM', varString);
          Case strTipEti[1] of
            'L': prmDllEtq.tpeTipEtq := tpeArmazenamento;
            'A': prmDllEtq.tpeTipEtq := tpeArmazenamentoArgox;
            'Z': prmDllEtq.tpeTipEtq := tpeArmazenamentoZebra;
          end;

          prmDllEtq.dtsImpres := cdsEtique;
          prmDllEtq.intNumCop := StrToInt(edtQtdEti.Text);
          prmDllEtq.blnImpEti := edtDestino.Text = 'I';

          fImprimeEtiqueta(prmDllEtq, 'fimprimeetiquetas');

        finally
          FreeAndNil(prmDllEtq);
        end;

      finally
        FreeAndNil(cdsEtique);
      end;

    finally
      qryEtique.Close;
      FreeAndNil(qryEtique);
    end;
  end;
end;

procedure TfrmRelFatEtiArmazenamento.edtCodIteKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;

  If fPesqItem(conIteSimples, Self, edtCodIte, edtDesIte, nil, Key, arrSel, True, nil, 'Consulta de Itens', '1') Then
  Begin
    If fValidaCampos(edtCodIte, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;


procedure TfrmRelFatEtiArmazenamento.FormCreate(Sender: TObject);
begin
  inherited;
  pSetaCodIte(edtCodIte);
  strFilRel := ETIQUETA_ARMAZENAMENTO;
end;

function TfrmRelFatEtiArmazenamento.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin

    If (Sender = edtCodIte) Then
    Begin

      If fEmptyStr(edtCodIte.Text) Then
      Begin
        edtDesIte.Clear;
        pMensagemOk('Informe o código do produto!');
        Result := False;
      End
      Else
      Begin

        edtDesIte.Text := fRetNomProduto(edtCodIte.Text);

        If fEmptyStr(edtDesIte.Text) Then
        Begin
          pMensagemOk('Produto não econtrado!');
          Result := False;
        End;

      End;

    End

    Else If (Sender = edtQtdIte) Then
    Begin

      If fStrToFloat(edtQtdIte.Text) <= 0 Then
      Begin
        pMensagemOk('A quantidade do produto deve ser maior que zero!');
        Result := False;
      End;

    End

    Else If (Sender = edtQtdEti) Then
    Begin

      If StrToIntDef(edtQtdEti.Text, 0) < 1 Then
      Begin
        pMensagemOk('A quantidade de etiquetas deve ser maior que zero!');
        Result := False;
      End;

    End
  End;



  If Not Result Then
    pSetFocus(Sender);

end;


end.
