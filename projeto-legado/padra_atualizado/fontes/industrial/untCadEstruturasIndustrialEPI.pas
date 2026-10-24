unit untCadEstruturasIndustrialEPI;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.DBCGrids, Vcl.DBCtrls, DBMemoFocus, DBComboBoxFocus,
  Data.DB, UniClientDataSet, Uni, PNGImage, untZClient;

type
  TfrmCadEstruturasIndustrialEPI = class(TfrmPaiConfirma)
    dbcDados: TDBCtrlGrid;
    DBImage1: TDBImage;
    DBText1: TDBText;
    DBMemoFocus1: TDBMemoFocus;
    lblObs: TLabel;
    DBComboBoxFocus1: TDBComboBoxFocus;
    Label1: TLabel;
    dtsCadEpi: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
  private
    function fGetSQL: String;
    procedure pOnGetTextTipUso(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure pOnSetTextTipUso(Sender: TField; const Text: string);
    procedure pBeforeInsertCadEpi(DataSet : TDataSet);
    procedure pBeforePostCadEpi(DataSet : TDataSet);

  public
    cdsCadEpi : TUniClientDataSet;
    function fPreencheCadOpi(cdsGeiOpi : TZClient) : Boolean;
  end;


implementation

{$R *.dfm}

uses untImagemBase64, untFuncoesSimples;

procedure TfrmCadEstruturasIndustrialEPI.FormCreate(Sender: TObject);
begin
  inherited;
  cdsCadEpi := TUniClientDataSet.Create(Self);

  With cdsCadEpi.FieldDefs.AddFieldDef Do Begin Name := 'EPI_CODEPI'; DataType := ftString; Size := 003; Required := False; End;
  With cdsCadEpi.FieldDefs.AddFieldDef Do Begin Name := 'EPI_DESCRI'; DataType := ftString; Size := 045; Required := False; End;
  With cdsCadEpi.FieldDefs.AddFieldDef Do Begin Name := 'EPI_IMGEPI'; DataType := ftBlob;                Required := False; End;
  With cdsCadEpi.FieldDefs.AddFieldDef Do Begin Name := 'EPI_TIPUSO'; DataType := ftString; Size := 001; Required := False; End;
  With cdsCadEpi.FieldDefs.AddFieldDef Do Begin Name := 'EPI_OBSERV'; DataType := ftString; Size := 300; Required := False; End;

  cdsCadEpi.CreateDataSet;
  TBlobField.Create(cdsCadEpi.FieldByName('EPI_IMGEPI') as TBlobField);

  cdsCadEpi.FieldByName('EPI_TIPUSO').OnGetText := pOnGetTextTipUso;
  cdsCadEpi.FieldByName('EPI_TIPUSO').OnSetText := pOnSetTextTipUso;
  cdsCadEpi.BeforePost := pBeforePostCadEpi;
end;

procedure TfrmCadEstruturasIndustrialEPI.FormDestroy(Sender: TObject);
begin
  FreeAndNil(cdsCadEpi);
  inherited;
end;

function TfrmCadEstruturasIndustrialEPI.fPreencheCadOpi(cdsGeiOpi: TZClient): Boolean;
  Var
    qryDados  : TUniQuery;
    picImagem : TPicture;
    objStream : TStream;
    objBMP    : TBitmap;
begin
  Try
    Try
      Result := True;
      qryDados := fCriarQuery(fGetSQL, Self);
      qryDados.Open;

      While Not qryDados.Eof Do
      Begin
        cdsCadEpi.Insert;
        cdsCadEpi.FieldByName('EPI_CODEPI').AsString := qryDados.FieldByName('EPI_CODEPI').AsString;
        cdsCadEpi.FieldByName('EPI_DESCRI').AsString := qryDados.FieldByName('EPI_DESCRI').AsString;

        If cdsGeiOpi.Locate('GEP_CODEPI', qryDados.FieldByName('EPI_CODEPI').AsString, []) Then
        Begin
          cdsCadEpi.FieldByName('EPI_TIPUSO').AsString := cdsGeiOpi.FieldByName('GEP_TIPUSO').AsString;
          cdsCadEpi.FieldByName('EPI_OBSERV').AsString := cdsGeiOpi.FieldByName('GEP_OBSERV').AsString;
        End
        Else
        Begin
          cdsCadEpi.FieldByName('EPI_TIPUSO').AsString := qryDados.FieldByName('EPI_TIPUSO').AsString;
          cdsCadEpi.FieldByName('EPI_OBSERV').AsString := '';
        End;

        objStream := TMemoryStream.Create;
        objBMP := TBitmap.Create;
        picImagem := TPicture.Create;
        try
          try
            pImagemFromBase64(qryDados.FieldByName('EPI_IMGEPI').AsString, picImagem);
            objBMP.Assign(picImagem.Graphic);

            objBMP.SaveToStream(objStream);
            objStream.Position := 0;
            TBlobField(cdsCadEpi.FieldByName('EPI_IMGEPI')).LoadFromStream( objStream );
          except
            cdsCadEpi.FieldByName('EPI_IMGEPI').Clear;
          end;
        finally
          FreeAndNil(picImagem);
          FreeAndNil(objStream);
          FreeAndNil(objBMP);
        end;

        cdsCadEpi.Post;

        qryDados.Next;
      End;

      dtsCadEpi.DataSet   := cdsCadEpi;
      dbcDados.DataSource := dtsCadEpi;

      cdsCadEpi.BeforeInsert := pBeforeInsertCadEpi;

    Finally
      FreeAndNil(qryDados);
    End;
  Except
    On E : Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '');
    End;
  End;
end;

procedure TfrmCadEstruturasIndustrialEPI.pBeforeInsertCadEpi(DataSet: TDataSet);
begin
  Abort;
end;

procedure TfrmCadEstruturasIndustrialEPI.pBeforePostCadEpi(DataSet: TDataSet);
begin
  DataSet.fieldByName('EPI_OBSERV').AsString := AnsiUpperCase(DataSet.fieldByName('EPI_OBSERV').AsString);
end;

procedure TfrmCadEstruturasIndustrialEPI.pOnGetTextTipUso(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  If Sender.AsString = 'N' Then
    Text := 'Não Utiliza'
  Else If Sender.AsString = 'O' Then
    Text := 'Obrigatório'
  Else If Sender.AsString = 'A' Then
    Text := 'Obrigatório por Atividade Especifica'
  Else If Sender.AsString = 'D' Then
    Text := 'Desejável';
end;

procedure TfrmCadEstruturasIndustrialEPI.pOnSetTextTipUso(Sender: TField; const Text: string);
begin
  If Text = 'Não Utiliza' Then
    Sender.AsString := 'N'
  Else If Text = 'Obrigatório' Then
    Sender.AsString := 'O'
  Else If Text = 'Obrigatório por Atividade Especifica' Then
    Sender.AsString := 'A'
  Else If Text = 'Desejável' Then
    Sender.AsString := 'D';
end;

procedure TfrmCadEstruturasIndustrialEPI.btnConfirmaClick(Sender: TObject);
begin
  cdsCadEpi.CheckBrowseMode;
  inherited;
end;

function TfrmCadEstruturasIndustrialEPI.fGetSQL : String;
Begin
  Result := '';
  Result := Result + ' SELECT EPI_CODEPI,       ';
  Result := Result + '        EPI_DESCRI,       ';
  Result := Result + '        EPI_IMGEPI,       ';
  Result := Result + '        "N" AS EPI_TIPUSO ';
  Result := Result + ' FROM CADEPI              ';
  Result := Result + ' WHERE TRUE               ';
End;

end.
