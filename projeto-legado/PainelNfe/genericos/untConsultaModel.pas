unit untConsultaModel;

interface

uses
   Classes;

type
   TConsultaModel = class(TPersistent)
   private
      FStlCampos,
      FStlNomesCol,
      FStlCampOrder: TStringList;
      FStrCondicao,
      FStrTabela,
      FStrTitulo,
      FStrNomeForm: String;
   public
      constructor Create(stlCampos, stlNomesCol, stlCampOrder: TStringList; strCondicao,
        strTabela, strTitulo, strNomeForm: String);
   published
      property stlCampos:    TStringList read FStlCampos    write FStlCampos;
      property stlNomesCol:  TStringList read FStlNomesCol  write FStlNomesCol;
      property stlCampOrder: TStringList read FStlCampOrder write FStlCampOrder;
      property strCondicao:  String      read FStrCondicao  write FStrCondicao;
      property strTabela:    String      read FStrTabela    write FStrTabela;
      property strTitulo:    String      read FStrTitulo    write FStrTitulo;
      property strNomeForm:  String      read FStrNomeForm  write FStrNomeForm;
   end;

implementation

constructor TConsultaModel.Create(stlCampos, stlNomesCol, stlCampOrder: TStringList;
  strCondicao, strTabela, strTitulo, strNomeForm: String);
begin
  Self.FStlCampos    := stlCampos;
  Self.FStlNomesCol  := stlNomesCol;
  Self.FStlCampOrder := stlCampOrder;
  Self.FStrCondicao  := strCondicao;
  Self.FStrTabela    := strTabela;
  Self.FStrTitulo    := strTitulo;
  Self.FStrNomeForm  := strNomeForm;
end;

end.
