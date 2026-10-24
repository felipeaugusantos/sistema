unit untImpEtiquetaAvulsa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, EditFocus, frxClass,
  frxDBSet, AppEvnts, UniClientDataSet, BitBtnLockedIncrem,
  frxExportCSVTestabilidade;

type
  TfrmImpEtiquetaAvulsa = class(TfrmPai)
    pnlGeral: TPanel;
    Label1: TLabel;
    edtLinha01: TEditFocus;
    edtLinha02: TEditFocus;
    edtLinha03: TEditFocus;
    edtLinha04: TEditFocus;
    edtLinha05: TEditFocus;
    edtLinha06: TEditFocus;
    edtLinha07: TEditFocus;
    edtLinha08: TEditFocus;
    edtLinha09: TEditFocus;
    edtLinha10: TEditFocus;
    edtLinha11: TEditFocus;
    edtLinha12: TEditFocus;
    frxEtiqueta: TfrxReport;
    frxDataset: TfrxDBDataset;
    Label2: TLabel;
    edtQtdEti: TEditFocus;
    btnConfirmaDados: TBitBtnLocked;
    btnImpExcel: TBitBtnLocked;
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure btnImpExcelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

uses Uni, DB, untfuncoesSimples, untExcel;

{$R *.dfm}

procedure TfrmImpEtiquetaAvulsa.btnConfirmaDadosClick(Sender: TObject);
  Var
    intContador: Integer;
    strEtiqAvul: String;
    cdsEtiqueta: TUniClientDataSet;
begin
  inherited;

  If (fEmptyStr(edtQtdEti.Text)) Then
  Begin
    fMensagem('', 'A quantidade de etiquetas deve ser preenchida!', ['&Ok']);
    Exit;
  End;

  If (StrToIntDef(edtQtdEti.Text, 0) <= 0) Then
  Begin
    fMensagem('', 'A quantidade de etiquetas deve ser maior ou igual a 1.', ['&Ok']);
    Exit;
  End;

  cdsEtiqueta := TUniClientDataSet.Create(Self);
  
  With cdsEtiqueta Do
  Begin
    With FieldDefs Do
    Begin
      With AddFieldDef Do Begin Name := 'LINHA01'; DataType := ftString; Size := 040; End;
      With AddFieldDef Do Begin Name := 'LINHA02'; DataType := ftString; Size := 040; End;
      With AddFieldDef Do Begin Name := 'LINHA03'; DataType := ftString; Size := 040; End;
      With AddFieldDef Do Begin Name := 'LINHA04'; DataType := ftString; Size := 040; End;
      With AddFieldDef Do Begin Name := 'LINHA05'; DataType := ftString; Size := 040; End;
      With AddFieldDef Do Begin Name := 'LINHA06'; DataType := ftString; Size := 040; End;
      With AddFieldDef Do Begin Name := 'LINHA07'; DataType := ftString; Size := 040; End;
      With AddFieldDef Do Begin Name := 'LINHA08'; DataType := ftString; Size := 040; End;
      With AddFieldDef Do Begin Name := 'LINHA09'; DataType := ftString; Size := 040; End;
      With AddFieldDef Do Begin Name := 'LINHA10'; DataType := ftString; Size := 040; End;
      With AddFieldDef Do Begin Name := 'LINHA11'; DataType := ftString; Size := 040; End;
      With AddFieldDef Do Begin Name := 'LINHA12'; DataType := ftString; Size := 040; End;
    End;
    
    CreateDataSet;
    Open;
    
    For intContador := 1 To StrToInt(edtQtdEti.Text) Do
    Begin
      Insert;
      FieldByName('LINHA01').AsString := edtLinha01.Text;
      FieldByName('LINHA02').AsString := edtLinha02.Text;
      FieldByName('LINHA03').AsString := edtLinha03.Text;
      FieldByName('LINHA04').AsString := edtLinha04.Text;
      FieldByName('LINHA05').AsString := edtLinha05.Text;
      FieldByName('LINHA06').AsString := edtLinha06.Text;
      FieldByName('LINHA07').AsString := edtLinha07.Text;
      FieldByName('LINHA08').AsString := edtLinha08.Text;
      FieldByName('LINHA09').AsString := edtLinha09.Text;
      FieldByName('LINHA10').AsString := edtLinha10.Text;
      FieldByName('LINHA11').AsString := edtLinha11.Text;
      FieldByName('LINHA12').AsString := edtLinha12.Text;
      Post;
    End;

    frxDataset.DataSet := cdsEtiqueta;
    
    If (Not IsEmpty) Then
    Begin
      strEtiqAvul := fCfgSis('PATETI') + '\etiqueta_avulsa.fr3';
      If FileExists(strEtiqAvul) Then
        frxEtiqueta.LoadFromFile(strEtiqAvul);
      If Not (pbEdit in(frxEtiqueta.PreviewOptions.Buttons)) Then
        frxEtiqueta.PreviewOptions.Buttons := frxEtiqueta.PreviewOptions.Buttons + [pbEdit];
      pPreviewReport(Self.Name, Self.Caption, frxEtiqueta);
    End;

    Close;

    FreeAndNil(cdsEtiqueta);
  End;

end;

procedure TfrmImpEtiquetaAvulsa.btnImpExcelClick(Sender: TObject);
  Var
    cdsEtiqueta: TUniClientDataSet;
    objExcel   : TExcel;
    dlgOpen    : TOpenDialog;
    intConLin  : Integer;
    strEtiqAvul: String;
begin
  inherited;

  dlgOpen     := TOpenDialog.Create(Self);
  dlgOpen.Filter := 'Arquivos do Excel|*.xls;*.xlsx';

  If dlgOpen.Execute Then
  Begin
    cdsEtiqueta := TUniClientDataSet.Create(Self);
    With cdsEtiqueta Do
    Begin
      With FieldDefs Do
      Begin
        With AddFieldDef Do Begin Name := 'LINHA01'; DataType := ftString; Size := 040; End;
        With AddFieldDef Do Begin Name := 'LINHA02'; DataType := ftString; Size := 040; End;
        With AddFieldDef Do Begin Name := 'LINHA03'; DataType := ftString; Size := 040; End;
        With AddFieldDef Do Begin Name := 'LINHA04'; DataType := ftString; Size := 040; End;
        With AddFieldDef Do Begin Name := 'LINHA05'; DataType := ftString; Size := 040; End;
        With AddFieldDef Do Begin Name := 'LINHA06'; DataType := ftString; Size := 040; End;
        With AddFieldDef Do Begin Name := 'LINHA07'; DataType := ftString; Size := 040; End;
        With AddFieldDef Do Begin Name := 'LINHA08'; DataType := ftString; Size := 040; End;
        With AddFieldDef Do Begin Name := 'LINHA09'; DataType := ftString; Size := 040; End;
        With AddFieldDef Do Begin Name := 'LINHA10'; DataType := ftString; Size := 040; End;
        With AddFieldDef Do Begin Name := 'LINHA11'; DataType := ftString; Size := 040; End;
        With AddFieldDef Do Begin Name := 'LINHA12'; DataType := ftString; Size := 040; End;
      End;

      CreateDataSet;
      Open;

      objExcel := TExcel.fCriarExcel(Self);
      objExcel.AbrirArquivo(dlgOpen.FileName);

      For intConLin := 1 To objExcel.MaximodeLinhas Do
      Begin
        Append;
        FieldByName('LINHA01').AsString := objExcel.Ler_Celula(fGetLetraAlfa(01) + IntToStr(intConLin));
        FieldByName('LINHA02').AsString := objExcel.Ler_Celula(fGetLetraAlfa(02) + IntToStr(intConLin));
        FieldByName('LINHA03').AsString := objExcel.Ler_Celula(fGetLetraAlfa(03) + IntToStr(intConLin));
        FieldByName('LINHA04').AsString := objExcel.Ler_Celula(fGetLetraAlfa(04) + IntToStr(intConLin));
        FieldByName('LINHA05').AsString := objExcel.Ler_Celula(fGetLetraAlfa(05) + IntToStr(intConLin));
        FieldByName('LINHA06').AsString := objExcel.Ler_Celula(fGetLetraAlfa(06) + IntToStr(intConLin));
        FieldByName('LINHA07').AsString := objExcel.Ler_Celula(fGetLetraAlfa(07) + IntToStr(intConLin));
        FieldByName('LINHA08').AsString := objExcel.Ler_Celula(fGetLetraAlfa(08) + IntToStr(intConLin));
        FieldByName('LINHA09').AsString := objExcel.Ler_Celula(fGetLetraAlfa(09) + IntToStr(intConLin));
        FieldByName('LINHA10').AsString := objExcel.Ler_Celula(fGetLetraAlfa(10) + IntToStr(intConLin));
        FieldByName('LINHA11').AsString := objExcel.Ler_Celula(fGetLetraAlfa(11) + IntToStr(intConLin));
        FieldByName('LINHA12').AsString := objExcel.Ler_Celula(fGetLetraAlfa(12) + IntToStr(intConLin));
        Post;
      End;
      objExcel.FecharArquivo;

      frxDataset.DataSet := cdsEtiqueta;

      If (Not IsEmpty) Then
      Begin
        strEtiqAvul := fCfgSis('PATETI') + '\etiqueta_avulsa.fr3';
        If FileExists(strEtiqAvul) Then
          frxEtiqueta.LoadFromFile(strEtiqAvul);
        pPreviewReport(Self.Name, Self.Caption, frxEtiqueta);
      End;

      Close;

      FreeAndNil(objExcel);
      FreeAndNil(cdsEtiqueta);
    End;
  End;
  FreeAndNil(dlgOpen);

end;

procedure TfrmImpEtiquetaAvulsa.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(edtLinha01);
end;

end.

