unit untEntDigMultiLojas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, Grids, DBGridCitel, DBGrids, DB,
  UniDataSetProvider, UniClientDataSet,  Uni, untPcdDet, DBCtrls,
  Mask, DBEditFocus, untModuloGirIte, AppEvnts;

type
  TfrmEntDigMultiLojas = class(TfrmPai)
    dbgItens: TDBGridCitel;
    btnConfirmaDados: TBitBtn;
    dtsPcdDet: TDataSource;
    cdsPcdDet: TUniClientDataSet;
    cdsPcdDetPCD_EMPDES: TStringField;
    cdsPcdDetPCD_DESEMP: TStringField;
    cdsPcdDetPCD_QTDITE: TFloatField;
    pnlTotais: TPanel;
    lblTotal: TDBText;
    cdsPcdDetPCD_TOTAL_: TAggregateField;
    lblDesTot: TLabel;
    cdsPcdDetPCD_MES001: TFloatField;
    cdsPcdDetPCD_MES002: TFloatField;
    cdsPcdDetPCD_MES003: TFloatField;
    cdsPcdDetPCD_MES004: TFloatField;
    cdsPcdDetPCD_MES005: TFloatField;
    cdsPcdDetPCD_MES006: TFloatField;
    cdsPcdDetPCD_MES007: TFloatField;
    cdsPcdDetPCD_MES008: TFloatField;
    cdsPcdDetPCD_MES009: TFloatField;
    cdsPcdDetPCD_MES010: TFloatField;
    cdsPcdDetPCD_MES011: TFloatField;
    cdsPcdDetPCD_MES012: TFloatField;
    cdsPcdDetPCD_SALDOS: TFloatField;
    cdsPcdDetPCD_MEDIA_: TFloatField;
    cdsPcdDetPCD_SUGEST: TFloatField;
    lblQtdM04: TLabel;
    dbeQtdM04: TDBEditFocus;
    lblQtdM05: TLabel;
    dbeQtdM05: TDBEditFocus;
    lblQtdM06: TLabel;
    dbeQtdM06: TDBEditFocus;
    lblQtdM07: TLabel;
    dbeQtdM07: TDBEditFocus;
    lblQtdM08: TLabel;
    dbeQtdM08: TDBEditFocus;
    lblQtdM09: TLabel;
    dbeQtdM09: TDBEditFocus;
    lblQtdM10: TLabel;
    dbeQtdM10: TDBEditFocus;
    lblQtdM11: TLabel;
    dbeQtdM11: TDBEditFocus;
    lblQtdM12: TLabel;
    dbeQtdM12: TDBEditFocus;
    Label1: TLabel;
    cdsPcdDetPCD_MAQTSA: TFloatField;
    cdsPcdDetPCD_MADTSA: TDateField;
    Label2: TLabel;
    dbeMaQtSa: TDBEditFocus;
    dbeMaDtSa: TDBEditFocus;
    Label3: TLabel;
    Label4: TLabel;
    dbeMltCom: TDBEditFocus;
    cdsPcdDetPCD_MLTCOM: TIntegerField;
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure dbgItensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    objPcdDet: TPcdDet;
    procedure pBeforePost(Dataset: TDataSet);
    procedure pAfterInsert(Dataset: TDataSet);
    procedure pAtualizaCaptions(objGiro: TPcdDet);

    procedure pMostraGiroAnalitico;
    function fRetMultiploCompra(strCodIte: String): Integer;
  public
    { Public declarations }
    lstEmpresas: TList;
    strCodIte: String;
    strTotal: String;
    strNumPed: String;
    strEspDoc: String;
    strSeqGer: String;
    intQtdMes: Integer;
    intDiaCom: Integer;
    blnArredSug: Boolean;
    blnConsMCom: Boolean;
    strCompraCentr: String;
  end;

var
  frmEntDigMultiLojas: TfrmEntDigMultiLojas;

implementation

uses untFuncoes, untfuncoesSimples, untEntGiroAnalitico;

{$R *.dfm}

procedure TfrmEntDigMultiLojas.FormShow(Sender: TObject);
  Var
    intContador: Integer;
    qryAux: TUniQuery;
begin
  inherited;

  If (intQtdMes In [0,3]) Then
  Begin
    pnlTotais.Height := 38;
    pnlTotais.Top    := 192;
  End
  Else If (intQtdMes = 6) Then
  Begin
    pnlTotais.Height := 41;
    pnlTotais.Top    := 192;
    lblTotal.Top     := 12;
    lblDesTot.Top    := 12;

    lblQtdM04.Visible := True;
    lblQtdM05.Visible := True;
    lblQtdM06.Visible := True;

    dbeQtdM04.Visible := True;
    dbeQtdM05.Visible := True;
    dbeQtdM06.Visible := True;
  End
  Else If (intQtdMes = 12) Then
  Begin

    lblTotal.Top     := 60;
    lblDesTot.Top    := 60;

    lblQtdM04.Visible := True;
    lblQtdM05.Visible := True;
    lblQtdM06.Visible := True;
    lblQtdM07.Visible := True;
    lblQtdM08.Visible := True;
    lblQtdM09.Visible := True;
    lblQtdM10.Visible := True;
    lblQtdM11.Visible := True;
    lblQtdM12.Visible := True;

    dbeQtdM04.Visible := True;
    dbeQtdM05.Visible := True;
    dbeQtdM06.Visible := True;
    dbeQtdM07.Visible := True;
    dbeQtdM08.Visible := True;
    dbeQtdM09.Visible := True;
    dbeQtdM10.Visible := True;
    dbeQtdM11.Visible := True;
    dbeQtdM12.Visible := True;
  End;

  If (intQtdMes = 0) Then
    intQtdMes := 3;

  cdsPcdDet.BeforePost := pBeforePost;
  cdsPcdDet.CreateDataSet;
  cdsPcdDet.IndexFieldNames := 'PCD_EMPDES';

  If (Assigned(lstEmpresas)) Then
  Begin
    For intContador := 0 To lstEmpresas.Count -1 Do
    Begin
      objPcdDet := TPcdDet(lstEmpresas[intContador]);

      cdsPcdDet.Append;
      cdsPcdDet.FieldByName('PCD_EMPDES').AsString   := objPcdDet.strEmpDes;
      cdsPcdDet.FieldByName('PCD_DESEMP').AsString   := fRetNomeEmpresa(objPcdDet.strEmpDes);
      cdsPcdDet.FieldByName('PCD_QTDITE').AsFloat    := objPcdDet.fltQtdIte;
      cdsPcdDet.FieldByName('PCD_MLTCOM').AsInteger  := fRetMultiploCompra(strCodIte);
      cdsPcdDet.FieldByName('PCD_MES001').AsFloat    := objPcdDet.objGiro.fltQtdM01;
      cdsPcdDet.FieldByName('PCD_MES002').AsFloat    := objPcdDet.objGiro.fltQtdM02;
      cdsPcdDet.FieldByName('PCD_MES003').AsFloat    := objPcdDet.objGiro.fltQtdM03;
      cdsPcdDet.FieldByName('PCD_MES004').AsFloat    := objPcdDet.objGiro.fltQtdM04;
      cdsPcdDet.FieldByName('PCD_MES005').AsFloat    := objPcdDet.objGiro.fltQtdM05;
      cdsPcdDet.FieldByName('PCD_MES006').AsFloat    := objPcdDet.objGiro.fltQtdM06;
      cdsPcdDet.FieldByName('PCD_MES007').AsFloat    := objPcdDet.objGiro.fltQtdM07;
      cdsPcdDet.FieldByName('PCD_MES008').AsFloat    := objPcdDet.objGiro.fltQtdM08;
      cdsPcdDet.FieldByName('PCD_MES009').AsFloat    := objPcdDet.objGiro.fltQtdM09;
      cdsPcdDet.FieldByName('PCD_MES010').AsFloat    := objPcdDet.objGiro.fltQtdM10;
      cdsPcdDet.FieldByName('PCD_MES011').AsFloat    := objPcdDet.objGiro.fltQtdM11;
      cdsPcdDet.FieldByName('PCD_MES012').AsFloat    := objPcdDet.objGiro.fltQtdM12;
      cdsPcdDet.FieldByName('PCD_SALDOS').AsFloat    := objPcdDet.objGiro.fltSaldos;
      cdsPcdDet.FieldByName('PCD_MEDIA_').AsFloat    := objPcdDet.objGiro.fltMedia_;
      cdsPcdDet.FieldByName('PCD_SUGEST').AsFloat    := objPcdDet.objGiro.fltSugest;
      cdsPcdDet.FieldByName('PCD_MAQTSA').Value      := Null;
      cdsPcdDet.FieldByName('PCD_MADTSA').Value      := Null;
      If (objPcdDet.objGiro.fltMaiorQtdSai > -1) And (objPcdDet.objGiro.dtaMaiorDtaSai > 0) Then
      Begin
        cdsPcdDet.FieldByName('PCD_MAQTSA').AsFloat    := objPcdDet.objGiro.fltMaiorQtdSai;
        cdsPcdDet.FieldByName('PCD_MADTSA').AsDateTime := objPcdDet.objGiro.dtaMaiorDtaSai;
      End;

      cdsPcdDet.Post;

      pAtualizaCaptions(objPcdDet);
    End;
  End
  Else
  Begin

    objPcdDet := TPcdDet.Create;

    lstEmpresas := TList.Create;

    qryAux := fCriaQuery(Self);
    qryAux.SQL.Add('SELECT                                                   ');
    qryAux.SQL.Add('  C.EMP_CODEMP,                                          ');
    qryAux.SQL.Add('  C.EMP_NOMEMP,                                          ');
    qryAux.SQL.Add('  IFNULL(D.PCD_QTDITE, 0) AS PCD_QTDITE                  ');
    qryAux.SQL.Add(' FROM                                                    ');
    qryAux.SQL.Add('  CADEMP C                                               ');
    qryAux.SQL.Add(' LEFT JOIN PCDDET D ON C.EMP_CODEMP = D.PCD_EMPDES AND   ');
    qryAux.SQL.Add('  D.PCD_NUMPED = :NUMPED AND                             ');
    qryAux.SQL.Add('  D.PCD_ESPDOC = :ESPDOC AND                             ');
    qryAux.SQL.Add('  D.PCD_CODEMP = :CODEMP AND                             ');
    qryAux.SQL.Add('  D.PCD_SEQGER = :SEQGER AND                             ');
    qryAux.SQL.Add('  D.PCD_CODITE = :CODITE                                 ');
    qryAux.SQL.Add(' LEFT JOIN PCMDET P ON                                   ');
    qryAux.SQL.Add('  P.PCD_NUMPED = D.PCD_NUMPED AND                        ');
    qryAux.SQL.Add('  NOT LOCATE(P.PCD_CODFOR, :FORFIL) > 0                  ');
    qryAux.SQL.Add(' ORDER BY                                                ');
    qryAux.SQL.Add('  D.PCD_NUMPED, D.PCD_ESPDOC, D.PCD_CODEMP, D.PCD_EMPDES ');

    qryAux.ParamByName('NUMPED').AsString := strNumPed;
    qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
    qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryAux.ParamByName('SEQGER').AsString := strSeqGer;
    qryAux.ParamByName('CODITE').AsString := strCodIte;
    qryAux.ParamByName('FORFIL').AsString := fRetForFilialTodos;
    qryAux.Open;

    While (Not qryAux.Eof) Do
    Begin
      objPcdDet.pCalculaGiro(strCodIte, qryAux.FieldByName('EMP_CODEMP').AsString, intQtdMes, intDiaCom,
        blnConsMCom, blnArredSug);
      cdsPcdDet.Append;
      cdsPcdDet.FieldByName('PCD_EMPDES').AsString   := qryAux.FieldByName('EMP_CODEMP').AsString;
      cdsPcdDet.FieldByName('PCD_DESEMP').AsString   := qryAux.FieldByName('EMP_NOMEMP').AsString;
      cdsPcdDet.FieldByName('PCD_QTDITE').AsFloat    := qryAux.FieldByName('PCD_QTDITE').AsFloat;
      cdsPcdDet.FieldByName('PCD_MLTCOM').AsInteger  := fRetMultiploCompra(strCodIte);
      cdsPcdDet.FieldByName('PCD_MES001').AsFloat    := objPcdDet.objGiro.fltQtdM01;
      cdsPcdDet.FieldByName('PCD_MES002').AsFloat    := objPcdDet.objGiro.fltQtdM02;
      cdsPcdDet.FieldByName('PCD_MES003').AsFloat    := objPcdDet.objGiro.fltQtdM03;
      cdsPcdDet.FieldByName('PCD_MES004').AsFloat    := objPcdDet.objGiro.fltQtdM04;
      cdsPcdDet.FieldByName('PCD_MES005').AsFloat    := objPcdDet.objGiro.fltQtdM05;
      cdsPcdDet.FieldByName('PCD_MES006').AsFloat    := objPcdDet.objGiro.fltQtdM06;
      cdsPcdDet.FieldByName('PCD_MES007').AsFloat    := objPcdDet.objGiro.fltQtdM07;
      cdsPcdDet.FieldByName('PCD_MES008').AsFloat    := objPcdDet.objGiro.fltQtdM08;
      cdsPcdDet.FieldByName('PCD_MES009').AsFloat    := objPcdDet.objGiro.fltQtdM09;
      cdsPcdDet.FieldByName('PCD_MES010').AsFloat    := objPcdDet.objGiro.fltQtdM10;
      cdsPcdDet.FieldByName('PCD_MES011').AsFloat    := objPcdDet.objGiro.fltQtdM11;
      cdsPcdDet.FieldByName('PCD_MES012').AsFloat    := objPcdDet.objGiro.fltQtdM12;
      cdsPcdDet.FieldByName('PCD_SALDOS').AsFloat    := objPcdDet.objGiro.fltSaldos;
      cdsPcdDet.FieldByName('PCD_MEDIA_').AsFloat    := objPcdDet.objGiro.fltMedia_;
      cdsPcdDet.FieldByName('PCD_SUGEST').AsFloat    := objPcdDet.objGiro.fltSugest;
      cdsPcdDet.FieldByName('PCD_QTDITE').AsFloat    := objPcdDet.objGiro.fltSugest;
      cdsPcdDet.FieldByName('PCD_MAQTSA').Value      := Null;
      cdsPcdDet.FieldByName('PCD_MADTSA').Value      := Null;
      If (objPcdDet.objGiro.fltMaiorQtdSai > -1) And (objPcdDet.objGiro.dtaMaiorDtaSai > 0) Then
      Begin
        cdsPcdDet.FieldByName('PCD_MAQTSA').AsFloat    := objPcdDet.objGiro.fltMaiorQtdSai;
        cdsPcdDet.FieldByName('PCD_MADTSA').AsDateTime := objPcdDet.objGiro.dtaMaiorDtaSai;
      End;
      cdsPcdDet.Post;

      pAtualizaCaptions(objPcdDet);

      qryAux.Next;
    End;
    cdsPcdDet.First;
    qryAux.Close;
  End;

  cdsPcdDet.AfterInsert := pAfterInsert;
  cdsPcdDet.First;

  dbgItens.SelectedIndex := 8;

end;

procedure TfrmEntDigMultiLojas.pBeforePost(Dataset: TDataSet);
begin

  Try

    If (strCompraCentr = 'S') And (Dataset.FieldByName('PCD_QTDITE').AsFloat > 0) Then
    Begin
      If Dataset.FieldByName('PCD_EMPDES').AsString = fCfgSis('EMPMAT') Then
        objPcdDet.fltQtdIte := Dataset.FieldByName('PCD_QTDITE').AsFloat
      Else
      Begin
        fMensagem('ATENÇÃO!', 'Produto com compra centralizada! ' + #13#10 + 'Só é permitido informar valores para a Matriz.', ['&O k']);
        objPcdDet.fltQtdIte := 0;
        Dataset.FieldByName('PCD_QTDITE').AsFloat := 0;
      End;
    End
    Else
      objPcdDet.fltQtdIte := Dataset.FieldByName('PCD_QTDITE').AsFloat;

  Except
    On E: Exception Do
    Begin
      fMensagem('', E.Message, ['&Ok']);
      Dataset.FieldByName('PCD_QTDITE').AsVariant := Dataset.FieldByName('PCD_QTDITE').OldValue;
    End;
  End;

end;

procedure TfrmEntDigMultiLojas.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;

  lstEmpresas.Clear;

  cdsPcdDet.First;
  While (Not cdsPcdDet.Eof) Do
  Begin

    objPcdDet := TPcdDet.Create;
    objPcdDet.strCodIte := strCodIte;
    objPcdDet.fltQtdIte := cdsPcdDet.FieldByName('PCD_QTDITE').AsFloat;
    objPcdDet.strEmpDes := cdsPcdDet.FieldByName('PCD_EMPDES').AsString;
    objPcdDet.pCalculaGiro(strCodIte, objPcdDet.strEmpDes, intQtdMes, intDiaCom,
      blnConsMCom, blnArredSug);
    lstEmpresas.Add(objPcdDet);

    cdsPcdDet.Next;
  End;

  strTotal := FloatToStrF(fStrToFloat(lblTotal.Caption), ffFixed, 12, 2);
  cdsPcdDet.Close;
  Self.Close;
  ModalResult := mrOk;

end;

procedure TfrmEntDigMultiLojas.dbgItensKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_RETURN) And (cdsPcdDet.State = dsEdit) Then
  Begin
    cdsPcdDet.Post;
    cdsPcdDet.Next;
  End
  Else If (Key = VK_ESCAPE) Then
  Begin
    btnSair.Click;
  End
  Else If (Key = VK_F2) Then
  Begin
    pMostraGiroAnalitico;
  End;
end;

procedure TfrmEntDigMultiLojas.pAfterInsert(Dataset: TDataSet);
begin
  Dataset.Cancel;
end;

procedure TfrmEntDigMultiLojas.FormCreate(Sender: TObject);
begin
  inherited;
  intQtdMes := 0;
end;

procedure TfrmEntDigMultiLojas.pAtualizaCaptions(objGiro: TPcdDet);
begin
  dbgItens.Columns[2].Title.Caption := objPcdDet.objGiro.strDesM01;
  dbgItens.Columns[3].Title.Caption := objPcdDet.objGiro.strDesM02;
  dbgItens.Columns[4].Title.Caption := objPcdDet.objGiro.strDesM03;

  lblQtdM04.Caption := objPcdDet.objGiro.strDesM04;
  lblQtdM05.Caption := objPcdDet.objGiro.strDesM05;
  lblQtdM06.Caption := objPcdDet.objGiro.strDesM06;
  lblQtdM07.Caption := objPcdDet.objGiro.strDesM07;
  lblQtdM08.Caption := objPcdDet.objGiro.strDesM08;
  lblQtdM09.Caption := objPcdDet.objGiro.strDesM09;
  lblQtdM10.Caption := objPcdDet.objGiro.strDesM10;
  lblQtdM11.Caption := objPcdDet.objGiro.strDesM11;
  lblQtdM12.Caption := objPcdDet.objGiro.strDesM12;
end;

procedure TfrmEntDigMultiLojas.pMostraGiroAnalitico;
  Var
    cdsGiroAna: TUniClientDataSet;
begin

  cdsGiroAna := frmModuloGirIte.fCalculaGiroAnalitico(strCodIte,
                                                      cdsPcdDet.FieldByName('PCD_EMPDES').AsString,
                                                      intQtdMes);

  Try
    Application.CreateForm(TfrmEntGiroAnalitico, frmEntGiroAnalitico);
    frmEntGiroAnalitico.dtsGiro.DataSet := cdsGiroAna;
    frmEntGiroAnalitico.ShowModal;
  Finally
    pFreeAndNil(frmEntGiroAnalitico);
  End;

end;

function TfrmEntDigMultiLojas.fRetMultiploCompra(strCodIte: String): Integer;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Self);
  qryAux.SQL.Add('SELECT ITE_MLTCOM FROM CADITE WHERE ITE_CODITE = :CODITE');
  qryAux.ParamByName('CODITE').AsString := strCodIte;
  qryAux.Open;
  Result := qryAux.FieldByName('ITE_MLTCOM').AsInteger;
  qryAux.Close;
  FreeAndNil(qryAux);
end;

end.

